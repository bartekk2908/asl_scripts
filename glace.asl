
state("Glace")
{
	byte scene : 0x09B31C, 0xAC, 0x00;
	byte bossHP : 0x09B2F0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x063C; 
	byte isDialogBox : 0x09B3E8;
}

startup
{
	vars.levelNumber = 1;
	vars.sceneNumbers = new int[] { 4, 5, 6, 7, 9, 10, 11, 17, 18, 19, 20, 23, 24, 26, 27, -1 };

	settings.Add("levelSplits", true, "Level Splits");
	settings.SetToolTip("levelSplits", "Splits between every playable level. \nDoes not apply to the last split after defeating the final boss.");

	// printing debug info
	vars.debugInfoTimeCounter = 1;
}

init
{
	vars.canReset = true;

	// printing debug info
	Action PrintValues = () =>
	{
		print("levelNumber: " + vars.levelNumber.ToString());;
		print("scene: " + current.scene.ToString());
		print("bossHP: " + current.bossHP.ToString());
		print("isDialogBox: " + current.isDialogBox.ToString());
		print("canReset: " + vars.canReset.ToString());
		print("debugInfoTimeCounter: " + vars.debugInfoTimeCounter.ToString());
	};
	vars.PrintValues = PrintValues;	
	vars.PrintValues();
}

start
{
	return current.isDialogBox == 1  && current.scene == 0;
}

onStart
{
	vars.levelNumber = 1;
	vars.canReset = false;
}

reset
{
	return current.isDialogBox == 1  && current.scene == 0 && vars.canReset;
}

onReset
{
	vars.debugInfoTimeCounter = 1;
}

update
{
	if (current.scene != 0 && !vars.canReset)
	{
		vars.canReset = true;
	}

	// printing debug info
	if (timer.CurrentTime.RealTime > TimeSpan.FromSeconds(10 * vars.debugInfoTimeCounter))
	{
		vars.PrintValues();
		vars.debugInfoTimeCounter++;
		return;
	}
}

split
{
	if (current.bossHP <= 0 && (old.bossHP == 5 || old.bossHP == 10 || old.bossHP == 15) && vars.levelNumber == 15)
	{
		return true;
	}
	if (current.scene == vars.sceneNumbers[vars.levelNumber])
	{
		vars.levelNumber++;
		return settings["levelSplits"];
	}	
}
