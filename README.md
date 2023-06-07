# qb-spawnselector


- how to install it (this not a full qb-spawn Just a custom spawn selector)

- go to qb-apartments client/main.lua

* go to this event 'apartments:client:setupSpawnUI' and replace it with this

```
RegisterNetEvent('apartments:client:setupSpawnUI', function(cData)
    QBCore.Functions.TriggerCallback('apartments:GetOwnedApartment', function(result)
        if result then
            TriggerEvent('qb-spawn:client:setupSpawns', cData, false, nil)
            TriggerEvent("apartments:client:SetHomeBlip", result.type)
        else
            if Apartments.Starting then
                TriggerEvent('qb-spawn:client:setupSpawns', cData, true, Apartments.Locations)
                TriggerEvent('qb-spawn:client:openUI', true)
            else
                TriggerEvent('qb-spawn:client:setupSpawns', cData, false, nil)
                TriggerEvent('qb-spawn:client:openUI', true)
            end
        end
    end, cData.citizenid)
end)
```

- go to qb-spawn qb-spawn/client.lua

* go to this event 'qb-spawn:client:setupSpawns' and replace it with this
```
RegisterNetEvent('qb-spawn:client:setupSpawns', function(cData, new, apps)
    if not new then
         TriggerEvent('qb-spawnselector:StartSpawnSelector')
    elseif new then
        SendNUIMessage({
            action = "setupAppartements",
            locations = apps,
        })
    end
end)

```
