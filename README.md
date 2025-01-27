# qb-spawnselector

❗❗THIS IS NOT A FULLY SPAWN THIS IS JUST A SPAWNS SELECTOR ❗❗

- how to install it 

- [1] go to qb-apartments client/main.lua

* [2] go to 'apartments:client:setupSpawnUI' and (replace) it with this

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

- [1] go to qb-spawn qb-spawn/client.lua

* [2] go to 'qb-spawn:client:setupSpawns' and (replace) it with this
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
![image](https://github.com/krrm1/qb-spawnselector/assets/89742984/cd673113-3856-4f36-8fd2-23c2a5af3d15)
