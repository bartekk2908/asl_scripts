state("RUBATO")
{
    byte currentRoomID : 0x3202B70;
    byte isStarting : 0x31EBCD0, 0x4B8, 0xE60;
    byte isLoadingNow : 0x31EBCD0, 0x480, 0x660;
    byte isEnding : 0x310D670, 0x1E0, 0x2A8, 0x20, 0x460;
}

init
{
	// printing debug info
	Action PrintValues = () =>
	{
		print("currentRoomID: " + current.currentRoomID.ToString());
		print("isStarting: " + current.isStarting.ToString());
        print("isLoading: " + current.isLoadingNow.ToString());
        print("isEnding: " + current.isEnding.ToString());
	};
	vars.PrintValues = PrintValues;	
	vars.PrintValues();

    vars.stagesRoomsID = new int[] { 76, 111, 251, 253, 458, 402, -1};
}

start
{
    if (current.currentRoomID == 8 && old.isStarting == 0 && current.isStarting == 1)
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
    if (current.currentRoomID == 8 && old.isStarting == 0 && current.isStarting == 1)
    {
        return true;
    }
}

split
{
    if (vars.currentStage == 6 && current.currentRoomID == 423 && current.isEnding == true)
    {
        return true;
    }
    else if (current.currentRoomID == vars.stagesRoomsID[vars.currentStage])
	{
		vars.currentStage++;
		return true;
	}
}

isLoading
{
	return (current.isLoadingNow == 1);
}
