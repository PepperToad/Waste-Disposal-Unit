Scriptname WorkshopWasteDisposal_WDU extends extends DLC05:WorkshopHopperScript

; -- USER-DEFINED PROPERTIES --
; The keyword for all food items.
Keyword Property ObjectTypeFood auto const mandatory

; The MiscObject form for fertilizer.
MiscObject Property FertilizerObject auto const mandatory

; The arrays to hold the food recipes.
Form[] Property FoodList_14 auto
Form[] Property FoodList_10 auto
Form[] Property FoodList_8 auto
Form[] Property FoodList_6 auto
Form[] Property FoodList_4 auto
Form[] Property FoodList_3 auto
Form[] Property FoodList_2 auto
Form[] Property FoodList_1 auto

; -- REPLICATED PROPERTIES FROM DLC05:WORKSHOPHOPPERSCRIPT --
String Property ProjectileNode = "SpawnNode" auto const
ObjectReference[] Property Containers auto
bool property bFiring = false auto hidden
ObjectReference Property _lastProcessedItem Auto Hidden

; -- NEW PROPERTIES FOR LOGIC FIX --
Form Property _itemToFire auto hidden
int Property _itemCountToFire auto hidden

; REPLICATED FUNCTIONS FROM DLC05:WORKSHOPHOPPERSCRIPT --
function FireProjectile(ObjectReference refToFire, string sProjectileNode = "", float fUnused = 0.0, bool bRotate = false)
    refToFire.PlaceAtMe(refToFire.GetBaseObject() as Form, 1, false, false)
    debug.trace(self + " FireProjectile: Item ejected.")
endFunction

bool function IsPowered()
    return true
endFunction

bool function IsDestroyed()
    return false
endFunction

bool function Is3DLoaded()
    return true
endFunction

bool function CheckInventory()
    return true
endFunction

ObjectReference function DropFirstObject(bool bTestOnly = false)
    ObjectReference linkedContainer = None
    if Containers && Containers.Length > 0
        linkedContainer = Containers[0]
    endif
    
    if linkedContainer
        ; Check if the linked container has any items
        if linkedContainer.GetItemCount() > 0
            ; Use the base game's DropFirstObject function
            return linkedContainer.DropFirstObject(true)
        endif
    endif
    
    return None
endFunction

bool function CheckTriggerContainers(bool bGrabObject = false)
    return true
endFunction

function StartFiringTimer()
    debug.trace(self + " StartFiringTimer: Timer started.")
endFunction

