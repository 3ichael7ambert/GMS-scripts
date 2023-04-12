// define the game time variable
global.game_time = 0;

// draw the game objects based on the current time
if (global.game_time == 0) {
    draw_sprite(sprite_background, 0, 0, 0);
} else if (global.game_time == 1) {
    draw_sprite(sprite_background_1, 0, 0, 0);
} else if (global.game_time == 2) {
    draw_sprite(sprite_background_2, 0, 0, 0);
}

// update the game time based on input
if (keyboard_check_pressed(vk_left)) {
    global.game_time -= 1;
    if (global.game_time < 0) {
        global.game_time = 2;
    }
} else if (keyboard_check_pressed(vk_right)) {
    global.game_time += 1;
    if (global.game_time > 2) {
        global.game_time = 0;
    }
}
