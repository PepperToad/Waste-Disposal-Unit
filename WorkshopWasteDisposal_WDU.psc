Scriptname WorkshopWasteDisposal_WDU extends ObjectReference

; ============================================================
; Converts consumable food into fertilizer (2 per food item) and spawns it at output.
; Non-food items are removed from inventory and respawned at output unchanged.
; All properties must be set in CK for validation to pass.
; ============================================================

; === Creation Kit-Assigned Properties (MUST BE SET IN CK) ===
ObjectReference Property OutputRef Auto                                ; Reference at output location (e.g., conveyor exit)
Keyword Property ObjectTypeFood Auto                                   ; Keyword for consumable food (e.g., ObjectTypeFood from Fallout4.esm)
Form Property c_Fertilizer_scrap Auto                                  ; Fertilizer form (e.g., from Fallout4.esm)
ObjectReference Property WorkshopParent Auto                           ; Workshop reference (unused but for potential expansion)

; === Hard-Coded Properties (DO NOT CHANGE IN CREATION KIT) ===
Sound Property ManufacturingOutputSound Auto

; Internal fallback keyword (set at runtime)
Keyword Property WorkshopWorkbenchKeywordInternal = None Auto Conditional

; === Adjustable Settings ===
Int Property FertilizerYieldPerFood = 2 Auto                           ; Fertilizer per 1 food item
Float Property SpawnZOffset = 0.5 Auto                                 ; Z-offset forSyntheticVoiceAssistant spawned items to prevent clipping
Int Property MaxBatchSize = 10 Auto                                    ; Max items to spawn per batch to avoid lag

; ============================================================
Event OnInit()
    ; Set the ManufacturingOutputSound to the correct form ID from DLCCoast.esm
    ManufacturingOutputSound = Game.GetFormFromFile(0x04000DFA, "DLCCoast.esm") as Sound
    
    ; Try to set to DLC ContraptionsWorkshopItemKeyword (Form ID 0x00020595 in DLCCoast.esm)
    WorkshopWorkbenchKeywordInternal = Game.GetFormFromFile(0x00020595, "DLCCoast.esm") as Keyword
    
    ; Fallback to WorkshopItemKeyword from base game
    if !WorkshopWorkbenchKeywordInternal
        WorkshopWorkbenchKeywordInternal = Game.GetFormFromFile(0x00054BA6, "Fallout4.esm") as Keyword
        if !WorkshopWorkbenchKeywordInternal
            Debug.Trace("WorkshopWasteDisposal_WDU: Failed to set WorkshopWorkbenchKeyword from DLC or base game!", 1)
        else
            Debug.Trace("WorkshopWasteDisposal_WDU: Using WorkshopItemKeyword (base game fallback).", 1)
        endif
    else
        Debug.Trace("WorkshopWasteDisposal_WDU: Using ContraptionsWorkshopItemKeyword for menu placement.", 1)
    endif
EndEvent

; ============================================================
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    Debug.Trace("WorkshopWasteDisposal_WDU: OnItemAdded triggered with " + aiItemCount + " of FormID " + akBaseItem.GetFormID(), 1)
    
    ; --- Validate Required Properties ---
    if !c_Fertilizer_scrap
        Debug.Trace("WorkshopWasteDisposal_WDU: ERROR - c_Fertilizer_scrap not assigned in CK! Skipping processing.", 1)
        return
    endif
    if akBaseItem == None
        Debug.Trace("WorkshopWasteDisposal_WDU: ERROR - akBaseItem is None! Skipping processing.", 1)
        return
    endif
    if !OutputRef
        Debug.Trace("WorkshopWasteDisposal_WDU: ERROR - OutputRef not assigned in CK! Skipping processing.", 1)
        return
    endif
    Debug.Trace("WorkshopWasteDisposal_WDU: Validation passed. Processing item...", 1)
    
    ; --- Process Consumable Food ---
    if akBaseItem.HasKeyword(ObjectTypeFood)
        int fertilizerCount = aiItemCount * FertilizerYieldPerFood
        Debug.Trace("WorkshopWasteDisposal_WDU: Processing " + aiItemCount + " food item(s) into " + fertilizerCount + " fertilizer.", 1)
        
        ; Play the manufacturing sound
        if ManufacturingOutputSound
            ManufacturingOutputSound.Play(Self)
            Debug.Trace("WorkshopWasteDisposal_WDU: Played manufacturing sound for food.", 1)
        endif
        
        ; Remove the food item(s) from inventory
        Self.RemoveItem(akBaseItem, aiItemCount, true)
        Debug.Trace("WorkshopWasteDisposal_WDU: Removed " + aiItemCount + " food item(s) from inventory.", 1)
        
        ; Spawn fertilizer in batches at the output node
        int itemsToSpawn = fertilizerCount
        while itemsToSpawn > 0
            int batchSize = (Math.Min(itemsToSpawn, MaxBatchSize) as int)
            ObjectReference outputSpawn = OutputRef.PlaceAtMe(c_Fertilizer_scrap, batchSize, abDeleteWhenAble = false)
            if outputSpawn
                outputSpawn.SetPosition(OutputRef.GetPositionX(), OutputRef.GetPositionY(), OutputRef.GetPositionZ() + SpawnZOffset)
                Debug.Trace("WorkshopWasteDisposal_WDU: Spawned " + batchSize + " fertilizer at output.", 1)
            else
                Debug.Trace("WorkshopWasteDisposal_WDU: WARNING - Failed to spawn fertilizer batch!", 1)
            endif
            itemsToSpawn -= batchSize
            Utility.Wait(0.1)  ; Short delay to prevent script overload
        endwhile
    
    ; --- Process Non-Food (Pass Through) ---
    else
        Debug.Trace("WorkshopWasteDisposal_WDU: Processing " + aiItemCount + " non-food item(s) for pass-through.", 1)
        
        ; Play the manufacturing sound
        if ManufacturingOutputSound
            ManufacturingOutputSound.Play(Self)
            Debug.Trace("WorkshopWasteDisposal_WDU: Played manufacturing sound for non-food.", 1)
        endif
        
        ; Remove the non-food item(s) from inventory
        Self.RemoveItem(akBaseItem, aiItemCount, true)
        Debug.Trace("WorkshopWasteDisposal_WDU: Removed " + aiItemCount + " non-food item(s) from inventory.", 1)
        
        ; Spawn non-food items in batches at the output node
        int itemsToSpawn = aiItemCount
        while itemsToSpawn > 0
            int batchSize = (Math.Min(itemsToSpawn, MaxBatchSize) as int)
            ObjectReference outputSpawn = OutputRef.PlaceAtMe(akBaseItem, batchSize, abDeleteWhenAble = false)
            if outputSpawn
                outputSpawn.SetPosition(OutputRef.GetPositionX(), OutputRef.GetPositionY(), OutputRef.GetPositionZ() + SpawnZOffset)
                Debug.Trace("WorkshopWasteDisposal_WDU: Spawned " + batchSize + " non-food item(s) at output.", 1)
            else
                Debug.Trace("WorkshopWasteDisposal_WDU: WARNING - Failed to spawn non-food batch!", 1)
            endif
            itemsToSpawn -= batchSize
            Utility.Wait(0.1)  ; Short delay to prevent script overload
        endwhile
    endif
EndEvent