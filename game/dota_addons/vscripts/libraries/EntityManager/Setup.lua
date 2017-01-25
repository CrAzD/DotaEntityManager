

require('libraries/EntityManager/Manager')
if EntityManager == nil then
    _G.EntityManager = EntityManagerInitialization(class({}))
else
    _G.EntityManager = EntityManagerInitialization(EntityManager)
end
local manager = EntityManager

-- Information about the library
manager['version'] = 0.53
manager['url'] = 'https://github.com/CrAzD/DotaEntityManager'
manager['description'] = 'This library optimizes, and scopes entities. The main way of optimization is by storing everything inside the entity upon creation. Therefore eliminating function overhead (calling funcitons a million times for no reason).'

-- General setup and configuration
manager['entity'] = GameRules:GetGameModeEntity()
manager['ent'] = manager['entity']

manager['indexed'] = {}
manager['entities'] = {}
manager['users'] = {}
manager['players'] = {}

-- KV file loading and initialization
manager['kv'] = {
    ['abilities'] = LoadKeyValues('scripts/npc/npc_abilities_custom.txt'),
    ['heroes'] = LoadKeyValues('scripts/npc/npc_heroes_custom.txt'),
    ['units'] = LoadKeyValues('scripts/npc/npc_units_custom.txt'),
    ['entities'] = {}
}
local kvTables = {['units'] = 'units', ['heroes'] = 'heroes'}
for _, kvTable in pairs(kvTables) do
    for key, value in pairs(manager['kv'][kvTable]) do
        manager['kv']['entities'][key] = value or nil
    end
end

-- Messages and info spam
print('\n\nEntityManager:  Initialization complete...'..
    '\n\tVersion:  '..tostring(manager['version'])..
    '\n\tURL:  '..manager['url']..
    '\n\tDescription:  '..manager['description']..
    '\n'
)