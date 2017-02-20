

-- EntityManager
-- By: CrAzD
require('libraries/EntityManager/Manager')
local manager = EntityManagerInitialization(class({}))

-- Information
manager['version'] = 0.64
manager['url'] = 'https://github.com/CrAzD/DotaEntityManager'

-- General setup and configuration
manager['entity'] = GameRules:GetGameModeEntity()
manager['ent'] = manager['entity']

manager['indexed'] = {}
manager['entities'] = {}
manager['players'] = {}

-- KV file loading and initialization
manager['kv'] = {
    ['abilities'] = LoadKeyValues('scripts/npc/npc_abilities_custom.txt'),
    ['heroes'] = LoadKeyValues('scripts/npc/npc_heroes_custom.txt'),
    ['units'] = LoadKeyValues('scripts/npc/npc_units_custom.txt'),
    ['entities'] = {}
}
local kvTables = {['units'] = 'units', ['heroes'] = 'heroes'}
for _, kvTable in pairs({['units'] = 'units', ['heroes'] = 'heroes'}) do
    for key, value in pairs(manager['kv'][kvTable]) do
        manager['kv']['entities'][key] = value or nil
    end
end

-- Messages and info spam
print('\nEntityManager:  Initialization complete...'..
    '\n\tVersion:  '..tostring(manager['version'])..
    '\n\tURL:  '..manager['url']
)

return(manager)