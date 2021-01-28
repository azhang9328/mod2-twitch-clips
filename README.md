Flatiron - Mod 2 Project: Top Twitch Games/Clips
===
## About
Displays current top games being streamed and clips for those games according to Twitch. Allows users to see game information, clip information and streamers information.
Users can add games and clips to favorites and view them in their profile.
## How To Use
1. Clone to computer.
2. In terminal run bundle install, rails db:migrate, and either rails c, AskTwitch.update_db or rails s and click Check twitch to seed/update database.
3. localhost:3000/ in browser.
## MVP
1. User able to create/login
2. User able to view top clips from last 24 hrs from specific game
3. User able to view specific streamer info or clip info
4. User able to add/delete clip to/from favorites
5. User able to edit favorite clip titles
6. User able to view all favorited
## Stretch Goals
1. More validations and restrictions Ex. login/signup breaks when logged in.
2. Actually flash messages.
## Known Issues
1. Populating/updating DB can break part way due to edge case(?), usually fills db with enough data before. If Check Twitch button breaks, backspace to see updated db.
