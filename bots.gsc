//////////////////////////////////////////////////
// GAMETYPES LIST                               //
//////////////////////////////////////////////////
//                                              //
//      dm          -      Free-for-all         //
//      war         -      Team Deathmatch      //
//      sd          -      Search and Destroy   //
//      dom         -      Domination           //
//      conf        -      Kill Confirmed       //
//      sab         -      Sabotage             //
//      koth        -      Headquarters         //
//      hp          -      Hardpoint            //
//      gun         -      Gun Game             //
//                                              //
//////////////////////////////////////////////////

init()
{
    // Dvars aus der server.cfg laden und in Variablen speichern
    level.dmBotCount = 0;
    level.warBotCount = 0;
    level.sdBotCount = 0;
    level.domBotCount = 0;
    level.confBotCount = 0;
    level.sabBotCount = 0;
    level.kothBotCount = 0;
    level.hpBotCount = 0;
    level.gunBotCount = 0;

    // Dvars aus der server.cfg für die Bot-Anzahl auslesen
    level.dmMaxBots = int(getDvar("dm_bot_count"));
    level.warMaxBots = int(getDvar("war_bot_count"));
    level.sdMaxBots = int(getDvar("sd_bot_count"));
    level.domMaxBots = int(getDvar("dom_bot_count"));
    level.confMaxBots = int(getDvar("conf_bot_count"));
    level.sabMaxBots = int(getDvar("sab_bot_count"));
    level.kothMaxBots = int(getDvar("koth_bot_count"));
    level.hpMaxBots = int(getDvar("hp_bot_count"));
    level.gunMaxBots = int(getDvar("gun_bot_count"));

    gameType = getDvar("g_gametype");

    if (getDvar("sv_hostname") == "SERVER_NAME" || isBotServer())
    {
        wait 5;

        switch (gameType)
        {
            case "dm":
                spawnBots(level.dmMaxBots, "dm");
                break;
            case "war":
                spawnBots(level.warMaxBots, "war");
                break;
            case "sd":
                spawnBots(level.sdMaxBots, "sd");
                break;
            case "dom":
                spawnBots(level.domMaxBots, "dom");
                break;
            case "conf":
                spawnBots(level.confMaxBots, "conf");
                break;
            case "sab":
                spawnBots(level.sabMaxBots, "sab");
                break;
            case "koth":
                spawnBots(level.kothMaxBots, "koth");
                break;
            case "hp":
                spawnBots(level.hpMaxBots, "hp");
                break;
            case "gun":
                spawnBots(level.gunMaxBots, "gun");
                break;
            default:
                spawnBots(level.warMaxBots, gameType);
                break;
        }
    }

    level.callbackplayerdisconnect_og = level.callbackplayerdisconnect;
    level.callbackplayerdisconnect = ::callbackplayerdisconnect_stub;
}


callbackplayerdisconnect_stub(reason)
{
    // Aktuellen Spielmodus ermitteln
    gameType = getDvar("g_gametype");

    // Reduziert den Bot-Count und spawnt neue Bots, falls erforderlich
    switch (gameType)
    {
        case "dm":
            handleBotDisconnect("dm", level.dmMaxBots);
            break;
        case "war":
            handleBotDisconnect("war", level.warMaxBots);
            break;
        case "sd":
            handleBotDisconnect("sd", level.sdMaxBots);
            break;
        case "dom":
            handleBotDisconnect("dom", level.domMaxBots);
            break;
        case "conf":
            handleBotDisconnect("conf", level.confMaxBots);
            break;
        case "sab":
            handleBotDisconnect("sab", level.sabMaxBots);
            break;
        case "koth":
            handleBotDisconnect("koth", level.kothMaxBots);
            break;
        case "hp":
            handleBotDisconnect("hp", level.hpMaxBots);
            break;
        case "gun":
            handleBotDisconnect("gun", level.warMaxBots);
            break;
    }

    [[ level.callbackplayerdisconnect_og ]](reason);
}

