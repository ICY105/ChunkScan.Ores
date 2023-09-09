# ChunkScan.Ores
An extension if [ChunkScan](https://github.com/ICY105/ChunkScan) that enables generating custom ores via postgen. This library supports:
* Place groups of blocks (ores) in the world at random locations, in the specified ranges.
* Filtering by biome. Supports 3d biomes- filter is based on individual ore vein location.
* Filtering by dimension, including support for custom dimensions. Supports any world height between -2048 - 2048, however world bottom at 0 or -64 are most efficient.
* Compatible with other worldgen, including custom worldgen (like Terralith) and other postgen methods.

This is an embedded library, so you package it inside your datapack as opposed to having a separate download. Requires [LanternLoad](https://github.com/LanternMC/load) and [ChunkScan](https://github.com/ICY105/ChunkScan) to operate.

## Scoreboards
These are scoreboard objectives used to represent a value of some kind.

```
chunk_scan.ores.data
  Used for math and passing variables between functions.
```

## Function Calls
Function calls are called by you to trigger certian events or features.

```
function chunk_scan.ores:v1/api/register_ore
  Call to add an ore to the registry.
  
  Input:
    #registry.min_y chunk_scan.ores.data [-2048,2048]: minimum y value to generate at
    #registry.max_y chunk_scan.ores.data [-2048,2048]: maximum y value to generate at
    #registry.min_veins chunk_scan.ores.data [0,32]: minimum number of veins to generate per chunk
    #registry.max_veins chunk_scan.ores.data [0,32]: maximum number of veins to generate per chunk
    #registry.min_vein_size chunk_scan.ores.data [0,16]: minimum number of ores per vein
    #registry.max_vein_size chunk_scan.ores.data [0,16]: maximum number of ores per vein
    #registry.ignore_restrictions chunk_scan.ores.data [0,1]: if 0, ore will only generate in stone like blocks. 1 for anywhere (even air).

    Optional: add this line to adjust dimension and/or biome whitelist/blacklist.
    Defaults to overworld and no biome restrictions (note- 'minecraft:' prefix is required).
    data modify storage chunk_scan.ores:registry input set value {dimension:"minecraft:overworld", biome:"<biome or biome tag>", biome_blacklist:0b}
	
  Output:
    #registry.result_id chunk_scan.ores.data: Returns -1 if registering ore failed.
    Otherwise, returns generated ore reg ID num.
    Save this number to a score. You will need to later to generate your ore 
    Example: scoreboard players operation <my_ore> <my_objective> = #registry.result_id chunk_scan.ores.data 
```

## Function Tags
Functions tags are called by ChunkScan.Ores to inform you an event has happened, like an ore needs to be placed. To use these calls, you must add a function to the tag list.

```
function #chunk_scan.ores:v1/place_ore
  Executed at the location the ore will be placed.
  Input:
    #gen.id chunk_scan.ores.data -> id of ore to generate. If the id you received
    from registering your ore matches, place it.
    Example: execute if score <my_ore> <my_objective> = #gen.id chunk_scan.ores.data run setblock ~ ~ ~ minecraft:dirt
```

## How to use
1. Install [LanternLoad](https://github.com/LanternMC/load) in your datapack, following its install directions.
1. Install [ChunkScan](https://github.com/ICY105/ChunkScan) in your datapack, following its install directions
2. Copy the `ChunkScan.Ores/data/chunk_scan.ores` folder into your data pack
3. Merge the contents of `ChunkScan.Ores/data/chunk_scan/tags/functions/v2/generate.json` into the file `<your_datapack>/data/chunk_scan/tags/functions/v2/generate.json`
4. Merge the file contents of `ChunkScan.Ores/data/load/tags/functions/*` into the files at `<your_datapack>/data/load/tags/functions/*`
5. Implement the API as described above.

For easier mangament of dependencies, check out my project [Datapack Build Manager](https://github.com/ICY105/DatapackBuildManager).
