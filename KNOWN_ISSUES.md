- Highscore.lua - something breaks menu on launch, only bg renders
- Generate.lua -  player not rendering and spawning in wrong place, apple M2 chip related, works somewhat better in LOVE 11.4

- startup
  - problem with speeding up after game loads to catch up frames and then go to normal framerate
    - solution: https://gafferongames.com/post/fix_your_timestep/

  - booting to galaxy and error on input
    - solved - newly added state must be in error