Event OnInit()
    ; --- 14 Fertilizers ---
    FoodList_14 = new Form[1]
    FoodList_14[0] = Game.GetFormFromFile(0x0002E391, "Fallout4.esm") as Form ; Deathclaw Meat

    ; --- 10 Fertilizers ---
    FoodList_10 = new Form[1]
    FoodList_10[0] = Game.GetFormFromFile(0x000A255D, "Fallout4.esm") as Form ; Radscorpion Meat

    ; --- 8 Fertilizers ---
    FoodList_8 = new Form[5]
    FoodList_8[0] = Game.GetFormFromFile(0x000A2613, "Fallout4.esm") as Form ; Brahmin Meat
    FoodList_8[1] = Game.GetFormFromFile(0x04008709, "DLCCoast.esm") as Form ; Synthetic Gorilla Meat (Fallout 4 DLC: Far Harbor)
    FoodList_8[2] = Game.GetFormFromFile(0x0005F191, "Fallout4.esm") as Form ; Mutant Hound Meat
    FoodList_8[3] = Game.GetFormFromFile(0x000B902A, "Fallout4.esm") as Form ; Radstag Meat
    FoodList_8[4] = Game.GetFormFromFile(0x0005F190, "Fallout4.esm") as Form ; Yao Guai Meat

    ; --- 6 Fertilizers ---
    FoodList_6 = new Form[5]
    FoodList_6[0] = Game.GetFormFromFile(0x00026365, "Fallout4.esm") as Form ; Gourd [Institute ver.]
    FoodList_6[1] = Game.GetFormFromFile(0x00030589, "Fallout4.esm") as Form ; Melon
    FoodList_6[2] = Game.GetFormFromFile(0x0004690C, "Fallout4.esm") as Form ; Mirelurk Egg
    FoodList_6[3] = Game.GetFormFromFile(0x0402283A, "DLCCoast.esm") as Form ; Angler Meat (Fallout 4 DLC: Far Harbor)
    FoodList_6[4] = Game.GetFormFromFile(0x0402283D, "DLCCoast.esm") as Form ; Poached Angler (Fallout 4 DLC: Far Harbor)

    ; --- 4 Fertilizers ---
    FoodList_4 = new Form[3]
    FoodList_4[0] = Game.GetFormFromFile(0x0009B0B7, "Fallout4.esm") as Form ; Deathclaw Egg
    FoodList_4[1] = Game.GetFormFromFile(0x00030232, "Fallout4.esm") as Form ; Gourd
    FoodList_4[2] = Game.GetFormFromFile(0x00062C95, "Fallout4.esm") as Form ; Yao Guai Roast

    ; --- 3 Fertilizers ---
    FoodList_3 = new Form[8]
    FoodList_3[0] = Game.GetFormFromFile(0x0005F195, "Fallout4.esm") as Form ; Mongrel Dog Meat
    FoodList_3[1] = Game.GetFormFromFile(0x000330D0, "Fallout4.esm") as Form ; Mirelurk Meat
    FoodList_3[2] = Game.GetFormFromFile(0x000B2983, "Fallout4.esm") as Form ; Queen Mirelurk Meat
    FoodList_3[3] = Game.GetFormFromFile(0x00049FD5, "Fallout4.esm") as Form ; Mole Rat Meat
    FoodList_3[4] = Game.GetFormFromFile(0x00049405, "Fallout4.esm") as Form ; Mirelurk Egg Omelette
    FoodList_3[5] = Game.GetFormFromFile(0x000330D5, "Fallout4.esm") as Form ; Roasted Mirelurk Meat
    FoodList_3[6] = Game.GetFormFromFile(0x04022838, "DLCCoast.esm") as Form ; Gulper Innards (Fallout 4 DLC: Far Harbor)
    FoodList_3[7] = Game.GetFormFromFile(0x04022839, "DLCCoast.esm") as Form ; Hermit Crab Meat (Fallout 4 DLC: Far Harbor)

    ; --- 2 Fertilizers ---
    FoodList_2 = new Form[23] ; Corrected size from 22 to 23
    FoodList_2[0] = Game.GetFormFromFile(0x0004DE66, "Fallout4.esm") as Form ; Brain Fungus
    FoodList_2[1] = Game.GetFormFromFile(0x0003308A, "Fallout4.esm") as Form ; Carrot
    FoodList_2[2] = Game.GetFormFromFile(0x0001007E, "Fallout4.esm") as Form ; Fancy Lad's Snack Cakes
    FoodList_2[3] = Game.GetFormFromFile(0x0001815A, "Fallout4.esm") as Form ; InstaMash
    FoodList_2[4] = Game.GetFormFromFile(0x0005F193, "Fallout4.esm") as Form ; Boatfly Meat
    FoodList_2[5] = Game.GetFormFromFile(0x00041249, "Fallout4.esm") as Form ; Softshell Mirelurk Meat
    FoodList_2[6] = Game.GetFormFromFile(0x000665B1, "Fallout4.esm") as Form ; Radroach Meat
    FoodList_2[7] = Game.GetFormFromFile(0x0005F194, "Fallout4.esm") as Form ; Stingwing Meat
    FoodList_2[8] = Game.GetFormFromFile(0x000330D1, "Fallout4.esm") as Form ; Mirelurk Cake
    FoodList_2[9] = Game.GetFormFromFile(0x000A2563, "Fallout4.esm") as Form ; Radscorpion Omelette
    FoodList_2[10] = Game.GetFormFromFile(0x000192A4, "Fallout4.esm") as Form ; Salisbury Stake
    FoodList_2[11] = Game.GetFormFromFile(0x0005F199, "Fallout4.esm") as Form ; Baked Boatfly
    FoodList_2[12] = Game.GetFormFromFile(0x00062C88, "Fallout4.esm") as Form ; Bloodbug Steak
    FoodList_2[13] = Game.GetFormFromFile(0x000B9026, "Fallout4.esm") as Form ; Ribeye Steak
    FoodList_2[14] = Game.GetFormFromFile(0x000B2981, "Fallout4.esm") as Form ; Deathclaw Steak
    FoodList_2[15] = Game.GetFormFromFile(0x000B2984, "Fallout4.esm") as Form ; Mirelurk Queen Steak
    FoodList_2[16] = Game.GetFormFromFile(0x0004124A, "Fallout4.esm") as Form ; Cooked Softshell Meat
    FoodList_2[17] = Game.GetFormFromFile(0x000B902B, "Fallout4.esm") as Form ; Grilled Radstag
    FoodList_2[18] = Game.GetFormFromFile(0x0402283C, "DLCCoast.esm") as Form ; Fried Fog Crawler (Fallout 4 DLC: Far Harbor)
    FoodList_2[19] = Game.GetFormFromFile(0x0402283B, "DLCCoast.esm") as Form ; Grilled Hermit Crab (Fallout 4 DLC: Far Harbor)
    FoodList_2[20] = Game.GetFormFromFile(0x04022837, "DLCCoast.esm") as Form ; Raw Fog Crawler Meat (Fallout 4 DLC: Far Harbor)
    FoodList_2[21] = Game.GetFormFromFile(0x0402283E, "DLCCoast.esm") as Form ; Wolf Meat (Fallout 4 DLC: Far Harbor)
    FoodList_2[22] = Game.GetFormFromFile(0x0402283F, "DLCCoast.esm") as Form ; Wolf Ribs (Fallout 4 DLC: Far Harbor)

    ; --- 1 Fertilizer ---
    FoodList_1 = new Form[71]
    FoodList_1[0] = Game.GetFormFromFile(0x00012A32, "Fallout4.esm") as Form ; Blamco Brand Mac and Cheese
    FoodList_1[1] = Game.GetFormFromFile(0x0004DE66, "Fallout4.esm") as Form ; Brain Fungus
    FoodList_1[2] = Game.GetFormFromFile(0x0001569B, "Fallout4.esm") as Form ; Bubblegum
    FoodList_1[3] = Game.GetFormFromFile(0x0003308A, "Fallout4.esm") as Form ; Carrot
    FoodList_1[4] = Game.GetFormFromFile(0x0005244E, "Fallout4.esm") as Form ; Fresh Carrot
    FoodList_1[5] = Game.GetFormFromFile(0x00033089, "Fallout4.esm") as Form ; Carrot Flower
    FoodList_1[6] = Game.GetFormFromFile(0x000B1A0F, "Fallout4.esm") as Form ; Cave Fungus
    FoodList_1[7] = Game.GetFormFromFile(0x0003306B, "Fallout4.esm") as Form ; Corn
    FoodList_1[8] = Game.GetFormFromFile(0x0005244C, "Fallout4.esm") as Form ; Fresh Corn
    FoodList_1[9] = Game.GetFormFromFile(0x0005244D, "Fallout4.esm") as Form ; Wild Corn
    FoodList_1[10] = Game.GetFormFromFile(0x00007238, "Fallout4.esm") as Form ; Cram
    FoodList_1[11] = Game.GetFormFromFile(0x00016B64, "Fallout4.esm") as Form ; Dandy Boy Apples
    FoodList_1[12] = Game.GetFormFromFile(0x00003883, "Fallout4.esm") as Form ; Canned Dog Food
    FoodList_1[13] = Game.GetFormFromFile(0x0001007E, "Fallout4.esm") as Form ; Fancy Lads Snack Cakes
    FoodList_1[14] = Game.GetFormFromFile(0x00052453, "Fallout4.esm") as Form ; Mutated Fern Flower
    FoodList_1[15] = Game.GetFormFromFile(0x0001D4AB, "Fallout4.esm") as Form ; Institute Food Packet
    FoodList_1[16] = Game.GetFormFromFile(0x0005F25D, "Fallout4.esm") as Form ; Glowing Fungus
    FoodList_1[17] = Game.GetFormFromFile(0x0004E35A, "Fallout4.esm") as Form ; Ground Mole Rat
    FoodList_1[18] = Game.GetFormFromFile(0x0004B009, "Fallout4.esm") as Form ; Gum Drops
    FoodList_1[19] = Game.GetFormFromFile(0x0003306C, "Fallout4.esm") as Form ; Hubflower
    FoodList_1[20] = Game.GetFormFromFile(0x00019299, "Fallout4.esm") as Form ; Iguana Bits
    FoodList_1[21] = Game.GetFormFromFile(0x0001929A, "Fallout4.esm") as Form ; Iguana On A Stick
    FoodList_1[22] = Game.GetFormFromFile(0x00043329, "Fallout4.esm") as Form ; Potted Meat
    FoodList_1[23] = Game.GetFormFromFile(0x0005F192, "Fallout4.esm") as Form ; Bloodbug Meat
    FoodList_1[24] = Game.GetFormFromFile(0x000B8F9A, "Fallout4.esm") as Form ; Cat Meat
    FoodList_1[25] = Game.GetFormFromFile(0x000330D0, "Fallout4.esm") as Form ; Mirelurk Meat
    FoodList_1[26] = Game.GetFormFromFile(0x0002A36B, "Fallout4.esm") as Form ; Moldy Food
    FoodList_1[27] = Game.GetFormFromFile(0x00052450, "Fallout4.esm") as Form ; Mutfruit
    FoodList_1[28] = Game.GetFormFromFile(0x00052451, "Fallout4.esm") as Form ; Fresh Mutfruit
    FoodList_1[29] = Game.GetFormFromFile(0x00052452, "Fallout4.esm") as Form ; Wild Mutfruit
    FoodList_1[30] = Game.GetFormFromFile(0x00040A23, "Fallout4.esm") as Form ; Noodle Cup
    FoodList_1[31] = Game.GetFormFromFile(0x0009B0BB, "Fallout4.esm") as Form ; Deathclaw Egg Omelette
    FoodList_1[32] = Game.GetFormFromFile(0x000B2982, "Fallout4.esm") as Form ; Tasty Deathclaw Omelette
    FoodList_1[33] = Game.GetFormFromFile(0x00051EE7, "Fallout4.esm") as Form ; Potato Crisps
    FoodList_1[34] = Game.GetFormFromFile(0x0000788D, "Fallout4.esm") as Form ; Pork n' Beans
    FoodList_1[35] = Game.GetFormFromFile(0x0000E646, "Fallout4.esm") as Form ; Perfectly Preserved Pie
    FoodList_1[36] = Game.GetFormFromFile(0x00052458, "Fallout4.esm") as Form ; Razorgrain
    FoodList_1[37] = Game.GetFormFromFile(0x00052459, "Fallout4.esm") as Form ; Wild Razorgrain
    FoodList_1[38] = Game.GetFormFromFile(0x00052461, "Fallout4.esm") as Form ; Silt Bean
    FoodList_1[39] = Game.GetFormFromFile(0x0009B0BD, "Fallout4.esm") as Form ; Deathclaw Wellingham
    FoodList_1[40] = Game.GetFormFromFile(0x0005245B, "Fallout4.esm") as Form ; Squirrel Bits
    FoodList_1[41] = Game.GetFormFromFile(0x000B9025, "Fallout4.esm") as Form ; Crispy Squirrel Bits
    FoodList_1[42] = Game.GetFormFromFile(0x000B9028, "Fallout4.esm") as Form ; Squirrel Stew
    FoodList_1[43] = Game.GetFormFromFile(0x000B9029, "Fallout4.esm") as Form ; Squirrel On A Stick
    FoodList_1[44] = Game.GetFormFromFile(0x000B9027, "Fallout4.esm") as Form ; Mutt Chops
    FoodList_1[45] = Game.GetFormFromFile(0x00062C8C, "Fallout4.esm") as Form ; Mole Rat Chunks
    FoodList_1[46] = Game.GetFormFromFile(0x0005F197, "Fallout4.esm") as Form ; Mutant Hound Chops
    FoodList_1[47] = Game.GetFormFromFile(0x00049FD4, "Fallout4.esm") as Form ; Grilled Radroach
    FoodList_1[48] = Game.GetFormFromFile(0x000A255E, "Fallout4.esm") as Form ; Radscorpion Steak
    FoodList_1[49] = Game.GetFormFromFile(0x00062C92, "Fallout4.esm") as Form ; Stingwing Filet
    FoodList_1[50] = Game.GetFormFromFile(0x00062C93, "Fallout4.esm") as Form ; Yao Guai Ribs
    FoodList_1[51] = Game.GetFormFromFile(0x000B902C, "Fallout4.esm") as Form ; Radstag Stew
    FoodList_1[52] = Game.GetFormFromFile(0x0001046A, "Fallout4.esm") as Form ; Sugar Bombs
    FoodList_1[53] = Game.GetFormFromFile(0x0001815B, "Fallout4.esm") as Form ; Sweet Roll
    FoodList_1[54] = Game.GetFormFromFile(0x00052462, "Fallout4.esm") as Form ; Tarberry
    FoodList_1[55] = Game.GetFormFromFile(0x00052463, "Fallout4.esm") as Form ; Wild Tarberry
    FoodList_1[56] = Game.GetFormFromFile(0x0003306E, "Fallout4.esm") as Form ; Tato
    FoodList_1[57] = Game.GetFormFromFile(0x0003306D, "Fallout4.esm") as Form ; Tato Flower
    FoodList_1[58] = Game.GetFormFromFile(0x00052464, "Fallout4.esm") as Form ; Thistle
    FoodList_1[59] = Game.GetFormFromFile(0x000A6321, "Fallout4.esm") as Form ; Vegetable Soup
    FoodList_1[60] = Game.GetFormFromFile(0x00012A34, "Fallout4.esm") as Form ; Yum Yum Deviled Eggs
    FoodList_1[61] = Game.GetFormFromFile(0x04022830, "DLCCoast.esm") as Form ; Lure Weed (Fallout 4 DLC: Far Harbor)
    FoodList_1[62] = Game.GetFormFromFile(0x04022831, "DLCCoast.esm") as Form ; Angler Stalk (Fallout 4 DLC: Far Harbor)
    FoodList_1[63] = Game.GetFormFromFile(0x04022832, "DLCCoast.esm") as Form ; Aster (Fallout 4 DLC: Far Harbor)
    FoodList_1[64] = Game.GetFormFromFile(0x04022833, "DLCCoast.esm") as Form ; Black Bloodleaf (Fallout 4 DLC: Far Harbor)
    FoodList_1[65] = Game.GetFormFromFile(0x04022834, "DLCCoast.esm") as Form ; Chicken Thigh (Fallout 4 DLC: Far Harbor)
    FoodList_1[66] = Game.GetFormFromFile(0x04022835, "DLCCoast.esm") as Form ; Rabbit Leg (Fallout 4 DLC: Far Harbor)
    FoodList_1[67] = Game.GetFormFromFile(0x04022841, "DLCCoast.esm") as Form ; Chicken Noodle Soup (Fallout 4 DLC: Far Harbor)
    FoodList_1[68] = Game.GetFormFromFile(0x04022840, "DLCCoast.esm") as Form ; Gulper Slurry (Fallout 4 DLC: Far Harbor)
    FoodList_1[69] = Game.GetFormFromFile(0x04022842, "DLCCoast.esm") as Form ; Seasoned Rabbit Skewers (Fallout 4 DLC: Far Harbor)
    FoodList_1[70] = Game.GetFormFromFile(0x04022843, "DLCCoast.esm") as Form ; Mirelurk Jerky (Fallout 4 DLC: Far Harbor)
