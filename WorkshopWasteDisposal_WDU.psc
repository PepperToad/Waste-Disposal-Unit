Scriptname WorkshopWasteDisposal_WDU extends DLC05:WorkshopHopperScript

; ====================================================================================================
; === PROPERTIES =====================================================================================
; ====================================================================================================

; Properties to be linked in the Creation Kit.
; Note: ProjectileNode is already defined in the parent script, so we do not need to redeclare it.
Form Property FertilizerObject Auto Const
Keyword Property ObjectTypeFood Auto Const

; Hard-coded lists for food items and their fertilizer yield.
; These properties are populated in the OnInit event.
Form[] Property FoodList_1 Auto
Form[] Property FoodList_2 Auto
Form[] Property FoodList_3 Auto
Form[] Property FoodList_4 Auto
Form[] Property FoodList_6 Auto
Form[] Property FoodList_8 Auto
Form[] Property FoodList_10 Auto
Form[] Property FoodList_14 Auto

; ====================================================================================================
; === EVENTS =========================================================================================
; ====================================================================================================

; This event runs once when the script is first attached.
Event OnInit()
    ; Use temporary, dynamic arrays to correctly add forms and then assign them to the properties.
    ; The previous method with .Add() was not working on the fixed-size array properties.

    Form[] tempFoodList

    ; 14 Fertilizers:
    tempFoodList = new Form[0]
    tempFoodList.Add(Game.GetFormFromFile(0x00045F1E, "Fallout4.esm")) ; Deathclaw Meat
    tempFoodList.Add(Game.GetFormFromFile(0x00033B44, "Fallout4.esm")) ; Yao Guai Meat
    FoodList_14 = tempFoodList

    ; 10 Fertilizers:
    tempFoodList = new Form[0]
    tempFoodList.Add(Game.GetFormFromFile(0x00045F1F, "Fallout4.esm")) ; Radscorpion Meat
    FoodList_10 = tempFoodList

    ; 8 Fertilizers:
    tempFoodList = new Form[0]
    tempFoodList.Add(Game.GetFormFromFile(0x00030094, "Fallout4.esm")) ; Brahmin Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0005F9A6, "Fallout4.esm")) ; Synthetic Gorilla Meat
    tempFoodList.Add(Game.GetFormFromFile(0x000A855A, "Fallout4.esm")) ; Mutant Hound Meat
    tempFoodList.Add(Game.GetFormFromFile(0x000A855B, "Fallout4.esm")) ; Radstag Meat
    tempFoodList.Add(Game.GetFormFromFile(0x00045B82, "Fallout4.esm")) ; Blight [Far Harbor DLC]
    tempFoodList.Add(Game.GetFormFromFile(0x020059E4, "ManufacturingExtended.esp")) ; Ghoul Meat
    tempFoodList.Add(Game.GetFormFromFile(0x020059E5, "ManufacturingExtended.esp")) ; Human Meat
    tempFoodList.Add(Game.GetFormFromFile(0x020059E6, "ManufacturingExtended.esp")) ; Mutant Meat
    FoodList_8 = tempFoodList

    ; 6 Fertilizers:
    tempFoodList = new Form[0]
    tempFoodList.Add(Game.GetFormFromFile(0x00033100, "Fallout4.esm")) ; Gourd [Institute ver.]
    tempFoodList.Add(Game.GetFormFromFile(0x00045B81, "Fallout4.esm")) ; Melon
    tempFoodList.Add(Game.GetFormFromFile(0x000330FE, "Fallout4.esm")) ; Mirelurk Egg
    tempFoodList.Add(Game.GetFormFromFile(0x0402283A, "DLCCoast.esm")) ; Angler Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0402283D, "DLCCoast.esm")) ; Poached Angler
    FoodList_6 = tempFoodList

    ; 4 Fertilizers:
    tempFoodList = new Form[0]
    tempFoodList.Add(Game.GetFormFromFile(0x000523C6, "Fallout4.esm")) ; Deathclaw Egg
    tempFoodList.Add(Game.GetFormFromFile(0x000330FF, "Fallout4.esm")) ; Gourd
    tempFoodList.Add(Game.GetFormFromFile(0x00033104, "Fallout4.esm")) ; Yao Guai Roast
    FoodList_4 = tempFoodList

    ; 3 Fertilizers:
    tempFoodList = new Form[0]
    tempFoodList.Add(Game.GetFormFromFile(0x0002A36E, "Fallout4.esm")) ; Mongrel Dog Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A36C, "Fallout4.esm")) ; Mirelurk Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A36D, "Fallout4.esm")) ; Queen Mirelurk Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0001859E, "Fallout4.esm")) ; Mole Rat Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A36F, "Fallout4.esm")) ; Mirelurk Egg Omelette
    tempFoodList.Add(Game.GetFormFromFile(0x0002A378, "Fallout4.esm")) ; Roasted Mirelurk Meat
    tempFoodList.Add(Game.GetFormFromFile(0x04022838, "DLCCoast.esm")) ; Gulper Innards
    tempFoodList.Add(Game.GetFormFromFile(0x04022839, "DLCCoast.esm")) ; Hermit Crab Meat
    FoodList_3 = tempFoodList

    ; 2 Fertilizers:
    tempFoodList = new Form[0]
    tempFoodList.Add(Game.GetFormFromFile(0x000330C8, "Fallout4.esm")) ; Brain Fungus
    tempFoodList.Add(Game.GetFormFromFile(0x000330D5, "Fallout4.esm")) ; Carrot
    tempFoodList.Add(Game.GetFormFromFile(0x00033107, "Fallout4.esm")) ; Fancy Lad's Snack Cakes
    tempFoodList.Add(Game.GetFormFromFile(0x00033103, "Fallout4.esm")) ; InstaMash
    tempFoodList.Add(Game.GetFormFromFile(0x0002A36B, "Fallout4.esm")) ; Boatfly Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A370, "Fallout4.esm")) ; Softshell Mirelurk Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A371, "Fallout4.esm")) ; Radroach Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A372, "Fallout4.esm")) ; Stingwing Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A37A, "Fallout4.esm")) ; Mirelurk Cake
    tempFoodList.Add(Game.GetFormFromFile(0x0002A37B, "Fallout4.esm")) ; Radscorpion Omelette
    tempFoodList.Add(Game.GetFormFromFile(0x00033101, "Fallout4.esm")) ; Salisbury Steak
    tempFoodList.Add(Game.GetFormFromFile(0x000330D7, "Fallout4.esm")) ; Baked Boatfly
    tempFoodList.Add(Game.GetFormFromFile(0x000330D9, "Fallout4.esm")) ; Bloodbug Steak
    tempFoodList.Add(Game.GetFormFromFile(0x00033100, "Fallout4.esm")) ; Ribeye Steak
    tempFoodList.Add(Game.GetFormFromFile(0x0002A37E, "Fallout4.esm")) ; Deathclaw Steak
    tempFoodList.Add(Game.GetFormFromFile(0x000330F7, "Fallout4.esm")) ; Mirelurk Queen Steak
    tempFoodList.Add(Game.GetFormFromFile(0x0002A37F, "Fallout4.esm")) ; Cooked Softshell Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A380, "Fallout4.esm")) ; Grilled Radstag
    tempFoodList.Add(Game.GetFormFromFile(0x0402283C, "DLCCoast.esm")) ; Fried Fog Crawler
    tempFoodList.Add(Game.GetFormFromFile(0x0402283B, "DLCCoast.esm")) ; Grilled Hermit Crab
    tempFoodList.Add(Game.GetFormFromFile(0x04022837, "DLCCoast.esm")) ; Raw Fog Crawler Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0402283E, "DLCCoast.esm")) ; Wolf Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0402283F, "DLCCoast.esm")) ; Wolf Ribs
    FoodList_2 = tempFoodList

    ; 1 Fertilizer:
    tempFoodList = new Form[0]
    tempFoodList.Add(Game.GetFormFromFile(0x00033108, "Fallout4.esm")) ; Blamco Brand Mac and Cheese
    tempFoodList.Add(Game.GetFormFromFile(0x000330D6, "Fallout4.esm")) ; Bubblegum
    tempFoodList.Add(Game.GetFormFromFile(0x000330F9, "Fallout4.esm")) ; Fresh Carrot
    tempFoodList.Add(Game.GetFormFromFile(0x00018596, "Fallout4.esm")) ; Carrot Flower
    tempFoodList.Add(Game.GetFormFromFile(0x000330FA, "Fallout4.esm")) ; Corn
    tempFoodList.Add(Game.GetFormFromFile(0x000330FB, "Fallout4.esm")) ; Fresh Corn
    tempFoodList.Add(Game.GetFormFromFile(0x0003310B, "Fallout4.esm")) ; Wild Corn
    tempFoodList.Add(Game.GetFormFromFile(0x0003310A, "Fallout4.esm")) ; Cram
    tempFoodList.Add(Game.GetFormFromFile(0x0003310D, "Fallout4.esm")) ; Dandy Boy Apples
    tempFoodList.Add(Game.GetFormFromFile(0x0002A374, "Fallout4.esm")) ; Fancy Lads Snack Cakes
    tempFoodList.Add(Game.GetFormFromFile(0x000330E0, "Fallout4.esm")) ; Mutated Fern Flower
    tempFoodList.Add(Game.GetFormFromFile(0x0002A375, "Fallout4.esm")) ; Institute Food Packet
    tempFoodList.Add(Game.GetFormFromFile(0x0002A376, "Fallout4.esm")) ; Glowing Fungus
    tempFoodList.Add(Game.GetFormFromFile(0x0003310E, "Fallout4.esm")) ; Ground Mole Rat
    tempFoodList.Add(Game.GetFormFromFile(0x000330E2, "Fallout4.esm")) ; Gum Drops
    tempFoodList.Add(Game.GetFormFromFile(0x0003310F, "Fallout4.esm")) ; Hubflower
    tempFoodList.Add(Game.GetFormFromFile(0x00033110, "Fallout4.esm")) ; Iguana Bits
    tempFoodList.Add(Game.GetFormFromFile(0x00033111, "Fallout4.esm")) ; Iguana On A Stick
    tempFoodList.Add(Game.GetFormFromFile(0x0002A373, "Fallout4.esm")) ; Potted Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A37D, "Fallout4.esm")) ; Bloodbug Meat
    tempFoodList.Add(Game.GetFormFromFile(0x0002A381, "Fallout4.esm")) ; Noodle Cup
    tempFoodList.Add(Game.GetFormFromFile(0x0002A382, "Fallout4.esm")) ; Deathclaw Egg Omelette
    tempFoodList.Add(Game.GetFormFromFile(0x000330F4, "Fallout4.esm")) ; Tasty Deathclaw Omelette
    tempFoodList.Add(Game.GetFormFromFile(0x000330F5, "Fallout4.esm")) ; Potato Crisps
    tempFoodList.Add(Game.GetFormFromFile(0x00033112, "Fallout4.esm")) ; Pork n' Beans
    tempFoodList.Add(Game.GetFormFromFile(0x000330F6, "Fallout4.esm")) ; Perfectly Preserved Pie
    tempFoodList.Add(Game.GetFormFromFile(0x000330FD, "Fallout4.esm")) ; Razorgrain
    tempFoodList.Add(Game.GetFormFromFile(0x000330FF, "Fallout4.esm")) ; Wild Razorgrain
    tempFoodList.Add(Game.GetFormFromFile(0x00033114, "Fallout4.esm")) ; Silt Bean
    tempFoodList.Add(Game.GetFormFromFile(0x00033115, "Fallout4.esm")) ; Deathclaw Wellingham
    tempFoodList.Add(Game.GetFormFromFile(0x00033116, "Fallout4.esm")) ; Squirrel Bits
    tempFoodList.Add(Game.GetFormFromFile(0x00033117, "Fallout4.esm")) ; Crispy Squirrel Bits
    tempFoodList.Add(Game.GetFormFromFile(0x00033118, "Fallout4.esm")) ; Squirrel Stew
    tempFoodList.Add(Game.GetFormFromFile(0x0002A383, "Fallout4.esm")) ; Squirrel On A Stick
    tempFoodList.Add(Game.GetFormFromFile(0x0002A384, "Fallout4.esm")) ; Mutt Chops
    tempFoodList.Add(Game.GetFormFromFile(0x0002A385, "Fallout4.esm")) ; Mole Rat Chunks
    tempFoodList.Add(Game.GetFormFromFile(0x0002A386, "Fallout4.esm")) ; Mutant Hound Chops
    tempFoodList.Add(Game.GetFormFromFile(0x0002A387, "Fallout4.esm")) ; Grilled Radroach
    tempFoodList.Add(Game.GetFormFromFile(0x0002A388, "Fallout4.esm")) ; Radscorpion Steak
    tempFoodList.Add(Game.GetFormFromFile(0x0002A389, "Fallout4.esm")) ; Stingwing Filet
    tempFoodList.Add(Game.GetFormFromFile(0x0002A38A, "Fallout4.esm")) ; Yao Guai Ribs
    tempFoodList.Add(Game.GetFormFromFile(0x00033119, "Fallout4.esm")) ; Radstag Stew
    tempFoodList.Add(Game.GetFormFromFile(0x0003311A, "Fallout4.esm")) ; Sugar Bombs
    tempFoodList.Add(Game.GetFormFromFile(0x000330EE, "Fallout4.esm")) ; Sweet Roll
    tempFoodList.Add(Game.GetFormFromFile(0x00033102, "Fallout4.esm")) ; Tarberry
    tempFoodList.Add(Game.GetFormFromFile(0x000330ED, "Fallout4.esm")) ; Wild Tarberry
    tempFoodList.Add(Game.GetFormFromFile(0x000330FC, "Fallout4.esm")) ; Tato
    tempFoodList.Add(Game.GetFormFromFile(0x0003311B, "Fallout4.esm")) ; Tato Flower
    tempFoodList.Add(Game.GetFormFromFile(0x000330EF, "Fallout4.esm")) ; Thistle
    tempFoodList.Add(Game.GetFormFromFile(0x0003311C, "Fallout4.esm")) ; Vegetable Soup
    tempFoodList.Add(Game.GetFormFromFile(0x00040854, "Fallout4.esm")) ; Yum Yum Deviled Eggs
    tempFoodList.Add(Game.GetFormFromFile(0x04022841, "DLCCoast.esm")) ; Lure Weed
    tempFoodList.Add(Game.GetFormFromFile(0x04022840, "DLCCoast.esm")) ; Angler Stalk
    tempFoodList.Add(Game.GetFormFromFile(0x04022842, "DLCCoast.esm")) ; Aster
    tempFoodList.Add(Game.GetFormFromFile(0x04022843, "DLCCoast.esm")) ; Black Bloodleaf
    tempFoodList.Add(Game.GetFormFromFile(0x04022831, "DLCCoast.esm")) ; Chicken Thigh
    tempFoodList.Add(Game.GetFormFromFile(0x04022832, "DLCCoast.esm")) ; Rabbit Leg
    tempFoodList.Add(Game.GetFormFromFile(0x04022833, "DLCCoast.esm")) ; Chicken Noodle Soup
    tempFoodList.Add(Game.GetFormFromFile(0x04022834, "DLCCoast.esm")) ; Gulper Slurry
    tempFoodList.Add(Game.GetFormFromFile(0x04022835, "DLCCoast.esm")) ; Seasoned Rabbit Skewers
    tempFoodList.Add(Game.GetFormFromFile(0x04022836, "DLCCoast.esm")) ; Mirelurk Jerky
    FoodList_1 = tempFoodList

