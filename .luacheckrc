max_line_length = 100

-- unused args do not matter
unused_args = false

globals = {
  --
  -- Classes
  --
  ItemStack = {},
  VoxelArea = {
    fields = {
      new = {},
    },
  },

  --
  -- Modules
  --
  table = {
    fields = {
      copy = {},
    },
  },
  vector = {
    fields = {
      --
      -- Functions
      --
      add = {},
      copy = {},
      new = {},
      subtract = {},
    },
  },
  --
  -- Foundation
  --
  foundation = {
    fields = {
      --
      -- Modules
      --
      com = {
        fields = {
          --
          -- Modules
          --
          Cuboid = {},
          Directions = {},
          Groups = {},
          InventorySerializer = {},
          Vector3 = {},
          binary_types = {
            fields = {
              MarshallValue = {},
            },
          },
          formspec = {
            fields = {
              api = {
                fields = {},
              },
            },
          },
          schematic_helpers = {
            fields = {
              build = {},
              from_y_slices = {},
              Builder = {},
            },
          },
          --
          -- Classes
          --
          BinaryBuffer = {
            fields = {
              new = {},
            },
          },
          ByteBuf = {
            fields = {
              little = {},
              big = {},
            },
          },
          Class = {
            fields = {
              extends = {},
            },
          },
          FileBuffer = {
            fields = {
              new = {},
            },
          },
          Luna = {
            fields = {
              new = {},
            },
          },
          RingBuffer = {
            fields = {
              new = {},
            },
          },
          StringBuffer = {
            fields = {
              new = {},
            },
          },
          Trace = {
            fields = {
              new = {},
            },
          },
          WeightedList = {
            fields = {
              new = {},
            },
          },

          --
          -- Instances
          --
          node_sounds = {},

          --
          -- Functions
          --
          ascii_file_pack = {},
          ascii_file_unpack = {},
          is_blank = {},
          get_inventory_drops = {},
          table_copy = {},
          table_deep_copy = {},
          table_key_of = {},
          table_merge = {},
          table_deep_merge = {},
          path_join = {},
          path_dirname = {},
        },
      },

      --
      -- Functions
      --
      is_module_present = {},
      new_module = {},
    },
  },
  --
  -- Mintest
  --
  minetest = {
    fields = {
      --
      -- Constants
      --
      PLAYER_MAX_HP_DEFAULT = {},
      PLAYER_MAX_BREATH_DEFAULT = {},
      LIGHT_MAX = {},

      --
      -- Properties
      --
      registered_items = {
        fields = {
          ["?"] = {},
        },
      },
      registered_nodes = {
        fields = {
          ["?"] = {},
        },
      },

      --
      -- Functions
      --
      add_entity = {},
      chat_send_player = {},
      check_for_falling = {},
      clear_registered_biomes = {},
      clear_registered_decorations = {},
      clear_registered_ores = {},
      create_detached_inventory = {},
      deserialize = {},
      dir_to_facedir = {},
      formspec_escape = {},
      get_connected_players = {},
      get_item_group = {},
      get_meta = {},
      get_name_from_content_id = {},
      get_node = {},
      get_node_or_nil = {},
      get_objects_inside_radius = {},
      get_player_by_name = {},
      get_voxel_manip = {},
      get_worldpath = {},
      hash_node_position = {},
      hud_replace_builtin = {},
      is_creative_enabled = {},
      is_protected = {},
      item_place = {},
      item_place_node = {},
      log = {},
      mkdir = {},
      node_dig = {},
      node_punch = {},
      parse_json = {},
      pointed_thing_to_face_pos = {},
      pos_to_string = {},
      raillike_group = {},
      record_protection_violation = {},
      register_abm = {},
      register_alias = {},
      register_biome = {},
      register_chatcommand = {},
      register_craft = {},
      register_craftitem = {},
      register_decoration = {},
      register_entity = {},
      register_globalstep = {},
      register_item = {},
      register_lbm = {},
      register_node = {},
      register_on_joinplayer = {},
      register_on_leaveplayer = {},
      register_on_mods_loaded = {},
      register_on_player_receive_fields = {},
      register_on_shutdown = {},
      register_ore = {},
      remove_detached_inventory = {},
      remove_node = {},
      rotate_node = {},
      safe_file_write = {},
      serialize = {},
      serialize_schematic = {},
      set_node = {},
      show_formspec = {},
      sound_play = {},
      string_to_pos = {},
      swap_node = {},
      write_json = {},
    },
  },
  --
  -- Nokore
  --
  nokore = {
    fields = {
      --
      -- Modules
      --
      node_sounds = {
        fields = {
          build = {},
          register = {},
        },
      },
      rails = {
        fields = {
          --
          -- Functions
          --
          register_rail_node = {},
          build_rail_groups = {},
          is_rail_at_pos = {},
        }
      },

      --
      -- Classes
      --
      BlockDataService = {
        fields = {
          new = {},
        },
      },
      FormspecBindings = {
        fields = {
          new = {},
        },
      },
      KVStore = {
        fields = {
          new = {},
          instance_class = {
            fields = {
              apack_dump = {},
              marshall_dump = {},
            },
          },
        },
      },
      PlayerDataService = {
        fields = {
          new = {},
        },
      },
      PlayerService = {
        fields = {
          new = {},
        },
      },
      TreasureRegistry = {
        fields = {
          new = {},
        },
      },
      --
      -- Instances
      --
      block_data_service = {
        fields = {
          method = {},
        },
      },
      formspec_bindings = {
        fields = {
          method = {},
          show_formspec = {},
        },
      },
      treasure = {
        fields = {},
      },
      player_data_service = {
        fields = {
          method = {},
        },
      },
      player_hud = {
        fields = {
          --
          -- Constants
          --
          DIRECTION_LEFT_RIGHT = {},

          --
          -- Functions
          --
          init_player_hud_elements = {},
          register_hud_element = {},
          remove_player_hud_elements = {},
        },
      },
      player_service = {
        fields = {
          method = {},
          register_after_player_join = {},
          register_on_player_join = {},
          register_on_player_leave = {},
        },
      },
      player_stats = {
        fields = {
          method = {},
        },
      },
      --
      -- Functions
      --
      make_tool_cap_times = {},
      make_tool_capability = {},
      dig_class = {},
      register_stockpile = {},
    },
  },
  --
  -- Mods
  --
  dye = {
    fields = {
      dyes = {},
    },
  },

  nokore_mapgen = {
    fields = {
      tree_seed = {},
    },
  },
  nokore_player_inv = {
    fields = {
      --
      -- Properties
      --
      player_hotbar_size = {},
      --
      -- Functions
      --
      player_inventory_lists_fragment = {},
      player_inventory_size2 = {},
      register_player_inventory_tab = {},
    },
  },
  nokore_proxy = {
    fields = {
      register_globalstep = {},
    },
  },
  nokore_sieve = {
    fields = {
      S = {},
      register_node = {},
    },
  },
  nokore_world_standard = {},
  nokore_stairs = {
    fields = {
      build_and_register_nodes = {},
    },
  },
}

