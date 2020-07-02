# NoKore Mods

These are mods for NoKore styled games, they try to close to no depedency on 'core' or 'default' features.

Most of these are copies or rewrites of minetest_game mods.

## Mod Convention

* `nokore_world_*`

  'world' mods add new base material nodes to the game.

* `nokore_biome_*`

  'biome' mods build upon world mods to add worldgen that utilize the nodes added by the world

## Goal

The goal of the NoKore mods project is to create a framework and base for building games in minetest, mods will attempt to be granular allowing players and developers alike to build their own experience.

For example nodes are decoupled from their worldgen and biomes, instead nokore provides various biome mods that will build upon the world mod's nodes
