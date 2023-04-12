
// 1. Create two objects in your game: one for the background and one for the foreground.
// 2. Set the depth value of the background object to a lower value than the foreground object. 
// For example, you might set the background object's depth to -10 and the foreground object's depth to 0.
// 3. In the background object's "Create" event, set its x and y coordinates to 0, so that it appears at the top left corner of the room:
// // Set the background object's position
x = 0;
y = 0;

// 4. In the foreground object's "Create" event, set its x and y coordinates to the center of the room, so that it appears in front of the background:

// // Set the foreground object's position
x = room_width / 2;
y = room_height / 2;


// 5. In the foreground object's "Step" event, move it based on the player's position. 
// For example, you might use the following code to move the foreground object left and right as the player moves:
// // Move the foreground object based on the player's position
x += (mouse_x - x) / 10;

// 6. In the background object's "Step" event, move it at a slower rate than the foreground object. 
//For example, you might use the following code to move the background object left and right as the player moves, but at half the speed of the foreground object:
// // Move the background object based on the player's position, but at a slower rate
x += (mouse_x - x) / 20;
// This will create a parallax effect where the foreground object appears to move faster than the background object, creating the illusion of depth as the player moves through the level. Note that you can adjust the depth and movement values to achieve the desired parallax effect for your game.