handleBotDisconnect(gameType, maxBots)
{
    // Reduziert den Bot-Count, wenn ein Bot entfernt wird
    if (gameType == "dm" && level.dmBotCount > 0) {
        level.dmBotCount--;
        updateBotCountHud("dm"); // HUD aktualisieren
    } else if (gameType == "war" && level.warBotCount > 0) {
        level.warBotCount--;
        updateBotCountHud("war");
    } else if (gameType == "sd" && level.sdBotCount > 0) {
        level.sdBotCount--;
        updateBotCountHud("sd");
    } else if (gameType == "dom" && level.domBotCount > 0) {
        level.domBotCount--;
        updateBotCountHud("dom");
    } else if (gameType == "conf" && level.confBotCount > 0) {
        level.confBotCount--;
        updateBotCountHud("conf");
    } else if (gameType == "sab" && level.sabBotCount > 0) {
        level.sabBotCount--;
        updateBotCountHud("sab");
    } else if (gameType == "koth" && level.kothBotCount > 0) {
        level.kothBotCount--;
        updateBotCountHud("koth");
    } else if (gameType == "hp" && level.hpBotCount > 0) {
        level.hpBotCount--;
        updateBotCountHud("hp");
    } else if (gameType == "gun" && level.gunBotCount > 0) {
        level.gunBotCount--;
        updateBotCountHud("gun");
    }

    // Spawnt einen Bot, wenn weniger als die Maximalzahl vorhanden ist
    if (gameType == "dm" && level.dmBotCount < maxBots) {
        spawnBots(1, "dm");
    } else if (gameType == "war" && level.warBotCount < maxBots) {
        spawnBots(1, "war");
    } else if (gameType == "sd" && level.sdBotCount < maxBots) {
        spawnBots(1, "sd");
    } else if (gameType == "dom" && level.domBotCount < maxBots) {
        spawnBots(1, "dom");
    } else if (gameType == "conf" && level.confBotCount < maxBots) {
        spawnBots(1, "conf");
    } else if (gameType == "sab" && level.sabBotCount < maxBots) {
        spawnBots(1, "sab");
    } else if (gameType == "koth" && level.kothBotCount < maxBots) {
        spawnBots(1, "koth");
    } else if (gameType == "hp" && level.hpBotCount < maxBots) {
        spawnBots(1, "hp");
    } else if (gameType == "gun" && level.gunBotCount < maxBots) {
        spawnBots(1, "gun");
    }
}

spawnBots(amount, gameType)
{
    maxBots = amount;
    botsToSpawn = maxBots;

    if (gameType == "dm") botsToSpawn = maxBots - level.dmBotCount;
    if (gameType == "war") botsToSpawn = maxBots - level.warBotCount;
    if (gameType == "sd") botsToSpawn = maxBots - level.sdBotCount;
    if (gameType == "dom") botsToSpawn = maxBots - level.domBotCount;
    if (gameType == "conf") botsToSpawn = maxBots - level.confBotCount;
    if (gameType == "sab") botsToSpawn = maxBots - level.sabBotCount;
    if (gameType == "koth") botsToSpawn = maxBots - level.kothBotCount;
    if (gameType == "hp") botsToSpawn = maxBots - level.hpBotCount;
    if (gameType == "gun") botsToSpawn = maxBots - level.gunBotCount;

    botsToSpawn = botsToSpawn > amount ? amount : botsToSpawn;

    if (botsToSpawn > 0) {
        executecommand("spawnbot " + botsToSpawn);
        if (gameType == "dm") level.dmBotCount += botsToSpawn;
        if (gameType == "war") level.warBotCount += botsToSpawn;
        if (gameType == "sd") level.sdBotCount += botsToSpawn;
        if (gameType == "dom") level.domBotCount += botsToSpawn;
        if (gameType == "conf") level.confBotCount += botsToSpawn;
        if (gameType == "sab") level.sabBotCount += botsToSpawn;
        if (gameType == "koth") level.kothBotCount += botsToSpawn;
        if (gameType == "hp") level.hpBotCount += botsToSpawn;
        if (gameType == "gun") level.gunBotCount += botsToSpawn;
        updateBotCountHud(gameType); // HUD aktualisieren
    }
}

updateBotCountHud(gameType)
{
    if (isDefined(level.botCountHud)) {
        currentCount = 0;
        if (gameType == "dm") currentCount = level.dmBotCount;
        if (gameType == "war") currentCount = level.warBotCount;
        if (gameType == "sd") currentCount = level.sdBotCount;
        if (gameType == "dom") currentCount = level.domBotCount;
        if (gameType == "conf") currentCount = level.confBotCount;
        if (gameType == "sab") currentCount = level.sabBotCount;
        if (gameType == "koth") currentCount = level.kothBotCount;
        if (gameType == "hp") currentCount = level.hpBotCount;
        if (gameType == "gun") currentCount = level.gunBotCount;

        level.botCountHud setText("Bots (" + gameType + "): " + currentCount);
        level.botCountHud fadeOverTime(0.5);
        level.botCountHud.alpha = 1.0;
    }
}

isBotServer()
{
    port = getDvar("net_port");

    switch (port)
    {
        case "27016":
        case "27017":
        case "27018":
        case "27019":
            return true;
        default:
            return false;
    }
}