// Set the view properties
view_wview[0] = room_width; // Set the view width to match the room width
view_hview[0] = room_height; // Set the view height to match the room height
view_angle[0] = 45; // Set the view angle to create the slanted perspective

// Set the viewports for the top and bottom halves of the screen
view_visible[0] = true; // Show the view
view_wport[0] = room_width; // Set the viewport width to match the room width
view_hport[0] = room_height / 2; // Set the viewport height to half the room height for the top half of the screen
view_xport[0] = 0; // Set the viewport x position to the left side of the screen
view_yport[0] = 0; // Set the viewport y position to the top of the screen for the top half of the screen

view_visible[1] = true; // Show the view
view_wport[1] = room_width; // Set the viewport width to match the room width
view_hport[1] = room_height / 2; // Set the viewport height to half the room height for the bottom half of the screen
view_xport[1] = 0; // Set the viewport x position to the left side of the screen
view_yport[1] = room_height / 2; // Set the viewport y position to the bottom half of the screen

// Draw the objects
for (var i = 0; i < instance_number(obj_tree); i++) {
    var tree = instance_find(obj_tree, i);
    var dist = point_distance(tree.x, tree.y, obj_player.x, obj_player.y);
    var scale = 1 / (1 + dist / 100); // Calculate the scale based on the distance from the player
    draw_sprite_ext(sprite_tree, 0, tree.x, tree.y, scale, scale, 0, c_white, 1);
}

draw_sprite_ext(sprite_player, 0, obj_player.x, obj_player.y, 1, 1, 0, c_white, 1);
