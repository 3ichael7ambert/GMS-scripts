// Create a room object
room_obj = obj_room;

// Generate the first room
var room = instance_create(room_width/2, room_height/2, room_obj);

// Generate additional rooms
for (var i = 0; i < 100; i++) {
    // Choose a random adjacent direction
    var direction = irandom(3);
    var x = room.x;
    var y = room.y;
    switch (direction) {
        case 0: // up
            y -= room.height;
            break;
        case 1: // right
            x += room.width;
            break;
        case 2: // down
            y += room.height;
            break;
        case 3: // left
            x -= room.width;
            break;
    }
    // Create a new room and connect it to the previous one
    var new_room = instance_create(x, y, room_obj);
    new_room.connect_to(room);
    // Set the new room as the current one
    room = new_room;
}

// Room object code
/// Create event
var width = irandom_range(64, 128);
var height = irandom_range(64, 128);
var color = c_white;
var has_enemy = false;
var has_loot = false;

/// Draw event
draw_rectangle_color(0, 0, width, height, color, false);

/// Connect to another room
var door_size = 16;
var door_color = c_black;
var door_direction = irandom(3);
switch (door_direction) {
    case 0: // up
        draw_rectangle_color(width/2-door_size/2, -door_size, width/2+door_size/2, 0, door_color, true);
        break;
    case 1: // right
        draw_rectangle_color(width, height/2-door_size/2, width+door_size, height/2+door_size/2, door_color, true);
        break;
    case 2: // down
       








// Step 1: Create a room object

// First, create an object in your game that will represent a room in the dungeon. 
// This object should have variables that represent the position of the room, its size, and any other relevant attributes. 
// You can use the built-in random() function to generate random values for these variables.

// Room object
// Create event
var width = irandom_range(128, 256);
var height = irandom_range(128, 256);
var color = c_white;
var has_enemy = false;
var has_loot = false;

// Draw event
draw_set_color(color);
draw_rectangle(0, 0, width, height, false);




// Step 2: Generate the first room

// Create an instance of the room object and place it in the center of the game screen. 
// This will be the starting point for the dungeon.
// Create the first room
room_start = instance_create(room_width/2, room_height/2, obj_room);
current_room = room_start;




// Step 3: Generate additional rooms

// Use a loop to generate additional rooms and connect them to the existing ones. Each new room should be placed randomly adjacent to an existing room, 
// and should have a doorway that connects to the existing room. You can use the instance_create() function to create new instances of the room object.
// Generate additional rooms
repeat(50) {
    // Choose a random adjacent direction
    var direction = irandom(3);
    var x = current_room.x;
    var y = current_room.y;
    switch (direction) {
        case 0: // up
            y -= current_room.height;
            break;
        case 1: // right
            x += current_room.width;
            break;
        case 2: // down
            y += current_room.height;
            break;
        case 3: // left
            x -= current_room.width;
            break;
    }
    // Create a new room and connect it to the previous one
    var new_room = instance_create(x, y, obj_room);
    new_room.connect_to(current_room);
    // Set the new room as the current one
    current_room = new_room;
}





// Step 4: Add randomness to the dungeon

// To make the dungeon feel more organic and less predictable, you can add some randomness to the room placement and size. 
// For example, you could use the irandom_range() function to generate a random size for each room, or add variations to the shapes of the rooms.
// Room object
// Create event
var width = irandom_range(128, 256);
var height = irandom_range(128, 256);
var color = c_white;
var has_enemy = false;
var has_loot = false;

// Draw event
draw_set_color(color);
draw_rectangle(0, 0, width, height, false);




// Step 5: Add enemies and loot

// To make the dungeon more interesting, you can add enemies and loot to the rooms. 
// You can use a similar procedural generation approach to randomly place enemies and items in each room.

// Room object
// Create event
var width = irandom_range(128, 256);
var height = irandom_range(128, 256);
var color = c_white;
var has_enemy = true;
var has_loot = true;

// Draw event
draw_set_color(color);
draw_rectangle(0, 0, width, height, false);

// Instance creation code
if (has_enemy) {
    instance_create(irandom_range(position), irandom_range(y position), obj_enemy);
}
if (has_loot) {
instance_create(irandom_range(x position), irandom_range(y position), obj_loot);
}






// Step 6: Add player movement

// Finally, you need to add player movement to navigate the dungeon. 
// You can use a simple approach where the player moves from one room to the next by colliding with a doorway object in each room.
// Player object
// Step event
// Check for collision with a doorway
var doorway = instance_place(x, y, obj_doorway);
if (doorway != noone) {
// Move to the next room
current_room = doorway.room_b;
x = doorway.x;
y = doorway.y;
}
