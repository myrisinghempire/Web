RISING HEMPIRE — SUPABASE GLOBAL “HIGH” SCORES

1. Create a Supabase project.
2. Open Supabase SQL Editor and run supabase-setup.sql.
3. Edit supabase-config.js with your project URL and public anon/publishable key. NEVER paste the service_role/secret key.
4. Serve the game directory over HTTP (e.g. python3 -m http.server 8080) and open http://localhost:8080.
5. Press H to see the global top 10; after crashing, enter initials to save locally and submit globally.

If Supabase is not configured, the game uses the existing local leaderboard. If the network fails, local scores remain accessible.

SECURITY: The SQL RPC validates data shape and calculates the score in the database, but cannot prove a browser run was genuine. This prototype is not cheat-resistant. Before public competitive release, use server-authoritative run validation, identity, abuse prevention and rate limits.

CUSTOM HIGH SCORES BOARD: Uses assets/high-scores-board.png as the exact visual frame, with ten live HTML text rows aligned to its slots. Desktop and mobile scale together. Row hover/title shows distance, cash, and near-miss detail. Supabase settings remain in supabase-config.js.

UPDATE: Airborne forward movement +10%, no vertical jump change. Music integration ready: add assets/music/theme.mp3, click MUSIC toggle to start; during 6-second edible slowdown playback speed smoothly approaches 65%, then recovers. Track not included yet.

SOUNDTRACK INTEGRATED: assets/music/theme.mp3 is the supplied Runner_s High.mp3 (76.67 seconds), loops continuously when enabled by MUSIC button. Brownie buff drops playback rate to 0.65 with pitch preservation explicitly disabled for deep warped audio, then ramps back to normal. Audio requires a user click due to browser autoplay restrictions.

SCORE BUTTON FIX: initialize lastSavedId before rendering/saving (previously threw ReferenceError); allow Close to dismiss unsaved entries, Run Again to discard pending and restart, and provide clear local-save status when Supabase is not connected. Refresh and score buttons remain functional.

JUMP FRAME UPDATE: Uses assets/risingwolf-jump.png throughout airborne motion, returning to the four-frame walking animation on landing. Falls back to a walking frame until jump artwork finishes loading.

NEW PLAYER INSTRUCTIONS: Every fresh page visit starts paused with a concise how-to-play overlay. Press LET'S RUN to start. The ? HOW TO PLAY button reopens the guide and pauses the game. Restarting a run does not repeatedly show the guide. The guide works on mobile and desktop.

START AUDIO UPDATE: Clicking LET'S RUN begins the included looping soundtrack within the user's click event. Existing music toggle still works; brownie slows audio to 65% with pitch lowering. Reopening help does not restart an already playing track.

TITLE SCREEN: Fresh page visit shows supplied start_menu_stylized.png with a flashing white START text button. START opens the How to Play popup. LET'S RUN begins gameplay and starts the looping soundtrack through the user's click. Restart after a crash skips the title screen. Supports small screens and reduced-motion settings.

HOTFIX: Title screen HTML/CSS is now actually injected and displayed on fresh page loads. START opens How to Play; LET'S RUN begins the soundtrack and gameplay.

GAME OVER SCREEN: Semi-transparent grey overlay with custom crown artwork; clicking Try Again? restarts immediately. Submit Score / HIGH Scores opens the leaderboard, where qualifying runs can be submitted. Closing leaderboard after game over returns to the Game Over overlay.
