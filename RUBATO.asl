state("RUBATO", "v1.1C_vm")
{
    short currentRoomID : 0x8BA7C8;
    byte isStarting : 0x690850, 0x4B8, 0xE60;
    // byte isLoadingNow : 0x690850, 0x480, 0x660;
    byte isEnding : 0x5FC480, 0x1E0, 0x2A8, 0x20, 0x460;
}

state("RUBATO", "v1.1G")
{
    short currentRoomID : 0x3202B70;
    byte isStarting : 0x31EBCD0, 0x4B8, 0xE60;
    // byte isLoadingNow : 0x31EBCD0, 0x480, 0x660;
    byte isEnding : 0x310D670, 0x1E0, 0x2A8, 0x20, 0x460;
}

state("RUBATO", "v1.2A")
{
    short currentRoomID : 0x33E7070;
    byte isStarting : 0x33E2DE8, 0x0, 0x7B0, 0x18, 0x60;
    byte isEnding : 0x33D4A10, 0x310, 0x208, 0xD60;
}

init
{
	// printing debug info
    // vars.currentStage = 0;
	// Action PrintValues = () =>
	// {
    // print("currentRoomID: " + current.currentRoomID.ToString());
    // print("isStarting: " + current.isStarting.ToString());
    // //  print("isLoading: " + current.isLoadingNow.ToString());
    //  print("isEnding: " + current.isEnding.ToString());
    //  print("vars.currentStage: " + vars.currentStage.ToString());
	// };
	// vars.PrintValues = PrintValues;	
	// vars.PrintValues();

    int moduleSize = modules.First().ModuleMemorySize;
    // print("moduleSize: " + moduleSize.ToString());
    if (moduleSize == 9637888) 
    {
        version = "v1.1C_vm";
    }
    else if (moduleSize == 57651200) 
    {
        version = "v1.1G";
    }
    else if (moduleSize == 59785216) 
    {
        version = "v1.2A";
    }

    if (version == "v1.2A")
    {
        vars.stagesRoomsID = new int[] { 580, 111, 251, 458, 402, -1};
        // 0 - rm_fairground_intro_1
        // 1 - rm_city_intro_1
        // 2 - rm_forest_intro_black
        // 3 - rm_final_jpintro1
        // 4 - rm_final_boss_pre
        // final - rm_final_boss_9

        vars.finalStage = 5;
    }
    else
    {
        vars.stagesRoomsID = new int[] { 76, 111, 251, 253, 458, 402, -1};
        // 0 - rm_fairground_1
        // 1 - rm_city_intro_1
        // 2 - rm_forest_intro_black
        // 3 - rm_forest_boss_1
        // 4 - rm_final_jpintro1
        // 5 - rm_final_boss_pre
        // final - rm_final_boss_9

        vars.finalStage = 6;
    }

    vars.menuRoomID = 8;
    vars.finalRoomID = 423;
}

start
{
    if (current.currentRoomID == vars.menuRoomID && old.isStarting == 0 && current.isStarting == 1)
    {
        return true;
    }
}

onStart
{
    vars.currentStage = 0;
}

reset
{
    if (current.currentRoomID == vars.menuRoomID && old.isStarting == 0 && current.isStarting == 1)
    {
        return true;
    }
}

split
{
    if (vars.currentStage == vars.finalStage && current.currentRoomID == vars.finalRoomID && old.isEnding == 0 && current.isEnding == 1)
    {
        return true;
    }
    else if (current.currentRoomID == vars.stagesRoomsID[vars.currentStage])
	{
		return true;
	}
}

onSplit
{
    vars.currentStage++;
}

// isLoading
// {
// 	return (current.isLoadingNow == 1);
// }
