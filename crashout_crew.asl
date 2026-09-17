state("CrashoutCrew") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        // Celujemy w ShiftManagera
        var shiftManager = mono["febjam", "ShiftManager"];
        
        // --- 1. Zmienne konfiguracyjne (Powinny zawsze mieć wartość inną niż 0) ---
        vars.Helper["startingMoney"] = shiftManager.Make<int>("instance", "startingMoney");
        vars.Helper["orgDuration"] = shiftManager.Make<float>("instance", "organizationalDuration");
        vars.Helper["achHoarder"] = shiftManager.Make<int>("instance", "achievementHoarderAmount");
        vars.Helper["scoreMult"] = shiftManager.Make<float>("instance", "scoreMultiplierOnePlayer");

        // --- 2. Zmienne sieciowe (SyncVars) ---
        vars.Helper["syncMoney"] = shiftManager.Make<int>("instance", "_syncMoney");
        vars.Helper["syncTrucks"] = shiftManager.Make<int>("instance", "_syncTrucksCompleted");
        vars.Helper["syncSeconds"] = shiftManager.Make<float>("instance", "_syncSecondsRemaining");
        vars.Helper["syncLockedIn"] = shiftManager.Make<bool>("instance", "_syncLockedIn");

        // --- 3. Wewnętrzny stan gry ---
        vars.Helper["currentShift"] = shiftManager.Make<int>("instance", "_currentShift");
        vars.Helper["shiftPhase"] = shiftManager.Make<int>("instance", "_shiftPhase");
        vars.Helper["playerCount"] = shiftManager.Make<int>("instance", "_serverPlayerCount");
        vars.Helper["transitioning"] = shiftManager.Make<bool>("instance", "_transitioning");
        vars.Helper["trucksThisShift"] = shiftManager.Make<int>("instance", "_trucksThisShift");

        return true;
    });
}

update
{
    vars.Helper.Update();
    
    // Wypisujemy wszystko do DebugView. Podzieliłem to na linie dla czytelności.
    print(
        "=== SHIFT MANAGER DATA ===\n" +
        "KONFIG: StartMoney=" + current.startingMoney.ToString() + 
        " | OrgDur=" + current.orgDuration.ToString() + 
        " | AchAmount=" + current.achHoarder.ToString() + 
        " | ScoreMult=" + current.scoreMult.ToString() + "\n" +
        
        "SIEĆ: SyncMoney=" + current.syncMoney.ToString() + 
        " | SyncTrucks=" + current.syncTrucks.ToString() + 
        " | SyncSecs=" + current.syncSeconds.ToString() + 
        " | LockedIn=" + current.syncLockedIn.ToString() + "\n" +
        
        "STAN: Zmiana=" + current.currentShift.ToString() + 
        " | Faza=" + current.shiftPhase.ToString() + 
        " | Gracze=" + current.playerCount.ToString() + 
        " | Transition=" + current.transitioning.ToString() + 
        " | WymaganeCiezarowki=" + current.trucksThisShift.ToString() + "\n" +
        "=========================="
    );
}
start
{

}

split
{

}

reset
{
    
}

isLoading
{
    
}