EndEvent

Event OnUnload()
EndEvent

Event OnPowerOn(ObjectReference akPowerGenerator)
endEvent

Event OnActivate(ObjectReference akActionRef)
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
endEvent

Event ObjectReference.OnItemAdded(ObjectReference akSource, Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
endEvent

Event OnTriggerEnter(ObjectReference akActionRef)
endEvent

Event OnTriggerLeave(ObjectReference akActionRef)
endEvent

Event OnTimer(int aiTimerID)
    if _itemToFire && _itemCountToFire > 0
        ; Create the object at the hopper's location
        _lastProcessedItem = self.PlaceAtMe(_itemToFire, _itemCountToFire, true, true)
        
        ; Call the function to eject the item
        if _lastProcessedItem
            FireProjectile(_lastProcessedItem, ProjectileNode, 0.0, true)
        endif

        ; Reset the temporary properties
        _itemToFire = None
        _itemCountToFire = 0
    endif
endEvent

; -- CUSTOM LOGIC --

function TryToFireProjectile()
	debug.trace(self + " TryToFireProjectile START")

	if bFiring == false && CheckInventory()
		if IsPowered() && IsDestroyed() == false && Is3DLoaded()
			bFiring = true
			
			ObjectReference refToProcess = DropFirstObject(true)
			
			if refToProcess
				if refToProcess.GetBaseObject().HasKeyword(ObjectTypeFood)
					
					DisposeOfItem(refToProcess)
					StartFiringTimer() ; Start timer to place and eject item
					
				else
					Debug.Notification("This unit only processes food. The item will not be processed and has been returned.")
					FireProjectile(refToProcess, ProjectileNode, 0.0, true)
				endif
			endif
			
			bFiring = false
		endif
	endif

	bFiring = false

	if CheckInventory() || CheckTriggerContainers(true)
		StartFiringTimer()
	endif
	debug.trace(self + " TryToFireProjectile DONE")
endFunction

function DisposeOfItem(ObjectReference akItemReference)
    Form akBaseItem = akItemReference.GetBaseObject()
    
    if akBaseItem.HasKeyword(ObjectTypeFood) == false
        return
    endif

    int fertilizerAmount = 0
    
    if IsFormInArray(akBaseItem, FoodList_14)
        fertilizerAmount = 14
    elseif IsFormInArray(akBaseItem, FoodList_10)
        fertilizerAmount = 10
    elseif IsFormInArray(akBaseItem, FoodList_8)
        fertilizerAmount = 8
    elseif IsFormInArray(akBaseItem, FoodList_6)
        fertilizerAmount = 6
    elseif IsFormInArray(akBaseItem, FoodList_4)
        fertilizerAmount = 4
    elseif IsFormInArray(akBaseItem, FoodList_3)
        fertilizerAmount = 3
    elseif IsFormInArray(akBaseItem, FoodList_2)
        fertilizerAmount = 2
    elseif IsFormInArray(akBaseItem, FoodList_1)
        fertilizerAmount = 1
    endif

    if fertilizerAmount == 0
        fertilizerAmount = 2
    endif
    
    akItemReference.Delete()
    
    ; Store the item to be fired in new properties
    _itemToFire = FertilizerObject
    _itemCountToFire = fertilizerAmount
    
    Debug.Notification("Disposed of a food item. Now preparing to eject fertilizer.")
    
EndFunction

; -- HELPER FUNCTIONS --
bool function IsFormInArray(Form akForm, Form[] akFormArray)
    int i = 0
    while i < akFormArray.Length
        if akFormArray[i] == akForm
            return true
        endif
        i += 1
    endwhile
    return false
endfunction

