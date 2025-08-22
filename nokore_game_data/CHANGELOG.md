# 0.9.0

* Changed `KVStore#increment/2` and `KVStore#decrement/2` return values, they now return the value and self instead of just self
* Fixed `KVStore#increment/2` and `KVStore#decrement/2` not marking store as dirty

# 0.8.0

* Added `KVStore#clear_dirty/0`

# 0.7.0

* Added `KVStore#put_all/1`
