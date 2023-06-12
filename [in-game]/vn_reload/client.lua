local noReloadGuns = { [25]=true, [33]=true, [34]=true, [35]=true, [36]=true, [37]=true }
savedAmmo = { }

function weaponAmmo(prevSlot, currSlot)
	cleanupUI()
	-- store the previous weapons ammo
	savedAmmo[prevSlot] = { }
	savedAmmo[prevSlot][1] = getPedWeapon(source, prevSlot) -- Store the weapon ID
	savedAmmo[prevSlot][2] = getPedAmmoInClip(source, prevSlot) -- Store the weapon's ammo in clip

	-- give the ammo for the current (new) weapon
	if (savedAmmo[currSlot]~=nil) then -- could be a new gun - we may not have stored ammo for it yet
		
		local weapon = savedAmmo[currSlot][1]
		local ammoInClip = savedAmmo[currSlot][2]
		
		if (weapon==getPedWeapon(source)) and (weapon>21) and (weapon<35) and not (noReloadGuns[weapon]) then -- The gun has not changed, don't want to give ammo for a different gun
			local ammo = getPedTotalAmmo(source)
			triggerServerEvent("giveWeaponOnSwitch", getLocalPlayer(), weapon, ammo, ammoInClip)
			disableAutoReload(weapon, ammo, ammoInClip)
		end
	end
end
addEventHandler("onClientPlayerWeaponSwitch", getLocalPlayer(), weaponAmmo)

function disableAutoReload(weapon, ammo, ammoInClip)
	if (ammoInClip==1) and ((ammo-ammoInClip)>0) and not (noReloadGuns[weapon]) and (weapon>21) and (weapon<35) then
		-- Message to reload
		addEventHandler("onClientRender", getRootElement(), drawText)
		
		-- this bullet cant be fired and will prevent the reload event from firing off within the SA client
		toggleControl("fire", false)
		setTimer(toggleControl, 100, 1, "fire", false)
		triggerServerEvent("addFakeBullet", getLocalPlayer(), weapon, ammo)
	else
		cleanupUI()
	end
end
addEventHandler("onClientPedWeaponFire", getLocalPlayer(), disableAutoReload)

function drawText()
	local scrWidth, scrHeight = guiGetScreenSize()
end

function cleanupUI()
	removeEventHandler("onClientRender", getRootElement(), drawText)
end
addEvent("cleanupUI", true)
addEventHandler("cleanupUI", getRootElement(), cleanupUI)