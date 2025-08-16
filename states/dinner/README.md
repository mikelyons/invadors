# Dinner Simulation

A first-person dinner table simulation where you can interact with guests and eat food.

## Features

- **First-person perspective** - Immersive dining experience
- **Guest interactions** - Click on guests to talk and increase happiness
- **Food consumption** - Click on food items to eat and restore hunger
- **Drag and drop sticky notes** - Take notes during dinner
- **Real-time stats** - Track hunger, happiness, and interaction count
- **Dynamic guest dialogue** - Guests randomly speak and respond to interactions

## Controls

- **Mouse** - Point and click to interact
- **D** - Enter dinner state from menu
- **Escape** - Exit dinner state
- **L** - Switch to dialogue state

## Gameplay

1. **Eating Food**: Click on food items (pizza, beer) to consume them
   - Pizza restores hunger
   - Beer increases happiness
   
2. **Talking to Guests**: Click on guest avatars to interact
   - Increases your happiness
   - Triggers dialogue bubbles
   - Guests have random conversations

3. **Sticky Notes**: Drag the yellow sticky note around to take notes

4. **Stats Tracking**: Monitor your hunger, happiness, and interaction count

## Assets Used

- `assets/items/pizza_0.png` - Pizza food item
- `assets/items/beergreenbottle.png` - Beer drink item  
- `assets/items/table_4.png` - Dinner table
- `assets/character/avatars/NN32.png` - Guest avatars
- `assets/hand-pointing-1.png` - Mouse cursor

## Technical Details

- Built using LÖVE2D framework
- Uses the existing evilNote system for drag-and-drop functionality
- Implements simple timer system for guest dialogue
- First-person point-and-click interaction mechanics
- Real-time stat tracking and updates

## Future Enhancements

- More food types and effects
- Guest personality traits
- Conversation trees
- Table setting customization
- Sound effects and music
- More detailed guest animations
- Multiple dinner scenarios
