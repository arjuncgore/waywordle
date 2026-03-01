# Waywordle
Fun lil wordle game to play because I'm bored

## Setup
1. Close to Waywall config folder
```bash
git clone https://github.com/arjuncgore/waywordle.git ~/.config/waywall
```
2. Import to Waywall config
```lua
-- rest of config
require("waywordle.init").setup(config)
```
3. Customize it
Edit the top of `~/.config/waywall/waywordle/init.lua`
to change the key to start/stop it and the positioning. Make sure the start/stop key isn't any letters, enter, or backspace.

## How to play
Press the start/stop key (F7 by default). This will allow you to type your words. You can use backspace to fix mistakes and enter to submit a word.
Important: Your keyboard will not work while playing, and the only way to get back functionality of your keyboard is to press the start/stop key again.

## Credits
- Lincoln and Justin for the idea
- Alice for motivation
- Woof for solving my biggest headache for this project
