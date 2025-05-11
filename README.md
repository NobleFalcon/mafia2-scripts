# Mafia II Complete Lua API Reference

## Table of Contents
- [Core Objects](#core-objects)
- [Scripting Buffers](#scripting-buffers)
- [Game](#game)
- [GUI](#gui)
- [HUD](#hud)
- [Navigation](#navigation)
- [Player](#player)
- [Vehicles](#vehicles)
- [Entity Management](#entity-management)
- [AI & Police](#ai--police)
- [Camera](#camera)
- [Traffic](#traffic)
- [Radio](#radio)
- [Math](#math)
- [Datastore](#datastore)
- [Weather & Graphics](#weather--graphics)
- [Shop](#shop)
- [Wardrobe](#wardrobe)
- [Special Objects](#special-objects)
- [Examples](#examples)

## Core Objects
```lua
-- Essential object references
player = game.game:GetActivePlayer()           -- Get player object
vehicle = player:GetOwner()                    -- Get vehicle player is in
entity = game.entitywrapper:GetEntityByName("entity_name")  -- Get entity by name
entityByGuid = game.entitywrapper:GetEntityByGUID(guid)     -- Get entity by GUID
```

## Scripting Buffers
```lua
-- DelayBuffer: Execute function after delay or repeatedly
DelayBuffer:Insert(fn, args, delay_ms, iterations, async)
-- Example: DelayBuffer:Insert(myFunction, nil, 250, 1, false)
-- iterations = -1 runs endlessly; async = true keeps ticking while coroutine is suspended
DelayBuffer:Remove(fn, args, delay_ms, iterations, async)
DelayBuffer:IsInBuffer(fn) --> bool
DelayBuffer:SwitchDebugging(state)

-- CommandBuffer: Queue commands with tag
CommandBuffer:Insert(tag, {fn1, fn2, ...})
-- Example: CommandBuffer:Insert("mission_start", {function() game.hud:FaderFadeOut(250) end, ...})
CommandBuffer:Remove(tag)
CommandBuffer:IsInBuffer(tag) --> bool
CommandBuffer:RemoveGroup(mask)
CommandBuffer:SwitchDebugging(state)
```

## Game
```lua
-- Player access
player = game.game:GetActivePlayer()

-- Game state
game.game:SaveGame(1)                  -- Save to slot 1
game.game:IsSaveLoadDisabled()         -- Check if save/load disabled
time = game.game:GetMissionTime()      -- Get mission time
game.game:AddScore(true, 1000)         -- Add score
game.game:CountStatisticItem(id)       -- Count statistic
game.game:SetCurrentStoryId(id)        -- Set story ID
game.game:DisableTranslocator(true)    -- Load/unload environment objects

-- Audio
game.game:PlayMusic("m04_Escape_music", true, 1, 1, 1)  -- Play music (name, loop, vol, fade, priority)
game.game:StopMusic("m04_Escape_music", true, 1, 1, 1)  -- Stop music
game.game:SoundFadeIn(250)             -- Fade in audio (ms)
game.game:SoundFadeOut(250)            -- Fade out audio (ms)

-- Player model
game.game:ChangePlayerModel("vitvez", -1)  -- Change player model (modelName, colorID)
game.game:ChangePlayerModelByShopID(id)    -- Change player model by shop ID
game.game:GetPlayerModelShopID()           -- Get player model shop ID

-- Entity creation
game.game:CreateScriptActorAction()        -- Create scripted action
game.game:CreateScriptActorActionBox()     -- Create action box
game.game:CreateFoodActorAction()          -- Create food action
game.game:CreateSuitActorAction()          -- Create suit action
game.game:CreateWeaponActorAction()        -- Create weapon action
game.game:CreateAmmoActorAction()          -- Create ammo action
game.game:CreateCleanEntity()              -- Create clean entity
game.game:CreateBlocker()                  -- Create blocker

-- Misc functions
game.game:AwardMedal(enums.Medals.NIGHT_SHIFT)  -- Award medal
game.game:AwardDLCMedal(id)                -- Award DLC medal
game.game:IsDeadHumanInside()              -- Check if dead human inside
game.game:MassActivate()                   -- Mass activate entities
game.game:MassDeactivate()                 -- Mass deactivate entities
game.game:IsPointInView()                  -- Check if point in view
game.game:GetPlatform()                    -- Get platform
```

## GUI
```lua
-- Mission screens
game.gui:ShowMissionIntroScreen(id1, id2, id3)  -- Show mission intro (title, subtitle, description)

-- Question/menu screens
game.gui:SetQuestionParameters(timeout_ms, default_btn)  -- Set timeout and default button
game.gui:ShowQuestionScreen2(id0, id1, btn1, id2, btn2)  -- 2-option menu
game.gui:ShowQuestionScreen3(id0, id1, btn1, id2, btn2, id3, btn3)  -- 3-option menu
game.gui:ShowQuestionScreen4(id0, id1, btn1, id2, btn2, id3, btn3, id4, btn4)  -- 4-option menu
response = game.gui:GetQuestionScreenAnswer()  -- Get menu response (1-4)
game.gui:QuestionScreenClose(do_fade)          -- Force close question screen

-- Dialog screens
game.gui:DialogScreenShow2(id1, id2, btnOK, btnCancel)  -- Show dialog screen
game.gui:TutorialDialogShow2(tex_dds, id1, id2, btnOK, btnCancel)  -- Show tutorial dialog
game.gui:ShowQuestDialog(gui_img, id1, id2, id3)  -- Show quest dialog with image

-- Game control
game.gui:IsTutorialModeEnabled() --> bool       -- Check if tutorial mode enabled
game.gui:SetGameOverReasonId(reason)            -- Set fail reason (0=mission fail, 1=arrested, 2=dead)
game.gui:GameEnd(fade)                          -- End game/mission
game.gui:GameEndFake(fade)                      -- Fake game end
game.gui:GameEndCutsceneSO(state)               -- End game with cutscene

-- UI elements
game.gui:OpenMap(show_gps)                      -- Open map
game.gui:UnlockArtworks(show_msg)               -- Unlock artworks
game.gui:RunCarcyclopedia(show)                 -- Open car encyclopedia
game.gui:Pause(state)                           -- Pause game
game.gui:DeactivateMainMenu(state)              -- Deactivate main menu
game.gui:ActivateAPEXResults(state)             -- Activate APEX results
game.gui:ShowSecretCode(state)                  -- Show secret code
```

## HUD
```lua
-- Show/hide HUD elements
game.hud:Show(show)                     -- Show/hide full HUD (0=hide, 1=show)
game.hud:RadarShow(show)                -- Show/hide radar
game.hud:ScoreShow(show)                -- Show/hide score
game.hud:SubtitlesShow(show)            -- Show/hide subtitles
game.hud:SpeedometerShow(show)          -- Show/hide speedometer
game.hud:ActionButtonsShow(show)        -- Show/hide action buttons
game.hud:MessageAreaShow(show)          -- Show/hide message area
game.hud:InfoAreaShow(show)             -- Show/hide info area
game.hud:DarkPlaceIndicatorShow(show)   -- Show/hide dark place indicator
game.hud:MoneyShow(show)                -- Show/hide money
game.hud:RespectShow(show)              -- Show/hide respect

-- Messages
game.hud:MessageShowQuick(id_text, delay_sec)  -- Show message (text_id, duration_seconds)
game.hud:HelpHintShowQuick(id_text, delay_sec) -- Show help hint (text_id, duration_seconds)
game.hud:HelpHintHide()                        -- Hide help hint
game.hud:DebugHint(id_text)                    -- Show debug hint
game.hud:ForceSubtitlesUp(force)               -- Force subtitles up

-- Screen effects
game.hud:FaderFadeOut(ms)                      -- Fade screen out (ms)
game.hud:FaderFadeIn(ms)                       -- Fade screen in (ms)
game.hud:FaderFadeOutEx(rgba, ms)              -- Extended fade out with color
game.hud:FaderFadeInEx(rgba, ms)               -- Extended fade in with color
game.hud:EffectAlcoholHit()                    -- Alcohol hit effect
game.hud:EffectAlcoholDrunk(intensity)         -- Drunk effect (0-100)
game.hud:EffectAlcoholLimits(min, max)         -- Set alcohol limits
game.hud:ShowLowHealthFX(show)                 -- Show low health effect

-- Police
game.hud:PoliceWantedSet(level)                -- Set wanted level (stars 0-5)
game.hud:PoliceRelationSet(rel)                -- Set police relation

-- Timer
game.hud:TimerShow(show)                       -- Show/hide timer
game.hud:TimerSet(seconds)                     -- Set timer seconds
game.hud:TimerStart()                          -- Start timer
game.hud:TimerStop()                           -- Stop timer
isRunning = game.hud:TimerIsRunning() --> bool -- Check if timer running
coef = game.hud:TimerGetDiffCoef() --> float   -- Get timer difference coefficient
timeLeft = game.hud:TimerGetTime() --> float   -- Get remaining time

-- Hints
game.hud:CreateHint(position, id_text, icon, duration, flag)  -- Create hint
-- position: 0-4, icon: 0-3 for positions 1-4
game.hud:DestroyHint()                         -- Destroy hint
game.hud:ShowHint()                            -- Show hint
game.hud:HideHint()                            -- Hide hint
```

## Navigation
```lua
-- Map
game.navigation:SetMapResource("mapa_city")  -- Set map resource (options: mapa_city, mapa_prison, mapa_residence, mapa_triads)

-- Map markers
objectiveId = game.navigation:RegisterObjectivePos(x, y, objective_id)  -- Add objective marker
objectiveId = game.navigation:RegisterObjectiveEntity(entity_guid)     -- Register objective entity
objectiveId = game.navigation:RegisterObjectiveOnShop(shop_id)         -- Register objective on shop
game.navigation:RegisterIconPos(name, desc, icon_type, icon_sub, guid, visible)  -- Add icon
game.navigation:RegisterIconEntity(entity_name, group, layer, guid, visible)     -- Mark entity
game.navigation:RegisterHumanEntity(entity_name)                               -- Register human entity

-- Unregistering
game.navigation:UnregisterObjectivePos(obj_id)         -- Remove objective
game.navigation:UnregisterObjectiveEntity(entity)      -- Unregister objective entity
game.navigation:UnregisterObjectiveOnShop(shop)        -- Unregister objective shop
game.navigation:UnregisterIconPos(id)                  -- Remove icon
game.navigation:UnregisterIconEntity(entity_name, group, layer, guid, visible)  -- Unregister entity icon
game.navigation:UnregisterId(id)                       -- Unregister by ID
id = game.navigation:GetIdByEntityName(name)           -- Get ID by entity name

-- GPS
game.navigation:SetTargetForGPS(obj_id)                -- Set GPS target
game.navigation:SetFakeTargetForGPS(obj_id)            -- Set fake GPS target
game.navigation:GetTargetForGPS() --> obj_id           -- Get current GPS target

-- Map appearance
game.navigation:SetBackgroundColor(col)                -- Set background color
game.navigation:SetBackgroundCustomColor(r, g, b, a)   -- Set custom background color
game.navigation:SetBackgroundType(type)                -- Set background type
game.navigation:GetBackgroundType() --> type           -- Get background type
game.navigation:SetForegroundColor(col)                -- Set foreground color
game.navigation:SetForegroundCustomColor(r, g, b, a)   -- Set custom foreground color 
game.navigation:SetForegroundType(type)                -- Set foreground type
game.navigation:GetForegroundType() --> type           -- Get foreground type
game.navigation:SetScale(scale)                        -- Set map scale
game.navigation:SetPos(vec3)                           -- Set map position
game.navigation:SetHeight(height)                      -- Set map height
game.navigation:GetHeight() --> height                 -- Get map height

-- Misc
game.navigation:GetNearestShop() --> shop_id           -- Get nearest shop
game.navigation:GetNearestShopByType(type) --> shop_id -- Get nearest shop by type
game.navigation:EnableFarVisibility(state)             -- Enable far visibility
game.navigation:DisableFarVisibility()                 -- Disable far visibility
game.navigation:SetGPSGroup(group)                     -- Set GPS group
game.navigation:GetGPSGroup() --> group                -- Get GPS group
```

## Datastore
```lua
-- Check variables
game.datastore:IsVariableExist(key) --> bool           -- Check if variable exists
game.datastore:GetVariableType(key) --> enum.VarType   -- Get variable type
game.datastore:SetVariableTemporary(key, state)        -- Set variable as temporary
game.datastore:IsVariableTemporary(key) --> bool       -- Check if variable is temporary
game.datastore:DelVariable(key)                        -- Delete variable
game.datastore:ClearTemporaryVariables()               -- Clear all temporary variables

-- Boolean values
game.datastore:SetBool(key, value)                     -- Store boolean
value = game.datastore:GetBool(key)                    -- Get boolean

-- Numeric values
game.datastore:SetNumber(key, value)                   -- Store number
value = game.datastore:GetNumber(key)                  -- Get number

-- String values
game.datastore:SetString(key, value)                   -- Store string
value = game.datastore:GetString(key)                  -- Get string

-- Advanced types
game.datastore:GetVector(key) --> vec3                 -- Get vector
game.datastore:SetVector(key, vec3)                    -- Set vector
game.datastore:GetGuid(key) --> guid                   -- Get GUID
game.datastore:SetGuid(key, guid)                      -- Set GUID
```

## Player
```lua
-- Get player object
player = game.game:GetActivePlayer()

-- Controls
player:GetControlStyle() --> style                     -- Get control style
player:SetControlStyle(enums.ControlStyle.LOCKED)      -- Lock controls (FREE or LOCKED)
player:AreControlsLocked() --> bool                    -- Check if controls locked
player:LockControls(lock, flag)                        -- Lock controls
player:LockControlsToPlayAnim(lock)                    -- Lock controls for animation
player:SetControlStyleStr("CS_DISTILLERY")             -- Set control style string
player:GetControlStyleStr() --> str                    -- Get control style string

-- Inventory (Weapons)
player:InventoryAddWeapon(id, ammo)                    -- Add weapon
player:InventoryAddAmmo(id, ammo)                      -- Add ammo
player:InventoryRemoveWeapon(id, ammo)                 -- Remove weapon
player:InventoryGetSelected() --> id                   -- Get selected weapon
player:InventorySelect(id, flag)                       -- Select weapon (bring to hand)
player:InventoryArmed() --> bool                       -- Check if armed
player:InventoryHolster()                              -- Holster weapon
player:HaveWeapon(id) --> bool                         -- Check if has weapon
player:InventoryCanAddWeapon(id) --> bool              -- Check if can add weapon
player:InventoryCanAddAmmo(id) --> bool                -- Check if can add ammo
player:InventoryHowMuchAmmoCanAdd(id) --> amount       -- Check how much ammo can add
player:InventoryDrop()                                 -- Drop current weapon
player:InventorySetUnlimitedAmmo(state)                -- Set unlimited ammo
player:InventoryReload(id, ammo)                       -- Reload weapon

-- Inventory (Items)
player:InventoryAddItem(id)                            -- Add item
player:InventoryAddItems(items)                        -- Add multiple items
player:InventoryRemoveItem(id)                         -- Remove item
player:InventoryHaveItem(id) --> bool                  -- Check if has item

-- Money
player:InventoryGetMoney() --> amount                  -- Get money
player:InventoryAddMoney(amount)                       -- Add money
player:InventoryRemoveMoney(amount)                    -- Remove money

-- Weapon status checks
player:HaveEmptyHand() --> bool                        -- Check if hands empty
player:HaveFireWeaponInHand() --> bool                 -- Check if holding firearm
player:HaveColdWeaponInHand() --> bool                 -- Check if holding melee weapon
player:HaveThrowingWeaponInHand() --> bool             -- Check if holding throwable
player:ClearItemsInHands()                             -- Clear items in hands

-- Throwing
player:ThrowItem()                                     -- Throw current item
player:ThrowMolotov()                                  -- Throw molotov
player:ThrowGrenade()                                  -- Throw grenade

-- Movement
player:MoveEnt(entity, "WALK")                         -- Move to entity (WALK or RUN)
player:MoveVec(Math:newVector(x, y, z), "WALK")        -- Move to position (WALK or RUN)
player:MoveNav(nav_point)                              -- Move to navigation point
player:Follow(target, speed, min_dist, max_dist, flag) -- Follow character
player:FollowBattle(target, speed, min_dist, max_dist, factor) -- Follow in battle
player:FollowOffset(offset)                            -- Set follow offset
player:MoveToArea(area_id)                             -- Move to area
player:EnableSuspiciousMove(state)                     -- Enable suspicious movement
player:DisableSuspiciousMove(state)                    -- Disable suspicious movement
player:SetCanTraverse(state)                           -- Set can traverse
player:GetCanTraverse() --> bool                       -- Get can traverse
player:ScriptControl(state)                            -- Enable script control

-- Panic behavior
player:PanicCrouch(level)                              -- Panic crouch (0-4)
player:PanicRunAway(from_pos, to_pos)                  -- Run away in panic

-- Status checks
player:IsDeath() --> bool                              -- Check if dead
player:DespawnImmunity(time)                           -- Set despawn immunity
player:GetPhysState() --> state                        -- Get physics state
player:SetPhysState(enums.PhysicsState.DYNAMIC)        -- Set physics state (DYNAMIC/ENABLE/DISABLED/KINEMATIC)

-- Combat
player:Attack(target)                                  -- Attack character
player:SetAggressivity(level)                          -- Set aggressivity (0-4 or enums.AI_Aggressivity.*)
player:GetAggressivity() --> level                     -- Get aggressivity
player:EnableInjury(state)                             -- Enable injury
player.invulnerability = true                          -- Set invulnerability
player:SetDemigod(state)                               -- Set demigod mode
player:SetAttackMode(mode)                             -- Set attack mode
player:EnableAttackFromAnim(state)                     -- Enable attack from animation

-- Combat states
player:HoldFire()                                      -- Hold fire
player:FreeFire()                                      -- Free fire
player:HoldCloseCombat()                               -- Hold close combat
player:FreeCloseCombat()                               -- Free close combat
player:Fightguard(target)                              -- Guard fight position
player:CoverFightguard(target)                         -- Guard from cover
player:SetFightInStand(state)                          -- Set fight in stand
player:SetFightInCrouch(state)                         -- Set fight in crouch

-- Cover system
player:TakeCover(cover_id)                             -- Take cover
player:TakeCoverAdvanced(params)                       -- Take cover advanced
player:TakeCoverAdvancedID(id1, side1, id2, side2, offset, flag) -- Take cover with IDs
player:IsInCover() --> bool                            -- Check if in cover
player:SearchCover(params)                             -- Search for cover
player:IsCoverCrouch() --> bool                        -- Check if crouching in cover

-- Vehicle interaction
player:GetInOutCar(vehicle, seat, flag1, flag2)        -- Enter/exit vehicle
player:GetOutCarFast(flag)                             -- Quickly exit vehicle
player:MakeCarOwnership(vehicle)                       -- Take ownership of vehicle
player:SetCarAttackPermission(state)                   -- Allow car attacks
player:SetCarAttackGetOutPermission(state)             -- Allow getting out to attack

-- Animation
player:AnimPlay(anim_name, loop)                       -- Play animation
player:AnimIsFinished() --> bool                       -- Check if animation finished
player:AnimStop()                                      -- Stop animation
player:AnimPlayEffect(effect, state)                   -- Play animation effect
player:AnimEffectStop()                                -- Stop animation effect
player:AnimPlaySync(anim)                              -- Play synchronized animation
player:AnimPlayDummy(anim)                             -- Play dummy animation
player:SetAnimStyle(style, variant)                    -- Set animation style (melee/panic/common)
player:AnimationReset()                                -- Reset animation

-- Speech
player:DoTalk(target, line_id)                         -- Make player talk
player:DoTalkAI(talk_type)                             -- AI talk
player:BlockSpeech(block)                              -- Block speech
player:ShutUp()                                        -- Stop talking
player:GetSpeechSituationsCount() --> count            -- Get speech situation count

-- Look & aim controls
player:SetLookPointOfInterest(state)                   -- Set look point of interest
player:IsLookPointOfInterest() --> bool                -- Check if looking at point of interest
player:LookAt(target)                                  -- Look at target
player:LookAtDir(dir)                                  -- Look in direction
player:LookAtAngles(angles)                            -- Look at angles
player:StartLookByTarget(target)                       -- Start looking at target
player:StartLookByAngles(angles)                       -- Start looking at angles
player:ChangeLookTarget(target)                        -- Change look target
player:ChangeLookAngles(angles)                        -- Change look angles
player:EndLook()                                       -- End looking
player:SetLookStyle(style)                             -- Set look style
player:TurnAt(target)                                  -- Turn to target
player:TurnAtVec(vec)                                  -- Turn to vector
player:TurnAtDir(dir)                                  -- Turn to direction

-- Aiming and shooting
player:Aim(state)                                      -- Aim weapon
player:AimAt(target)                                   -- Aim at target
player:ShootAt(target)                                 -- Shoot at target
player:ShootEffect(effect)                             -- Shoot visual effect
player:ShootSimulation(sim)                            -- Shoot simulation

-- Fighting mechanics
player:SetDamageMultiplier(mult)                       -- Set damage multiplier
player:SetBlockMultiplier(mult)                        -- Set block multiplier
player:MeleePreferLights(state)                        -- Prefer light attacks
player:MeleePreferHards(state)                         -- Prefer hard attacks
player:MeleePreferCounter(state)                       -- Prefer counters
player:MeleePreferCounterCounter(state)                -- Prefer counter-counters
player:SetMeleeArchetype(type)                         -- Set melee archetype

-- Appearance
player:SetHumanColor(color_id)                         -- Set clothing color (0-9)
player:GetHumanColor() --> color_id                    -- Get clothing color
player:ShowModel(state)                                -- Show/hide model
player:IsModelVisible() --> bool                       -- Check if model visible
player:ShowHat(state)                                  -- Show hat
player:DropHat()                                       -- Drop hat
player:ChangeModel(model)                              -- Change model
player:HasModel(model) --> bool                        -- Check if has model

-- Model interactions
player:ModelToHands(state, hand, item_id)              -- Put model in hands (1=right, 2=left)
player:ModelToMouth(model)                             -- Put model in mouth
player:RegisterActorItem(item)                         -- Register actor item
player:UnregisterActorItem(item)                       -- Unregister actor item
player:UnregisterActorItems()                          -- Unregister all actor items
player:IsActorItemRegistered(item) --> bool            -- Check if item registered
player:ActorItemToHands(item)                          -- Put actor item in hands

-- Body interactions
player:TakeBody(body)                                  -- Take/grab body
player:DropBody()                                      -- Drop body
player:EnableDragBody(state)                           -- Enable dragging bodies
player:EnableStealthKill(state)                        -- Enable stealth kill
player:EnablePushByPlayer(state)                       -- Enable pushing by player
player:EnableBounceByPlayer(state)                     -- Enable bouncing by player

-- Special abilities
player:EnableMeleeGenericSpeech(state)                 -- Enable melee speech
player:DisableMeleeGenericSpeech()                     -- Disable melee speech
player:SetStealthMove(state)                           -- Set stealth movement
player:IsStealthMove() --> bool                        -- Check if in stealth mode
player:SetDrunk(level)                                 -- Set drunk level
player:EnableBloodParticles(state)                     -- Enable blood particles
player:ForceBloodPool(state)                           -- Force blood pool
player:CustomLockpick(target)                          -- Custom lockpicking

-- Misc functions
player:GetOppositePosRot() --> pos                     -- Get opposite position/rotation
player:Forget(target)                                  -- Forget target
player:Spawn(state)                                    -- Spawn player
```

## Vehicles
```lua
-- Get current vehicle
vehicle = game.game:GetActivePlayer():GetOwner()

-- Speed and movement
vehicle:SetSpeed(speed)                                -- Set speed
speed = vehicle:GetSpeed()                             -- Get speed (int)
speed = vehicle:GetSpeedFloat()                        -- Get speed (float)
vehicle:GetSpeedLimiter() --> limiter                  -- Get speed limiter
vehicle:SetSpeedLimiter(limiter)                       -- Set speed limiter
vehicle:SetSpeedLimiterSpeed(speed)                    -- Set speed limit
vehicle:GetSpeedLimiterSpeed() --> speed               -- Get speed limit
vehicle:SetMaxAISpeed(speed)                           -- Set max AI speed

-- Damage and repair
damage = vehicle:GetDamage()                           -- Get damage
motorDamage = vehicle:GetMotorDamage()                 -- Get motor damage
vehicle:SetMotorDamage(damage)                         -- Set motor damage (0-100)
vehicle:Repair(flag)                                   -- Repair vehicle
vehicle:RepairAndClear(flag)                           -- Repair and clear vehicle
price = vehicle:GetRepairPrice()                       -- Get repair price
vehicle:SetCarDamage(damage)                           -- Set car damage
vehicle:Explode()                                      -- Explode vehicle

-- Tuning
level = vehicle:GetActualTuningTable()                 -- Get tuning level
vehicle:SetActualTuningTable(level)                    -- Set tuning level (0-3)
hasTuning = vehicle:HasTuningTable()                   -- Check if has tuning
hasTuningFlag = vehicle:HasTuningFlag()                -- Check if has tuning flag
hasTableFlag = vehicle:HasTableFlag()                  -- Check if has table flag
hasRacingFlag = vehicle:HasRacingFlag()                -- Check if has racing flag
price = vehicle:GetPrice()                             -- Get vehicle price
vehicle:AddSpendedMoney(amount)                        -- Add spent money

-- Vehicle access
vehicle:Lock()                                         -- Lock vehicle (movement)
vehicle:Unlock()                                       -- Unlock vehicle
vehicle:LockEntryPoints()                              -- Lock doors
vehicle:UnlockEntryPoints()                            -- Unlock doors
vehicle:LockPlayerEntryPoints()                        -- Lock player entry
vehicle:UnlockPlayerEntryPoints()                      -- Unlock player entry
vehicle:FakePlayerCar(state)                           -- Set as fake player car

-- Vehicle parts
vehicle:OpenHood()                                     -- Open hood
vehicle:CloseHood()                                    -- Close hood
vehicle:OpenTrunk()                                    -- Open trunk
vehicle:CloseTrunk()                                   -- Close trunk
vehicle:LockTrunks()                                   -- Lock trunks
vehicle:UnlockTrunks()                                 -- Unlock trunks
vehicle:OpenBusDoors(state)                            -- Open bus doors
vehicle:SetDoorFree(door_id)                           -- Set door free

-- Appearance
vehicle:SetDirty(level)                                -- Set dirt level (0.0-1.0)
dirtyLevel = vehicle:GetDirty()                        -- Get dirt level
vehicle:HideGore(state)                                -- Hide gore
vehicle:HideDecals(state)                              -- Hide decals
vehicle:SetColor(color1, color2)                       -- Set color (1-40)
color = vehicle:GetColor()                             -- Get color
vehicle:SetPainting(model_name)                        -- Set painting/decal
painting = vehicle:GetPainting()                       -- Get painting

-- Fuel
fuel = vehicle:GetActualFuel()                         -- Get fuel level
vehicle:SetActualFuel(level)                           -- Set fuel level (0-100)
capacity = vehicle:GetFuelTankCapacity()               -- Get fuel capacity

-- Engine
vehicle:SetEngineOn(state, flag)                       -- Turn engine on/off
vehicle:Spawn(state)                                   -- Spawn vehicle
vehicle:SetHandbrake(state)                            -- Set handbrake
vehicle:SetBrake(level)                                -- Set brake
vehicle:SetPower(power)                                -- Set power
vehicle:SetAddSteer(steer)                             -- Set steering (-100 to 100)
rotations = vehicle:GetEngineRotations()               -- Get engine RPM

-- AI control
vehicle:CreateController(type)                         -- Create AI controller (car_escaper/car_hunter/car_police/car_scripted)
vehicle:DestroyController()                            -- Destroy AI controller
vehicle:InitializeAIParams(profile, level)             -- Set AI behavior (enums.CarAIProfile.*)
vehicle:HuntCar(target)                                -- Hunt another car
vehicle:HuntMode(enums.CarHuntMode.ALONG)              -- Set hunt mode
vehicle:HuntPause(state)                               -- Pause hunting
vehicle:MoveTo(pos, turn_mode, pass_mode)              -- Move to position (enums.MoveToUTurn.*, enums.MoveToPass.*)
vehicle:EnableAccidentReaction(state)                  -- Enable accident reaction
vehicle:FollowTrail(trail)                             -- Follow trail
vehicle:FollowTrailReverse(trail)                      -- Follow trail in reverse
vehicle:EscapeMode()                                   -- Set escape mode
vehicle:Wander(radius)                                 -- Wander around
vehicle:WaitForEntity(entity, min, max)                -- Wait for entity
vehicle:CancelWaitForEntity()                          -- Cancel waiting

-- Wheels
wheelPos = vehicle:GetWheelPos(wheel_id)               -- Get wheel position
vehicle:SetWheel(wheel_id, state)                      -- Set wheel
wheel = vehicle:GetWheel(wheel_id)                     -- Get wheel
vehicle:SetTyre(tyre)                                  -- Set tyre
vehicle:SetWheelsProtected(state)                      -- Protect wheels
isProtected = vehicle:IsWheelsProtected()              -- Check if wheels protected

-- Special features
vehicle:RegisterEvents(state)                          -- Register for events
pointW = vehicle:GetPointW()                           -- Get point W (waypoint related)
seatPosW = vehicle:GetSeatAIPosW()                     -- Get seat AI position W
vehicle:GetProhibitGarage() --> state                  -- Get garage prohibition
vehicle:SetProhibitGarage(state)                       -- Set garage prohibition
seatForHuman = vehicle:FindSeatForHuman()              -- Find seat for human
vehicle:SetResistance(resistance)                      -- Set resistance (0-100)
resistance = vehicle:GetResistance()                   -- Get resistance
vehicle:DisableExplosion(state)                        -- Disable explosion
isDisabled = vehicle:IsDisableExplosion()              -- Check if explosion disabled

-- Effects and lights
vehicle:SetBeaconLightOn(state)                        -- Turn on beacon lights
vehicle:SetSirenOn(state)                              -- Turn on siren
vehicle:SetHornOn(state)                               -- Sound horn
vehicle:SetRadioDefaultState(station, state)           -- Set default radio station
vehicle:SetSPZText(text, state)                        -- Set license plate
text = vehicle:GetSPZText()                            -- Get license plate
problem = vehicle:GetCarProblem(id)                    -- Get car problem (0-8)
vehicle:FixCarPos(state)                               -- Fix car position
isFixed = vehicle:IsCarPosFixed()                      -- Check if position fixed

-- Parts
vehicle:SetOffPart(part)                               -- Turn off part
vehicle:SetOnPart(part)                                -- Turn on part
count = vehicle:GetPartCount()                         -- Get part count
name = vehicle:GetPartName(id)                         -- Get part name
part = vehicle:GetPartByName(name)                     -- Get part by name

-- Windows
vehicle:OpenSeatWindow(seat, state, flag)              -- Open seat window (1-4)
isOpen = vehicle:IsSeatWindowOpen(seat)                -- Check if window open
seat = vehicle:GetActualPlayerSeatIndex()              -- Get current player seat

-- Effects
vehicle:ReflectorsForceOff(state)                      -- Force reflectors off
tableId = vehicle:GetCarTableId()                      -- Get car table ID
vehicle:DisableFreeTrunk(state)                        -- Disable free trunk
vehicle:PlayAnim(anim)                                 -- Play animation
vehicle:StopAnim()                                     -- Stop animation
vehicle:RevUpEffectStart()                             -- Start rev effect
vehicle:RevUpEffectStop()                              -- Stop rev effect
vehicle:FadeDirtyEffectStart()                         -- Start dirt fade effect
vehicle:FadeDirtyEffectStop()                          -- Stop dirt fade effect
vehicle:FadeSnowEffectStart()                          -- Start snow fade effect
vehicle:FadeSnowEffectStop()                           -- Stop snow fade effect
vehicle:FadeFuelEffectStart()                          -- Start fuel fade effect
vehicle:FadeFuelEffectStop()                           -- Stop fuel fade effect
vehicle:SPZAdjustingEffectStart()                      -- Start license plate adjust effect
vehicle:SPZAdjustingEffectSet(state)                   -- Set license plate adjust effect
vehicle:SPZAdjustingEffectStop()                       -- Stop license plate adjust effect

-- Misc
vehicle:DisableObstacleByPart(part)                    -- Disable obstacle by part
vehicle:SetDespawnImmunity(state)                      -- Set despawn immunity
vehicle:MarkForSale(state)                             -- Mark for sale
isMarked = vehicle:IsMarkedForSale()                   -- Check if marked for sale
vehicle:LinkToEntity(entity)                           -- Link to entity
vehicle:UnlinkFromEntity()                             -- Unlink from entity

-- UTT events (game statistics tracking)
vehicle:UTTCarRepair()                                 -- Log car repair
vehicle:UTTCarUpgrade()                                -- Log car upgrade
vehicle:UTTCarWheelChange()                            -- Log wheel change
vehicle:UTTCarPaint()                                  -- Log car paint
vehicle:UTTCarAirbrush()                               -- Log airbrush
vehicle:UTTCarPlateChange()                            -- Log plate change
```

## Entity Management
```lua
-- Entity access
entity = game.entitywrapper:GetEntityByName("entity_name")
entity = game.entitywrapper:GetEntityByGUID(guid)

-- Entity state
entity:Activate()                                      -- Activate entity
entity:Deactivate()                                    -- Deactivate entity
entity:GameRestore()                                   -- Restore game state
guid = entity:GetGuid()                                -- Get entity GUID
type = entity:GetType()                                -- Get entity type
isActive = entity:IsActive()                           -- Check if active
isValid = entity:IsValid()                             -- Check if valid

-- Events
entity:RegisterToMessages(guid, event_type, message)   -- Register for events
-- Example: entity:RegisterToMessages(guid, enums.EventType.HUMAN, enums.HumanMessages.DEATH)
entity:UnregisterFromMessages(guid, event_type, message) -- Unregister from events

-- Position and orientation
pos = entity:GetPos()                                  -- Get position
dir = entity:GetDir()                                  -- Get direction
rot = entity:GetRot()                                  -- Get rotation
entity:SetPos(Math:newVector(x, y, z))                 -- Set position
entity:SetDir(Math:newVector(dx, dy, dz))              -- Set direction (-1 to 1)
entity:SetRot(Math:newVector(rx, ry, rz))              -- Set rotation
isVisible = entity:IsVisibleFromCamera()               -- Check if visible from camera

-- Special entity types (doors)
door = game.entitywrapper:GetEntityByName("door_name")
door:Lock()                                            -- Lock door
door:AILock()                                          -- AI lock door
door:Unlock()                                          -- Unlock door
door:AIUnlock()                                        -- AI unlock door
isLocked = door:IsLocked()                             -- Check if locked
door:StartLockpick()                                   -- Start lockpicking
door:StopLockpick()                                    -- Stop lockpicking
isLockpicking = door:IsLockpicking()                   -- Check if lockpicking
door:Kick()                                            -- Kick door
door:Open(pos, flag)                                   -- Open door
door:Close()                                           -- Close door
door:ToggleOpen()                                      -- Toggle door open/closed
isClosed = door:IsClosed()                             -- Check if closed
door:EnableAction()                                    -- Enable door action
door:DisableAction()                                   -- Disable door action
door:PlayAnimNoResistance(anim)                        -- Play animation
door:StopAnim()                                        -- Stop animation

-- Crash objects
crash = game.entitywrapper:GetEntityByName("crash_name")
crash:Explode()                                        -- Explode object
crash:LightEntityLink(link)                            -- Link light entity
crash:Hide()                                           -- Hide object
crash:Show()                                           -- Show object
translate = crash:GetModelTranslate()                  -- Get model translation
crash:PlayAnim(anim)                                   -- Play animation
crash:PlayAnimNoResistance(anim)                       -- Play animation without resistance
crash:PlayAnimLoop(anim)                               -- Play looping animation
crash:PlayAnimNoResistanceLoop(anim)                   -- Play looping animation without resistance
crash:StopAnim()                                       -- Stop animation
crash:PlayBlinkAnim(anim)                              -- Play blinking animation
crash:StopBlinkAnim()                                  -- Stop blinking animation
crash:EnableLight(state)                               -- Enable light
isEnabled = crash:IsLightingEnabled()                  -- Check if light enabled
crash:SetCrashObjectColor(color)                       -- Set crash object color
color = crash:GetCrashObjectColor()                    -- Get crash object color
pos = crash:GetTruePos()                               -- Get true position
crash:SetManagerImmunity(state)                        -- Set manager immunity

-- Light entities
light = game.entitywrapper:GetEntityByName("light_name")
light:SetOn()                                          -- Turn light on
light:SetOff()                                         -- Turn light off
isOn = light:IsOn()                                    -- Check if light is on

-- Particle effects
particle = game.entitywrapper:GetEntityByName("particle_name")
particle:Run()                                         -- Run particle effect
particle:Stop()                                        -- Stop particle effect
particle:StopImmediately()                             -- Stop immediately

-- Radio objects
radio = game.entitywrapper:GetEntityByName("radio_name")
radio:SetStatusOn()                                    -- Turn radio on
radio:SetStatusOff()                                   -- Turn radio off
status = radio:GetStatus()                             -- Get radio status
radio:ChangeStation(station)                           -- Change station
radio:ChangeProgram(program)                           -- Change program
radio:ChangePlaylist(playlist)                         -- Change playlist

-- Telephones
phone = game.entitywrapper:GetEntityByName("phone_name")
phone:StartRinging(state)                              -- Start phone ringing
phone:StopRinging()                                    -- Stop ringing
phone:ShowMenu()                                       -- Show phone menu
isRinging = phone:IsRinging()                          -- Check if ringing
isCalling = phone:IsCalling()                          -- Check if calling
phone:StartSpeech()                                    -- Start speech
phone:Pick()                                           -- Pick up phone
phone:Hang()                                           -- Hang up phone
phone:ChooseRandomNPCNumber()                          -- Choose random NPC number
phone:InterruptCall()                                  -- Interrupt call
phone:OnSpeechReady()                                  -- On speech ready
phone:OnSpeechEnded()                                  -- On speech ended
phone:DoTalk(talk)                                     -- Make talk
phone:DoWait(time)                                     -- Wait
phone:LoadSpeech(speech)                               -- Load speech
phone:UnloadSpeech()                                   -- Unload speech
phone:WaitForDial()                                    -- Wait for dial

-- Jukeboxes
jukebox = game.entitywrapper:GetEntityByName("jukebox_name")
jukebox:PlaySong(song)                                 -- Play song

-- Lifts/elevators
lift = game.entitywrapper:GetEntityByName("lift_name")
lift:SetFloor(floor)                                   -- Set floor
floor = lift:GetFloor()                                -- Get floor
lift:EnableActions()                                   -- Enable lift actions
```

## AI & Police
```lua
-- Police behavior
ai.police:CreateOffence(offense_id, player_guid)       -- Create offense
ai.police:DeactivateOffence(offense_id)                -- Deactivate offense
ai.police:DeactivateAllOffences()                      -- Clear all offenses
ai.police:IgnorePerson(guid, state)                    -- Make police ignore person
ai.police:IgnoreRecognition(state)                     -- Ignore recognition

-- Police knowledge
ai.police:SetKnownPerson(player)                       -- Set known person
ai.police:IsPersonKnown(player) --> bool               -- Check if person known
ai.police:SetKnownCar(vehicle)                         -- Set known car
ai.police:ClearKnownCars()                             -- Clear known cars
ai.police:IsCarKnown(vehicle) --> bool                 -- Check if car known
ai.police:HasActiveOffence() --> bool                  -- Check for active offense
ai.police:IsInSearchMode() --> bool                    -- Check if in search mode

-- Police behavior
ai.police:SetDensity(level)                            -- Set police density
ai.police:GetDensity() --> level                       -- Get police density
ai.police:SetDensityMax(level)                         -- Set max police density
ai.police:StopCloseCombat()                            -- Stop close combat
ai.police:StopCarSearch()                              -- Stop car search
ai.police:TurnPoliceTutorial(state)                    -- Turn police tutorial
ai.police:SolveOffence(offense)                        -- Solve offense
ai.police:SetRoadBlockStatus(status)                   -- Set roadblock status
ai.police:GetRoadBlockStatus() --> status              -- Get roadblock status
ai.police:CreateRoadBlockSpeech()                      -- Create roadblock speech
ai.police:NabonzujPlayera()                            -- ??? Special police function
ai.police:SetActionDone(action)                        -- Set action done
ai.police:GetNumberOfPolicemenInAction() --> count     -- Get policemen in action
ai.police:GetFineValue() --> value                     -- Get fine value
ai.police:PoliceUTTWriteSimple()                       -- Police UTT simple log

-- AI relationships
ai.relationships:SetRelationship(side1, type1, side2, type2, level)  -- Set relationship
-- Example: ai.relationships:SetRelationship(enums.AI_SIDE.NEUTRAL, enums.AI_TYPE.SELLER, 
--                                          enums.AI_SIDE.PLAYER, enums.AI_TYPE.FRIEND, 10)
ai.relationships:GetRelationship(side1, type1, side2, type2) --> level  -- Get relationship
ai.relationships:SetPlayerAggressivity(level)          -- Set player aggressivity

-- Gang groups
groupId = ai.relationships:CreateGangGroup()           -- Create gang group
ai.relationships:DestroyGangGroup(group_id)            -- Destroy gang group
ai.relationships:AddGroupMember(group_id, member)      -- Add group member
ai.relationships:RemoveGroupMember(group_id, member)   -- Remove group member

-- Player interactions
isAttacked = ai.relationships:IsPlayerAttacked()       -- Check if player attacked
isAttacked = ai.relationships:IsPlayerAttackedRanged(range)  -- Check if player attacked in range
ai.relationships:ForgetPlayer()                        -- Make AI forget player
ai.relationships:IgnorePlayer(state)                   -- Make AI ignore player
ai.relationships:ForgetHuman(human)                    -- Make AI forget human
```

## Camera
```lua
-- Get camera
camera = game.cameramanager:GetPlayerMainCamera(0)     -- Get main camera (0=main)
smallCam = game.cameramanager:GetPlayerSmallCamera()   -- Get small camera

-- Camera control
camera:LockSetActor(actor, mode)                       -- Lock camera to actor
camera:LockLookAt(target)                              -- Lock camera look at
camera:LockLookAtEntity(entity, player, speed)         -- Lock camera look at entity
camera:LockDialog(dialog)                              -- Lock camera for dialog
camera:Unlock(target)                                  -- Unlock camera

-- Camera effects
camera:SimpleShake(speed, strength, duration)          -- Shake camera
camera:SetCameraRotation(pos)                          -- Set camera rotation

-- First person view
camera:EnableFPV(player, state)                        -- Enable first person view
camera:LockControl(state, flag)                        -- Lock camera control
camera:SetSensitivityMultiplier(multiplier)            -- Set sensitivity
```

## Traffic
```lua
-- Traffic control
game.traffic:SwitchGenerators(state)                   -- Enable/disable traffic generation
game.traffic:Populate(density)                         -- Set traffic density (0-100)
game.traffic:PoliceReinforcements(amount)              -- Set police reinforcements
game.traffic:OpenSeason(amount)                        -- Open traffic season
game.traffic:CloseSeason()                             -- Close traffic season
game.traffic:SetPolice(state)                          -- Enable/disable police cars
game.traffic:DespawnPolice(state)                      -- Remove police cars

-- Road blocking
game.traffic:SwitchRoad(pos, state)                    -- Block/unblock road
game.traffic:SwitchFarAmbient(state)                   -- Switch far ambient traffic

-- Traffic density
game.traffic:SetNumCars(amount)                        -- Set number of cars (0-100)
game.traffic:SetNumStaticCars(amount)                  -- Set number of static cars
game.traffic:SetNoAmbientRadius(radius)                -- Set no ambient radius
game.traffic:SetFarAmbientRadius(radius)               -- Set far ambient radius

-- Pathfinding
game.traffic:PathFindEnableMiddlePoint(state)          -- Enable pathfinding middle points
game.traffic:PathFindReset()                           -- Reset pathfinding
```

## Radio
```lua
-- Radio content
game.radio:SetContent(station, program, content)       -- Set station content
-- Example: game.radio:SetContent("Empire", "all", "Empire_07010")

-- Player radio
game.radio:ForceDefaultStation(station)                -- Set default station
game.radio:SwitchPlayerStation(station)                -- Switch player's station
game.radio:TurnPlayerRadioOn(state)                    -- Turn radio on
game.radio:TurnPlayerRadioOff(state)                   -- Turn radio off
isOn = game.radio:IsPlayerRadioOn()                    -- Check if radio on
game.radio:FadePlayerRadioOut(ms)                      -- Fade radio out (ms)

-- Misc
game.radio:SetDialogMode(mode)                         -- Set dialog mode
game.radio:AdvanceTime()                               -- Skip to next song
```

## Math
```lua
-- Vector creation and math
vector = Math:newVector(x, y, z)                       -- Create new vector
matrix = Math:newMatrix()                              -- Create new matrix
quat = Math:newQuat()                                  -- Create new quaternion
random = Math:Random(min, max)                         -- Random number in range

-- Vector methods
vector:zero()                                          -- Set to zero
dot = vector:dotProduct(other)                         -- Dot product
vector:set(x, y, z)                                    -- Set values
vector:setVec(other)                                   -- Copy from other vector
x, y, z = vector:get()                                 -- Get components
mag = vector:magnitude()                               -- Get magnitude
mag2 = vector:magnitude2()                             -- Get squared magnitude
vector:normalize()                                     -- Normalize vector

-- Matrix methods
matrix:setPos(pos)                                     -- Set position
matrix:addPos(pos)                                     -- Add position
matrix:setDir(dir)                                     -- Set direction
matrix:setDirUp(dir, up)                               -- Set direction and up
matrix:setRotEuler(euler)                              -- Set rotation from Euler
matrix:zero()                                          -- Set to zero

-- Quaternion methods
quat:zero()                                            -- Set to zero
matrix = quat:makeMatrix()                             -- Convert to matrix
quat:normalize()                                       -- Normalize quaternion
```

## Weather & Graphics
```lua
-- Weather control
game.gfx:SetGarbageFlyingOn(state)                     -- Enable flying garbage
game.gfx:SetWeatherDateTime(date, time)                -- Set weather date/time
game.gfx:SetWeatherTemplate(template)                  -- Set weather template
-- Templates: DTFreeRideDay, DTFreeRideDayRain, DTFreerideNight, DTFreeRideDaySnow, DTFreeRideDayWinter, DTFreeRideNightSnow
game.gfx:IsTheWeatherLike(template) --> bool           -- Check if weather matches template
game.gfx:GetDayTime() --> time                         -- Get day time

-- Highlighting
game.highlighting:AddHighlighting(entity)              -- Add highlighting to entity
game.highlighting:RemoveHighlighting(entity)           -- Remove highlighting
game.highlighting:SetPrinterSpeed(speed)               -- Set printer speed
```

## Shop
```lua
-- Shop menus
game.shop:OpenShopMenu(menu)                           -- Open shop menu
game.shop:OpenShopMenuOnFrame(menu, frame)             -- Open shop menu on frame
game.shop:CloseOpenedMenu()                            -- Close open menu
game.shop:HideModelInItem(item)                        -- Hide model in item

-- Shop status
game.shop:IsShopActivated() --> bool                   -- Check if shop activated
game.shop:GetActiveShopBaseFrameName() --> name        -- Get active shop frame name
game.shop:SetFlagInActiveShop(flag, state)             -- Set flag in active shop
game.shop:GetFlagInActiveShop(flag) --> state          -- Get flag in active shop
game.shop:SetActiveShopState(state)                    -- Set active shop state
game.shop:GetActiveShopState() --> state               -- Get active shop state

-- Shop discovery
game.shop:SetActiveShopExplored(state)                 -- Set active shop as explored
game.shop:SetShopExplored(shop, state)                 -- Set shop as explored
game.shop:SetAllShopExplored()                         -- Set all shops as explored

-- Shop items
game.shop:SetMenuItemEnable(item, state)               -- Enable/disable menu item
game.shop:SetMenuItemVisible(item, state)              -- Set menu item visibility
game.shop:SetMenuItemPrice(item, price)                -- Set menu item price
game.shop:ShowItem(item)                               -- Show item
game.shop:SetPlayerMoneyVisible(state)                 -- Show/hide player money
game.shop:SetPlayerWantedStatusVisible(state)          -- Show/hide player wanted status
game.shop:SetCarWantedStatusVisible(state)             -- Show/hide car wanted status

-- Tuning
game.shop:SetTuningLevel(level)                        -- Set tuning level
game.shop:SetActiveCar(car)                            -- Set active car
game.shop:IsEntityOwnedByShop(entity) --> bool         -- Check if entity owned by shop

-- Statistics tracking
game.shop:UTTShopStart()                               -- Track shop start
game.shop:UTTShopEnd()                                 -- Track shop end
game.shop:UTTShopPurchase()                            -- Track purchase
game.shop:UTTShopCrime()                               -- Track shop crime
game.shop:UTTShopMoneyRobbed()                         -- Track money robbed
```

## Wardrobe
```lua
-- Suit management
game.wardrobe:AddSuit(model_name, color_id, own)       -- Add suit (color 0-9)
game.wardrobe:RemoveSuit(model_name)                   -- Remove suit
game.wardrobe:RemoveAllSuits()                         -- Remove all suits
game.wardrobe:AddDLCSuits()                            -- Add DLC suits
game.wardrobe:SetWanted(model_name)                    -- Set wanted suit
game.wardrobe:ClearAllWanted()                         -- Clear all wanted
```

## Special Objects
```lua
-- SDS (streaming data system)
game.sds:ActivateStreamMapLine(name)                   -- Activate stream map line
game.sds:GetSyncObjectForLoadSDS(name)                 -- Get sync object for load
game.sds:GetSyncObjectForUnloadSDS(name)               -- Get sync object for unload
game.sds:LoadCityShop(shop)                            -- Load city shop
game.sds:ReleaseCityShop(shop)                         -- Release city shop
game.sds:LoadCityPart(part)                            -- Load city part
game.sds:ReleaseCityPart(part)                         -- Release city part

-- Speech
game.speech:LoadScriptDistrict(district)               -- Load script district
game.speech:UnLoadScriptDistrict(district)             -- Unload script district
game.speech:LoadDistrictVarious(type)                  -- Load district speech
-- Types: APDGangBlack, APDGangIrish, APDGangItalian, APDGangGreaser, APDCivMale, APDCivFemale, etc.
game.speech:UnLoadDistrictVarious(type)                -- Unload district speech
game.speech:IsDistrictVariousLoaded(district) --> bool -- Check if district loaded
game.speech:LoadStage(stage)                           -- Load speech stage

-- Garage
game.garage:GetMaxGaragePlaces() --> count             -- Get max garage places
game.garage:SetMaxGaragePlaces(count)                  -- Set max garage places
game.garage:GetPlayersCar() --> guid                   -- Get player's car
game.garage:HasCar(car) --> bool                       -- Check if car in garage
game.garage:AddCar(car)                                -- Add car to garage
game.garage:RemoveCar(car)                             -- Remove car from garage
game.garage:AbandonCar(car)                            -- Abandon car
game.garage:KeepSpawnedOnlyPlayersCar()                -- Keep only player's car
game.garage:DespawnAll()                               -- Despawn all cars
game.garage:CheatAddCar(name, owned)                   -- Add car (cheat)
game.garage:CheatAddCarColor(color)                    -- Add car with color (cheat)
game.garage:CheatAddCars(owned)                        -- Add all cars (cheat)
game.garage:CheatAbandonCars()                         -- Abandon all cars (cheat)

-- Phonebook
game.phonebook:AddNumber(number)                       -- Add phone number
game.phonebook:AddHiddenNumber(number)                 -- Add hidden number
game.phonebook:RemoveNumber(number)                    -- Remove number
game.phonebook:RemoveNumberByTextId(id)                -- Remove number by text ID
game.phonebook:Clear()                                 -- Clear phonebook
game.phonebook:ContainsNumber(number) --> bool         -- Check if contains number

-- Base script machine
base.ScriptMachine:getScriptGuid()                     -- Get script GUID
base.ScriptMachine:ComposeAnd(a, b)                    -- Compose AND
base.ScriptMachine:ComposeOr(a, b)                     -- Compose OR
base.ScriptMachine:ComposeNeg(a)                       -- Compose NOT
base.ScriptMachine:SetEvent(event)                     -- Set event
base.ScriptMachine:PostMultiMessage(msg)               -- Post multiple messages
base.ScriptMachine:PostMessage(msg)                    -- Post message
base.ScriptMachine:RegisterScriptForMachineMessages(script) -- Register for messages
base.ScriptMachine:UnregisterScriptFromMachineMessages(script) -- Unregister from messages
base.ScriptMachine:PostMachineMessage(msg)             -- Post machine message
base.ScriptMachine:UnregisterFromAllMessages()         -- Unregister from all messages
base.ScriptMachine:CreateSyncObject()                  -- Create sync object
base.ScriptMachine:print(text)                         -- Print debug text
base.ScriptMachine:clear()                             -- Clear debug output
```

## Examples

### Car Repair Function
```lua
function RepairCar()
    local car = game.game:GetActivePlayer():GetOwner()
    car:RepairAndClear()
    car:SetMotorDamage(0)
    game.hud:MessageShowQuick("CAR_REPAIRED", 2)
end

DelayBuffer:Insert(RepairCar, nil, 250, 1, false)
```

### Speed Boost Function
```lua
local speedBoost = 30

function setCarSpeed()
    local car = game.game:GetActivePlayer():GetOwner()
    local carSpeed = car:GetSpeedFloat() + speedBoost
    car:SetSpeed(carSpeed)
end

DelayBuffer:Insert(setCarSpeed, nil, 50, 1, false)
```

### God Mode Toggle
```lua
function ToggleGodMode()
    local player = game.game:GetActivePlayer()
    if player.invulnerability then
        player:SetDemigod(false)
        player:EnableInjury(true)
        player.invulnerability = false
        game.hud:MessageShowQuick("GOD_MODE_OFF", 2)
    else
        player:SetDemigod(true)
        player:EnableInjury(false)
        player.invulnerability = true
        game.hud:MessageShowQuick("GOD_MODE_ON", 2)
    end
end

DelayBuffer:Insert(ToggleGodMode, nil, 250, 1, false)
```

### Give All Weapons
```lua
function giveGuns()
    local weapons = {
        { ID = 2, ammo = 42 },   -- Model_12_Revolver
        { ID = 3, ammo = 60 },   -- Mauser_C96
        { ID = 4, ammo = 56 },   -- Colt_M1911A1
        { ID = 5, ammo = 92 },   -- Colt_M1911_Special
        { ID = 6, ammo = 42 },   -- Model_19_Revolver
        { ID = 8, ammo = 56 },   -- Remington_Model_870_Field_gun
        { ID = 9, ammo = 120 },  -- M3_Grease_Gun
        { ID = 10, ammo = 128 }, -- MP40
        { ID = 11, ammo = 200 }, -- Thompson_1928
        { ID = 12, ammo = 120 }, -- M1A1_Thompson
        { ID = 13, ammo = 120 }, -- Beretta_Model_38A
        { ID = 15, ammo = 40 },  -- M1_Garand
        { ID = 17, ammo = 35 },  -- Kar98k
        { ID = 20, ammo = 6 },   -- MK2_Frag_Grenade
        { ID = 21, ammo = 6 }    -- Molotov_Cocktail
    }
    
    local player = game.game:GetActivePlayer()
    for _, weapon in pairs(weapons) do
        player:InventoryAddWeapon(weapon.ID, weapon.ammo)
        player:InventoryReload(weapon.ID, weapon.ammo)
    end
    
    game.hud:MessageShowQuick("WEAPONS_ADDED", 2)
end

DelayBuffer:Insert(giveGuns, nil, 250, 1, false)
```

### Remove Wanted Level
```lua
function removeWarrant()
    ai.police:ClearKnownCars()
    ai.police:SetKnownPerson(game.game:GetActivePlayer())
    ai.police:IgnorePerson(game.game:GetActivePlayer():GetGuid(), true)
    game.hud:MessageShowQuick("WARRANT_REMOVED", 2)
}

DelayBuffer:Insert(removeWarrant, nil, 250, 1, false)
```

### Simple UI Menu
```lua
function showMenu()
    game.gui:ShowQuestionScreen4(
        "3455000410",    -- "Choose Option" text_id
        "3455000411", 1, -- "Repair Car" text_id
        "3455000412", 2, -- "Get Weapons" text_id
        "3455000413", 3, -- "Remove Wanted Level" text_id
        "3455000414", 4  -- "Exit" text_id
    )
    
    local selection = game.gui:GetQuestionScreenAnswer()
    if selection == 1 then 
        RepairCar() 
    elseif selection == 2 then 
        giveGuns() 
    elseif selection == 3 then 
        removeWarrant() 
    end
end

DelayBuffer:Insert(showMenu, nil, 250, 1, false)
```

### Change Weather
```lua
function changeWeather(template)
    game.gfx:SetWeatherTemplate(template)
    game.hud:MessageShowQuick("WEATHER_CHANGED", 2)
end

-- Call with: changeWeather("DTFreeRideDayRain")
-- Options: DTFreeRideDay, DTFreeRideDayRain, DTFreerideNight, DTFreeRideDaySnow, DTFreeRideDayWinter, DTFreeRideNightSnow
```

### Start Mission Sequence
```lua
function startMission()
    -- Fade out
    game.hud:FaderFadeOut(250)
    game.game:SoundFadeOut(250)
    
    -- Set player position
    local player = game.game:GetActivePlayer()
    player:SetPos(Math:newVector(1261, 1169, 0.5))
    
    -- Show intro screen
    game.gui:ShowMissionIntroScreen("MISSION_TITLE", "MISSION_SUBTITLE", "MISSION_DESCRIPTION")
    
    -- Load area and set weather
    game.sds:ActivateStreamMapLine("dlc02_storage_load")
    game.gfx:SetWeatherTemplate("DTFreeRideDay")
    
    -- Add objective
    local objId = game.navigation:RegisterObjectivePos(1270, 1180, 1)
    game.navigation:SetTargetForGPS(objId)
    
    -- Fade in
    game.hud:FaderFadeIn(250)
    game.game:SoundFadeIn(250)
    
    -- Show message
    game.hud:MessageShowQuick("MISSION_START", 3)
}

DelayBuffer:Insert(startMission, nil, 250, 1, false)
```