EndEvent

; This event is triggered whenever an item is added to the container.
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemRef, ObjectReference akSourceContainer)
    ; Determine the fertilizer yield for the added item.
    int yield = GetFertilizerYield(akBaseItem)

    ; If the item has a positive yield, it's a food item to be processed.
    if yield > 0
        ; Delete the original item object reference from the game world.
        akItemRef.Delete()

        ; Give the player the corresponding amount of fertilizer.
        Game.GetPlayer().AddItem(FertilizerObject, yield)

    ; If the item is not a food item (yield is 0), eject it.
    else
        ; The ProjectileNode property is already defined in the parent script.
        ; Move the item to the "spit out" location.
        ; The compiler reported that GetNode() is not a valid function for this operation,
        ; so we've changed the code to simply move the item to the hopper's location.
        akItemRef.MoveTo(Self)
    endif
EndEvent

; ====================================================================================================
; === FUNCTIONS ======================================================================================
; ====================================================================================================

; This function will determine the fertilizer yield based on the item.
int Function GetFertilizerYield(Form akFood)
    ; Check each hard-coded list to find a match.
    if FoodList_1.Find(akFood) != -1
        return 1
    elseif FoodList_2.Find(akFood) != -1
        return 2
    elseif FoodList_3.Find(akFood) != -1
        return 3
    elseif FoodList_4.Find(akFood) != -1
        return 4
    elseif FoodList_6.Find(akFood) != -1
        return 6
    elseif FoodList_8.Find(akFood) != -1
        return 8
    elseif FoodList_10.Find(akFood) != -1
        return 10
    elseif FoodList_14.Find(akFood) != -1
        return 14
    endif

    ; FAIL-SAFE: If the item was not in our hard-coded lists, check if it's
    ; a food item at all based on the ObjectTypeFood keyword.
    if akFood.HasKeyword(ObjectTypeFood)
        return 2 ; Default to 2 fertilizer.
    else
        return 0 ; Returns 0 if it's not a food item.
    endif
EndFunction
