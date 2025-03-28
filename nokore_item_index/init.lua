--[[

  Item Indexing Service.

  Indexes all items at load time to improve search and filter functions.

]]
local mod = foundation.new_module("nokore_item_index", "0.1.0")

local string_split = assert(foundation.com.string_split)
local list_reject = assert(foundation.com.list_reject)

mod.normalized_terms = {}
mod.registered_items = {}

--- @spec parse_terms(String): String[]
function mod.parse_terms(filter)
  local terms = string_split(filter:lower(), " ")
  return list_reject(terms, function (value)
    return value == ""
  end)
end

--- @private.spec has_all_terms(entry: Table, filter: String[]): Boolean
local function has_all_terms(entry, filter)
  for _,term in ipairs(filter) do
    if entry.name:find(term, 1, true) or
       entry.description:find(term, 1, true) then
      --
    else
      return false
    end
  end
  return true
end

--- @private.spec next_filtered(filter: String[], index: Integer): (index: Integer, item_name: String)
local function next_filtered(filter, index)
  local entry
  local item_name
  local matches = false
  while true do
    index = index + 1
    item_name = mod.registered_items[index]
    if item_name then
      entry = mod.normalized_terms[item_name]
      matches = false
      if has_all_terms(entry, filter) then
        return index, item_name
      end
    else
      return nil
    end
  end
end

--- @spec filter_items(filter: String): Iterator => (index: Integer, item_name: String)
function mod.filter_items(filter)
  local terms = mod.parse_terms(filter)

  if next(terms) then
    return next_filtered, terms, 0
  else
    return ipairs(mod.registered_items)
  end
end

local function on_mods_loaded()
  local normalized_terms = mod.normalized_terms
  local registered_item_names = mod.registered_items
  local i = 0
  local should_include = false
  for name,def in pairs(core.registered_items) do
    should_include = true
    if def.groups and
       def.groups.not_in_creative_inventory and
       def.groups.not_in_creative_inventory > 0 then
      should_include = false
    end

    if name == "" then
      should_include = false
    end

    if should_include then
      i = i + 1
      registered_item_names[i] = name
      normalized_terms[name] = {
        name = name:lower(),
        description = (def.description or ""):lower(),
      }
    end
  end
  table.sort(registered_item_names)
end

core.register_on_mods_loaded(on_mods_loaded)
