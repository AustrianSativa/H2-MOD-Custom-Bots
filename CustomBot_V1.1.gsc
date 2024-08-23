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

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    // Initialisiere Bot-Zählvariablen
    level.dmBotCount = 0;
    level.warBotCount = 0;
    level.sdBotCount = 0;
    level.domBotCount = 0;
    level.confBotCount = 0;
    level.sabBotCount = 0;
    level.kothBotCount = 0;
    level.hpBotCount = 0;
    level.gunBotCount = 0;

    // Setze Maximalwerte für Bots
    level.dmMaxBots = int(getDvar("dm_bot_count"));
    level.warMaxBots = int(getDvar("war_bot_count"));
    level.sdMaxBots = int(getDvar("sd_bot_count"));
    level.domMaxBots = int(getDvar("dom_bot_count"));
    level.confMaxBots = int(getDvar("conf_bot_count"));
    level.sabMaxBots = int(getDvar("sab_bot_count"));
    level.kothMaxBots = int(getDvar("koth_bot_count"));
    level.hpMaxBots = int(getDvar("hp_bot_count"));
    level.gunMaxBots = int(getDvar("gun_bot_count"));

    // Bestimme den aktuellen Spielmodus
    gameType = getDvar("g_gametype");

    // Spawne Bots basierend auf dem Spielmodus
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


    if (getDvarInt("enable_botHud") == 1) {
        level thread bothudLoop();
    }

}

bothudLoop()
{
    info = level createServerFontString("objective", 0.95);
    info setPoint("LEFT", "BOTTOMLEFT", 63, -28);
    info.glowalpha = .6;
    info.hideWhenInMenu = true;

    while (true)
    {
        gameType = getDvar("g_gametype");

        // Aktualisiere die HUD-Anzeige mit der Bot-Anzahl
        if (gameType == "dm") {
            info setText("FFA Bots: " + level.dmBotCount + "/" + level.dmMaxBots);
        } else if (gameType == "war") {
            info setText("TDM Bots: " + level.warBotCount + "/" + level.warMaxBots);
        } else if (gameType == "sd") {
            info setText("S&D Bots: " + level.sdBotCount + "/" + level.sdMaxBots);
        } else if (gameType == "dom") {
            info setText("DOM Bots: " + level.domBotCount + "/" + level.domMaxBots);
        } else if (gameType == "conf") {
            info setText("CONF Bots: " + level.confBotCount + "/" + level.confMaxBots);
        } else if (gameType == "sab") {
            info setText("SAB Bots: " + level.sabBotCount + "/" + level.sabMaxBots);
        } else if (gameType == "koth") {
            info setText("KOTH Bots: " + level.kothBotCount + "/" + level.kothMaxBots);
        } else if (gameType == "hp") {
            info setText("HP Bots: " + level.hpBotCount + "/" + level.hpMaxBots);
        } else if (gameType == "gun") {
            info setText("GUN Bots: " + level.gunBotCount + "/" + level.gunMaxBots);
        } else {
            info setText("Unknown Game Type");
        }

        info.glowcolor = ( .7, .3, 1 );
        wait 20;
        info.glowcolor = ( 0, 1, 0 );
        wait 14;
        info.glowcolor = ( 1, 0, 0 );
        wait 8;
    }
}

callbackplayerdisconnect_stub(reason)
{
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
    if (gameType == "dm" && level.dmBotCount > 0) {
        level.dmBotCount--;
    } else if (gameType == "war" && level.warBotCount > 0) {
        level.warBotCount--;
    } else if (gameType == "sd" && level.sdBotCount > 0) {
        level.sdBotCount--; 
    } else if (gameType == "dom" && level.domBotCount > 0) {
        level.domBotCount--;  
    } else if (gameType == "conf" && level.confBotCount > 0) {
        level.confBotCount--;  
    } else if (gameType == "sab" && level.sabBotCount > 0) {
        level.sabBotCount--;
    } else if (gameType == "koth" && level.kothBotCount > 0) {
        level.kothBotCount--;
    } else if (gameType == "hp" && level.hpBotCount > 0) {
        level.hpBotCount--;
    } else if (gameType == "gun" && level.gunBotCount > 0) {
        level.gunBotCount--;
    }

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
