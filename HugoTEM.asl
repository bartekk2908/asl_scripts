state("Hugo5")
{
    byte isNotLoading : 0x864D4, 0x9A4;
    byte levelID : 0x86514, 0x28, 0x18;
    byte mirrorsLeft : 0x8A4BC, 0xC, 0x8, 0xA98;
}

init
{
    vars.mainMenuID = (byte)1;
    vars.introID = (byte)2;
    vars.menuID = (byte)3;
    vars.levelIDs = new List<byte> {19, 5, 12, 22, 8, 15};
    vars.finalID = (byte)25;

    vars.endingTime = null;
}

start
{
    return (current.levelID == vars.introID && old.levelID == vars.mainMenuID);
}

reset
{
    return (current.levelID == vars.introID && old.levelID == vars.mainMenuID);
}

split
{
    if (current.levelID == vars.menuID && vars.levelIDs.Contains(old.levelID))
    {
        return true;
    }
    
    if (current.levelID == vars.finalID && current.mirrorsLeft == 0 && old.mirrorsLeft == 1)
	{
		vars.endingTime = timer.CurrentTime.RealTime;
	}

    if (vars.endingTime != null && timer.CurrentTime.RealTime >= vars.endingTime + TimeSpan.FromSeconds(4.3))
    {
        return true;
    }
}

isLoading
{
    return current.isNotLoading == 0;
}
