Scriptname WorkshopWasteDisposal_WDU extends DLC05:WorkshopHopperScript

; ====================================================================================================
; === PROPERTIES =====================================================================================
; ====================================================================================================

; Properties to be linked in the Creation Kit.
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
    ; Initialize all lists as empty arrays. This is the correct way to declare an empty array.
    FoodList_1 = new Form[0]
    FoodList_2 = new Form[0]
    FoodList_3 = new Form[0]
    FoodList_4 = new Form[0]
    FoodList_6 = new Form[0]
    FoodList_8 = new Form[0]
    FoodList_10 = new Form[0]
    FoodList_14 = new Form[0]

    ; Add each form to its respective list. Duplicate entries have been consolidated.
    ; The GetFormFromFile function will return None if the file or form ID does not exist,
    ; preventing runtime errors if a mod like ManufacturingExtended is not loaded.

    ; 14 Fertilizers:
    FoodList_14.Add(Game.GetFormFromFile(0x00045F1E, "Fallout4.esm")) ; Deathclaw Meat
    FoodList_14.Add(Game.GetFormFromFile(0x00033B44, "Fallout4.esm")) ; Yao Guai Meat

    ; 10 Fertilizers:
    FoodList_10.Add(Game.GetFormFromFile(0x00045F1F, "Fallout4.esm")) ; Radscorpion Meat

    ; 8 Fertilizers:
    FoodList_8.Add(Game.GetFormFromFile(0x00030094, "Fallout4.esm")) ; Brahmin Meat
    FoodList_8.Add(Game.GetFormFromFile(0x0005F9A6, "Fallout4.esm")) ; Synthetic Gorilla Meat
    FoodList_8.Add(Game.GetFormFromFile(0x000A855A, "Fallout4.esm")) ; Mutant Hound Meat
    FoodList_8.Add(Game.GetFormFromFile(0x000A855B, "Fallout4.esm")) ; Radstag Meat
    FoodList_8.Add(Game.GetFormFromFile(0x00045B82, "Fallout4.esm")) ; Blight [Far Harbor DLC]
    FoodList_8.Add(Game.GetFormFromFile(0x020059E4, "ManufacturingExtended.esp")) ; Ghoul Meat
    FoodList_8.Add(Game.GetFormFromFile(0x020059E5, "ManufacturingExtended.esp")) ; Human Meat
    FoodList_8.Add(Game.GetFormFromFile(0x020059E6, "ManufacturingExtended.esp")) ; Mutant Meat

    ; 6 Fertilizers:
    FoodList_6.Add(Game.GetFormFromFile(0x00033100, "Fallout4.esm")) ; Gourd [Institute ver.]
    FoodList_6.Add(Game.GetFormFromFile(0x00045B81, "Fallout4.esm")) ; Melon
    FoodList_6.Add(Game.GetFormFromFile(0x000330FE, "Fallout4.esm")) ; Mirelurk Egg
    FoodList_6.Add(Game.GetFormFromFile(0x0402283A, "DLCCoast.esm")) ; Angler Meat
    FoodList_6.Add(Game.GetFormFromFile(0x0402283D, "DLCCoast.esm")) ; Poached Angler

    ; 4 Fertilizers:
    FoodList_4.Add(Game.GetFormFromFile(0x000523C6, "Fallout4.esm")) ; Deathclaw Egg
    FoodList_4.Add(Game.GetFormFromFile(0x000330FF, "Fallout4.esm")) ; Gourd
    FoodList_4.Add(Game.GetFormFromFile(0x00033104, "Fallout4.esm")) ; Yao Guai Roast

    ; 3 Fertilizers:
    FoodList_3.Add(Game.GetFormFromFile(0x0002A36E, "Fallout4.esm")) ; Mongrel Dog Meat
    FoodList_3.Add(Game.GetFormFromFile(0x0002A36C, "Fallout4.esm")) ; Mirelurk Meat
    FoodList_3.Add(Game.GetFormFromFile(0x0002A36D, "Fallout4.esm")) ; Queen Mirelurk Meat
    FoodList_3.Add(Game.GetFormFromFile(0x0001859E, "Fallout4.esm")) ; Mole Rat Meat
    FoodList_3.Add(Game.GetFormFromFile(0x0002A36F, "Fallout4.esm")) ; Mirelurk Egg Omelette
    FoodList_3.Add(Game.GetFormFromFile(0x0002A378, "Fallout4.esm")) ; Roasted Mirelurk Meat
    FoodList_3.Add(Game.GetFormFromFile(0x04022838, "DLCCoast.esm")) ; Gulper Innards
    FoodList_3.Add(Game.GetFormFromFile(0x04022839, "DLCCoast.esm")) ; Hermit Crab Meat

    ; 2 Fertilizers:
    FoodList_2.Add(Game.GetFormFromFile(0x000330C8, "Fallout4.esm")) ; Brain Fungus
    FoodList_2.Add(Game.GetFormFromFile(0x000330D5, "Fallout4.esm")) ; Carrot
    FoodList_2.Add(Game.GetFormFromFile(0x00033107, "Fallout4.esm")) ; Fancy Lad's Snack Cakes
    FoodList_2.Add(Game.GetFormFromFile(0x00033103, "Fallout4.esm")) ; InstaMash
    FoodList_2.Add(Game.GetFormFromFile(0x0002A36B, "Fallout4.esm")) ; Boatfly Meat
    FoodList_2.Add(Game.GetFormFromFile(0x0002A370, "Fallout4.esm")) ; Softshell Mirelurk Meat
    FoodList_2.Add(Game.GetFormFromFile(0x0002A371, "Fallout4.esm")) ; Radroach Meat
    FoodList_2.Add(Game.GetFormFromFile(0x0002A372, "Fallout4.esm")) ; Stingwing Meat
    FoodList_2.Add(Game.GetFormFromFile(0x0002A37A, "Fallout4.esm")) ; Mirelurk Cake
    FoodList_2.Add(Game.GetFormFromFile(0x0002A37B, "Fallout4.esm")) ; Radscorpion Omelette
    FoodList_2.Add(Game.GetFormFromFile(0x00033101, "Fallout4.esm")) ; Salisbury Steak
    FoodList_2.Add(Game.GetFormFromFile(0x000330D7, "Fallout4.esm")) ; Baked Boatfly
    FoodList_2.Add(Game.GetFormFromFile(0x000330D9, "Fallout4.esm")) ; Bloodbug Steak
    FoodList_2.Add(Game.GetFormFromFile(0x00033100, "Fallout4.esm")) ; Ribeye Steak
    FoodList_2.Add(Game.GetFormFromFile(0x0002A37E, "Fallout4.esm")) ; Deathclaw Steak
    FoodList_2.Add(Game.GetFormFromFile(0x000330F7, "Fallout4.esm")) ; Mirelurk Queen Steak
    FoodList_2.Add(Game.GetFormFromFile(0x0002A37F, "Fallout4.esm")) ; Cooked Softshell Meat
    FoodList_2.Add(Game.GetFormFromFile(0x0002A380, "Fallout4.esm")) ; Grilled Radstag
    FoodList_2.Add(Game.GetFormFromFile(0x0402283C, "DLCCoast.esm")) ; Fried Fog Crawler
    FoodList_2.Add(Game.GetFormFromFile(0x0402283B, "DLCCoast.esm")) ; Grilled Hermit Crab
    FoodList_2.Add(Game.GetFormFromFile(0x04022837, "DLCCoast.esm")) ; Raw Fog Crawler Meat
    FoodList_2.Add(Game.GetFormFromFile(0x0402283E, "DLCCoast.esm")) ; Wolf Meat
    FoodList_2.Add(Game.GetFormFromFile(0x0402283F, "DLCCoast.esm")) ; Wolf Ribs

    ; 1 Fertilizer:
    FoodList_1.Add(Game.GetFormFromFile(0x00033108, "Fallout4.esm")) ; Blamco Brand Mac and Cheese
    FoodList_1.Add(Game.GetFormFromFile(0x000330D6, "Fallout4.esm")) ; Bubblegum
    FoodList_1.Add(Game.GetFormFromFile(0x000330F9, "Fallout4.esm")) ; Fresh Carrot
    FoodList_1.Add(Game.GetFormFromFile(0x00018596, "Fallout4.esm")) ; Carrot Flower
    FoodList_1.Add(Game.GetFormFromFile(0x000330FA, "Fallout4.esm")) ; Corn
    FoodList_1.Add(Game.GetFormFromFile(0x000330FB, "Fallout4.esm")) ; Fresh Corn
    FoodList_1.Add(Game.GetFormFromFile(0x0003310B, "Fallout4.esm")) ; Wild Corn
    FoodList_1.Add(Game.GetFormFromFile(0x0003310A, "Fallout4.esm")) ; Cram
    FoodList_1.Add(Game.GetFormFromFile(0x0003310D, "Fallout4.esm")) ; Dandy Boy Apples
    FoodList_1.Add(Game.GetFormFromFile(0x0002A374, "Fallout4.esm")) ; Fancy Lads Snack Cakes
    FoodList_1.Add(Game.GetFormFromFile(0x000330E0, "Fallout4.esm")) ; Mutated Fern Flower
    FoodList_1.Add(Game.GetFormFromFile(0x0002A375, "Fallout4.esm")) ; Institute Food Packet
    FoodList_1.Add(Game.GetFormFromFile(0x0002A376, "Fallout4.esm")) ; Glowing Fungus
    FoodList_1.Add(Game.GetFormFromFile(0x0003310E, "Fallout4.esm")) ; Ground Mole Rat
    FoodList_1.Add(Game.GetFormFromFile(0x000330E2, "Fallout4.esm")) ; Gum Drops
    FoodList_1.Add(Game.GetFormFromFile(0x0003310F, "Fallout4.esm")) ; Hubflower
    FoodList_1.Add(Game.GetFormFromFile(0x00033110, "Fallout4.esm")) ; Iguana Bits
    FoodList_1.Add(Game.GetFormFromFile(0x00033111, "Fallout4.esm")) ; Iguana On A Stick
    FoodList_1.Add(Game.GetFormFromFile(0x0002A373, "Fallout4.esm")) ; Potted Meat
    FoodList_1.Add(Game.GetFormFromFile(0x0002A37D, "Fallout4.esm")) ; Bloodbug Meat
    FoodList_1.Add(Game.GetFormFromFile(0x0002A381, "Fallout4.esm")) ; Noodle Cup
    FoodList_1.Add(Game.GetFormFromFile(0x0002A382, "Fallout4.esm")) ; Deathclaw Egg Omelette
    FoodList_1.Add(Game.GetFormFromFile(0x000330F4, "Fallout4.esm")) ; Tasty Deathclaw Omelette
    FoodList_1.Add(Game.GetFormFromFile(0x000330F5, "Fallout4.esm")) ; Potato Crisps
    FoodList_1.Add(Game.GetFormFromFile(0x00033112, "Fallout4.esm")) ; Pork n' Beans
    FoodList_1.Add(Game.GetFormFromFile(0x000330F6, "Fallout4.esm")) ; Perfectly Preserved Pie
    FoodList_1.Add(Game.GetFormFromFile(0x000330FD, "Fallout4.esm")) ; Razorgrain
    FoodList_1.Add(Game.GetFormFromFile(0x000330FF, "Fallout4.esm")) ; Wild Razorgrain
    FoodList_1.Add(Game.GetFormFromFile(0x00033114, "Fallout4.esm")) ; Silt Bean
    FoodList_1.Add(Game.GetFormFromFile(0x00033115, "Fallout4.esm")) ; Deathclaw Wellingham
    FoodList_1.Add(Game.GetFormFromFile(0x00033116, "Fallout4.esm")) ; Squirrel Bits
    FoodList_1.Add(Game.GetFormFromFile(0x00033117, "Fallout4.esm")) ; Crispy Squirrel Bits
    FoodList_1.Add(Game.GetFormFromFile(0x00033118, "Fallout4.esm")) ; Squirrel Stew
    FoodList_1.Add(Game.GetFormFromFile(0x0002A383, "Fallout4.esm")) ; Squirrel On A Stick
    FoodList_1.Add(Game.GetFormFromFile(0x0002A384, "Fallout4.esm")) ; Mutt Chops
    FoodList_1.Add(Game.GetFormFromFile(0x0002A385, "Fallout4.esm")) ; Mole Rat Chunks
    FoodList_1.Add(Game.GetFormFromFile(0x0002A386, "Fallout4.esm")) ; Mutant Hound Chops
    FoodList_1.Add(Game.GetFormFromFile(0x0002A387, "Fallout4.esm")) ; Grilled Radroach
    FoodList_1.Add(Game.GetFormFromFile(0x0002A388, "Fallout4.esm")) ; Radscorpion Steak
    FoodList_1.Add(Game.GetFormFromFile(0x0002A389, "Fallout4.esm")) ; Stingwing Filet
    FoodList_1.Add(Game.GetFormFromFile(0x0002A38A, "Fallout4.esm")) ; Yao Guai Ribs
    FoodList_1.Add(Game.GetFormFromFile(0x00033119, "Fallout4.esm")) ; Radstag Stew
    FoodList_1.Add(Game.GetFormFromFile(0x0003311A, "Fallout4.esm")) ; Sugar Bombs
    FoodList_1.Add(Game.GetFormFromFile(0x000330EE, "Fallout4.esm")) ; Sweet Roll
    FoodList_1.Add(Game.GetFormFromFile(0x00033102, "Fallout4.esm")) ; Tarberry
    FoodList_1.Add(Game.GetFormFromFile(0x000330ED, "Fallout4.esm")) ; Wild Tarberry
    FoodList_1.Add(Game.GetFormFromFile(0x000330FC, "Fallout4.esm")) ; Tato
    FoodList_1.Add(Game.GetFormFromFile(0x0003311B, "Fallout4.esm")) ; Tato Flower
    FoodList_1.Add(Game.GetFormFromFile(0x000330EF, "Fallout4.esm")) ; Thistle
    FoodList_1.Add(Game.GetFormFromFile(0x0003311C, "Fallout4.esm")) ; Vegetable Soup
    FoodList_1.Add(Game.GetFormFromFile(0x00040854, "Fallout4.esm")) ; Yum Yum Deviled Eggs
    FoodList_1.Add(Game.GetFormFromFile(0x04022841, "DLCCoast.esm")) ; Lure Weed
    FoodList_1.Add(Game.GetFormFromFile(0x04022840, "DLCCoast.esm")) ; Angler Stalk
    FoodList_1.Add(Game.GetFormFromFile(0x04022842, "DLCCoast.esm")) ; Aster
    FoodList_1.Add(Game.GetFormFromFile(0x04022843, "DLCCoast.esm")) ; Black Bloodleaf
    FoodList_1.Add(Game.GetFormFromFile(0x04022831, "DLCCoast.esm")) ; Chicken Thigh
    FoodList_1.Add(Game.GetFormFromFile(0x04022832, "DLCCoast.esm")) ; Rabbit Leg
    FoodList_1.Add(Game.GetFormFromFile(0x04022833, "DLCCoast.esm")) ; Chicken Noodle Soup
    FoodList_1.Add(Game.GetFormFromFile(0x04022834, "DLCCoast.esm")) ; Gulper Slurry
    FoodList_1.Add(Game.GetFormFromFile(0x04022835, "DLCCoast.esm")) ; Seasoned Rabbit Skewers
    FoodList_1.Add(Game.GetFormFromFile(0x04022836, "DLCCoast.esm")) ; Mirelurk Jerky
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
    endif

    ; No else block is needed here. If the `if` condition is not met (yield is 0),
    ; the script will simply continue without deleting the item reference. The
    ; base `DLC05:WorkshopHopperScript` will then see the unhandled item and eject it.
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
