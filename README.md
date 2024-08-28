<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>H2-MOD-Custom-Bots README</title>
</head>
<body>
    <h1>H2-MOD-Custom-Bots</h1>
    <p>This script allows you to add customizable bots to different game modes in <em>Call of Duty Modern Warfare Remastered 2</em>. You can set the number of bots individually for each game mode and display the bot count on the HUD in real time.</p>
    <ul>
        <li><strong>Custom Bot Count for Each Game Mode</strong>: Specify the number of bots for each game mode individually.</li>
        <li><strong>Dynamic HUD Updates</strong>: Display the current number of bots on the HUD with customizable colors.</li>
        <li><strong>Automatic Bot Management</strong>: Automatically handle the spawning and removal of bots based on game events.</li>
        <li><strong>Bot Server Detection</strong>: Automatically identifies if the server is a bot server based on port configuration.</li>
    </ul>
    <h2>Supported Game Modes</h2>
    <table>
        <thead>
            <tr>
                <th>Game Mode</th>
                <th>Code</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Free-for-all</td>
                <td><code>dm</code></td>
                <td>Every player for themselves.</td>
            </tr>
            <tr>
                <td>Team Deathmatch</td>
                <td><code>war</code></td>
                <td>Teams compete to get the most kills.</td>
            </tr>
            <tr>
                <td>Search and Destroy</td>
                <td><code>sd</code></td>
                <td>One team plants a bomb, the other defends.</td>
            </tr>
            <tr>
                <td>Domination</td>
                <td><code>dom</code></td>
                <td>Capture and hold objectives.</td>
            </tr>
            <tr>
                <td>Kill Confirmed</td>
                <td><code>conf</code></td>
                <td>Kill enemies and collect their tags.</td>
            </tr>
            <tr>
                <td>Sabotage</td>
                <td><code>sab</code></td>
                <td>Plant a bomb at the enemy base.</td>
            </tr>
            <tr>
                <td>Headquarters</td>
                <td><code>koth</code></td>
                <td>Capture and defend a rotating headquarters.</td>
            </tr>
            <tr>
                <td>Hardpoint</td>
                <td><code>hp</code></td>
                <td>Control a rotating point on the map.</td>
            </tr>
            <tr>
                <td>Gun Game</td>
                <td><code>gun</code></td>
                <td>Progress through weapons by getting kills.</td>
            </tr>
        </tbody>
    </table>
    <h2>Installation</h2>
    <ol>
        <li><strong>Download the Script</strong>: Place the <code>CustomBot.gsc</code> script in the following directory:
            <pre>Call of Duty Modern Warfare Remastered 2\user_scripts\mp</pre>
        </li>
        <li><strong>Configure Bot Counts</strong>: Set the desired number of bots for each game mode by using the corresponding Dvar commands in your server                   configuration file:
            <pre>
              set dm_bot_count "5"
              set war_bot_count "10"
              set sd_bot_count "8"
              set dom_bot_count "12"
              set conf_bot_count "6"
              set sab_bot_count "8"
              set koth_bot_count "10"
              set hp_bot_count "7"
              set gun_bot_count "4"
            </pre>
            Adjust the numbers according to your preferences.
        </li>
    </ol>
    <h2>How It Works</h2>
    <ol>
        <li><strong>Initialization (<code>init()</code>)</strong>: Initializes bot count variables for each game mode. Retrieves the maximum bot count for each game mode from server Dvars.</li>
        <li><strong>Game Type Detection</strong>: Detects the current game type using the <code>g_gametype</code> Dvar.</li>
        <li><strong>Bot Management</strong>: Automatically spawns the correct number of bots based on the game mode and server configuration. Adjusts the number of bots dynamically when players disconnect or new players join.</li>
        <li><strong>HUD Updates</strong>: Continuously updates the HUD with the current number of bots for the active game mode. Changes the HUD glow color dynamically for visual effects.</li>
        <li><strong>Bot Server Detection</strong>: Checks if the server is designated as a bot server based on the network port.</li>
    </ol>
    <h2>HUD Customization</h2>
    <p>The HUD shows the current number of bots for the active game mode. You can customize the HUD text and glow colors to enhance the visual experience.</p>
    <p>Example:</p>
    <ul>
        <li>Purple Glow: <code>( .7, .3, 1 )</code></li>
        <li>Green Glow: <code>( 0, 1, 0 )</code></li>
        <li>Red Glow: <code>( 1, 0, 0 )</code></li>
    </ul>
    <h2>Version History</h2>
    <ul>
        <li><strong>V1.0</strong>: Initial release with customizable bot counts for each game mode.</li>
        <li><strong>V1.1</strong>: Added dynamic HUD updates for bot count display.</li>
    </ul>
    <h2>Screenshots</h2>
    <img src="https://github.com/user-attachments/assets/5144a3d2-9cac-41c6-ad02-346d7b85cfff" alt="Custom Bot Count HUD">
    <h2>Contributing</h2>
    <p>Feel free to contribute to this project by submitting pull requests or reporting issues!</p>
    <h2>License</h2>
    <p>This project is licensed under the MIT License - see the <a href="LICENSE">LICENSE</a> file for details.</p>
</body>
</html>
