# qb-spawnselector
i add my magic on it ;)

*

last location : 
https://www.youtube.com/watch?v=T-gNq3MhG70

*

spawn button :
![image](https://user-images.githubusercontent.com/89742984/169070700-5e1805a3-e895-4230-804e-2478910b103c.png)

*

how to add it :

go to this line in qb-spawn/client.lua

![image](https://user-images.githubusercontent.com/89742984/169073088-935f1893-5b33-4c03-a57e-d9b5bf6fb056.png)

and replace it with this

``` 
RegisterNetEvent('qb-spawn:client:setupSpawns', function(cData, new, apps)
    if not new then
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "ui",
            status = false
        })
        choosingSpawn = false
            Wait(500)
            TriggerEvent('qb-spawnselector:set')
    elseif new then
        SendNUIMessage({
            action = "setupAppartements",
            locations = apps,
        })
    end
end)
```