files["nokore_apple/**/*.lua"] = { globals = {"nokore_apple"} }
files["nokore_backpacks/**/*.lua"] = { globals = {"nokore_backpacks"} }
files["nokore_bed/**/*.lua"] = { globals = {"nokore_bed"} }
files["nokore_bookshelf/**/*.lua"] = { globals = {"nokore_bookshelf"} }
files["nokore_chest/**/*.lua"] = { globals = {"nokore_chest"} }
files["nokore_door/**/*.lua"] = { globals = {"nokore_door"} }
files["nokore_dye/**/*.lua"] = { globals = {"nokore_dye"} }
files["nokore_furnace/**/*.lua"] = { globals = {"nokore_furnace"} }
files["nokore_game_data/**/*.lua"] = { globals = {"nokore_game_data"} }
files["nokore_glass/**/*.lua"] = { globals = {"nokore_glass"} }
files["nokore_player_hud/**/*.lua"] = { globals = {"nokore_player_hud"} }
files["nokore_player_inv/**/*.lua"] = { globals = {"nokore_player_inv"} }
files["nokore_player_stats/**/*.lua"] = { globals = {"nokore_player_stats"} }
files["nokore_player_service/**/*.lua"] = { globals = {"nokore_player_service"} }
files["nokore_rail/**/*.lua"] = { globals = {"nokore_rail"} }
files["nokore_stockpile/**/*.lua"] = { globals = {"nokore_stockpile"} }
files["nokore_treasure/**/*.lua"] = { globals = {"nokore_treasure"} }
files["nokore_wool/**/*.lua"] = { globals = {"nokore_wool"} }
files["nokore_wool_mat/**/*.lua"] = { globals = {"nokore_wool_mat"} }
files["nokore_world_bamboo/**/*.lua"] = { globals = {"nokore_world_bamboo"} }
files["nokore_world_bone/**/*.lua"] = { globals = {"nokore_world_bone"} }
files["nokore_world_cactus/**/*.lua"] = { globals = {"nokore_world_cactus"} }
files["nokore_world_clay/**/*.lua"] = { globals = {"nokore_world_clay"} }
files["nokore_world_copper/**/*.lua"] = { globals = {"nokore_world_copper"} }
files["nokore_world_coral/**/*.lua"] = { globals = {"nokore_world_coral"} }
files["nokore_world_cobweb/**/*.lua"] = { globals = {"nokore_world_cobweb"} }
files["nokore_world_coal/**/*.lua"] = { globals = {"nokore_world_coal"} }
files["nokore_world_fern/**/*.lua"] = { globals = {"nokore_world_fern"} }
files["nokore_world_flower/**/*.lua"] = { globals = {"nokore_world_flower"} }
files["nokore_world_giant_mushroom/**/*.lua"] = { globals = {"nokore_world_giant_mushroom"} }
files["nokore_world_gold/**/*.lua"] = { globals = {"nokore_world_gold"} }
files["nokore_world_iron/**/*.lua"] = { globals = {"nokore_world_iron"} }
files["nokore_world_lava/**/*.lua"] = { globals = {"nokore_world_lava"} }
files["nokore_world_melon/**/*.lua"] = { globals = {"nokore_world_melon"} }
files["nokore_world_pumpkin/**/*.lua"] = { globals = {"nokore_world_pumpkin"} }
files["nokore_world_quartz/**/*.lua"] = { globals = {"nokore_world_quartz"} }
files["nokore_world_reed/**/*.lua"] = { globals = {"nokore_world_reed"} }
files["nokore_world_snow/**/*.lua"] = { globals = {"nokore_world_snow"} }
files["nokore_world_standard/**/*.lua"] = { globals = {"nokore_world_standard"} }
files["nokore_world_steel/**/*.lua"] = { globals = {"nokore_world_steel"} }
files["nokore_world_tin/**/*.lua"] = { globals = {"nokore_world_tin"} }
files["nokore_world_tree_acacia/**/*.lua"] = { globals = {"nokore_world_tree_acacia"} }
files["nokore_world_tree_big_oak/**/*.lua"] = { globals = {"nokore_world_tree_big_oak"} }
files["nokore_world_tree_birch/**/*.lua"] = { globals = {"nokore_world_tree_birch"} }
files["nokore_world_tree_fir/**/*.lua"] = { globals = {"nokore_world_tree_fir"} }
files["nokore_world_tree_jungle/**/*.lua"] = { globals = {"nokore_world_tree_jungle"} }
files["nokore_world_tree_oak/**/*.lua"] = { globals = {"nokore_world_tree_oak"} }
files["nokore_world_tree_sakura/**/*.lua"] = { globals = {"nokore_world_tree_sakura"} }
files["nokore_world_tree_spruce/**/*.lua"] = { globals = {"nokore_world_tree_spruce"} }
files["nokore_world_tree_willow/**/*.lua"] = { globals = {"nokore_world_tree_willow"} }
files["nokore_world_vine/**/*.lua"] = { globals = {"nokore_world_vine"} }
files["nokore_world_water/**/*.lua"] = { globals = {"nokore_world_water"} }
files["nokore_world_waterlily/**/*.lua"] = { globals = {"nokore_world_waterlily"} }
