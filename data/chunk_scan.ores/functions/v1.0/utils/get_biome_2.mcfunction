
execute unless data entity @s Item.tag{biome_id:"unknown"} run data modify storage chunk_scan.ores:generation biome set from entity @s Item.tag.biome_id
execute if data entity @s Item.tag{biome_id:"unknown"} run function #chunk_scan.ores:v1/custom_biomes
kill @s
