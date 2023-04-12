//CREATE
// Set up movement variables
speed = 0; // Current speed
max_speed = 4; // Maximum speed
friction = 0.2; // Friction

// Set up sprite variables
sprite_index = spr_player_down_standing; // Default sprite
image_angle = 0; // Default angle



//STEP
// Set up ground variables
var friction = 0.2; // Default friction
var is_icy = false; // Default ground type

// Check for ground type
if place_meeting(x, y, obj_ground) {
    if (other.is_wet) {
        friction = 0.1; // Reduce friction for wet ground
    }
    if (other.is_icy) {
        friction = 0; // Remove friction for icy ground
        is_icy = true; // Set ground type
    }
}

// Movement controls
if keyboard_check(vk_up) {
    sprite_index = spr_player_up_walking; // Set walking sprite
    image_angle = 0; // Set angle
    if (is_icy) {
        speed = max(speed - 0.2, -max_speed); // Reduce speed on icy ground
    } else {
        speed = max(speed - friction, -max_speed); // Reduce speed
    }
    y += speed; // Move up
} else if keyboard_check(vk_down) {
    sprite_index = spr_player_down_walking; // Set walking sprite
    image_angle = 180; // Set angle
    if (is_icy) {
        speed = min(speed + 0.2, max_speed); // Increase speed on icy ground
    } else {
        speed = min(speed + friction, max_speed); // Increase speed
    }
    y += speed; // Move down
} else if keyboard_check(vk_left) {
    sprite_index = spr_player_left_walking; // Set walking sprite
    image_angle = 270; // Set angle
    image_xscale = -1; // Flip sprite
    if (is_icy) {
        if (speed > 0) {
            speed = max(speed - 0.2, 0); // Reduce speed on icy ground
        } else {
            speed = min(speed - friction, -max_speed); // Increase speed in opposite direction on icy ground
        }
    } else {
        speed = max(speed - friction, -max_speed); // Reduce speed
    }
    x += speed; // Move left
} else if keyboard_check(vk_right) {
    sprite_index = spr_player_right_walking; // Set walking sprite
    image_angle = 90; // Set angle
    image_xscale = 1; // Unflip sprite
    if (is_icy) {
        if (speed < 0) {
            speed = min(speed + 0.2, 0); // Increase speed on icy ground
        } else {
            speed = max(speed + friction, max_speed); // Increase speed in opposite direction on icy ground
        }
    } else {
        speed = min(speed + friction, max_speed); // Increase speed
    }
    x += speed; // Move right
}

// Standing animation
if (speed == 0) {
    if (image_index != 0) {
        image_index = 0;
} else {
// Walking animation
image_speed = abs(speed) / max_speed;
image_index += image_speed;
if (image_index >= image_number) {
image_index = 0;
}
}
}






// Set up movement variables
speed = 0; // Current speed
max_speed = 4; // Maximum speed
friction = 0.2; // Friction

// Set up sprite variables
// Standing sprites
spr_head_down_standing = sprite_get("head_down_standing", 0);
spr_body_down_standing = sprite_get("body_down_standing", 0);
spr_legs_down_standing = sprite_get("legs_down_standing", 0);
spr_head_left_standing = sprite_get("head_left_standing", 0);
spr_body_left_standing = sprite_get("body_left_standing", 0);
spr_legs_left_standing = sprite_get("legs_left_standing", 0);
spr_head_up_standing = sprite_get("head_up_standing", 0);
spr_body_up_standing = sprite_get("body_up_standing", 0);
spr_legs_up_standing = sprite_get("legs_up_standing", 0);
spr_head_right_standing = sprite_get("head_right_standing", 0);
spr_body_right_standing = sprite_get("body_right_standing", 0);
spr_legs_right_standing = sprite_get("legs_right_standing", 0);
// Walking sprites
spr_head_down_walking = sprite_get("head_down_walking", 0);
spr_body_down_walking = sprite_get("body_down_walking", 0);
spr_legs_down_walking = sprite_get("legs_down_walking", 0);
spr_head_left_walking = sprite_get("head_left_walking", 0);
spr_body_left_walking = sprite_get("body_left_walking", 0);
spr_legs_left_walking = sprite_get("legs_left_walking", 0);
spr_head_up_walking = sprite_get("head_up_walking", 0);
spr_body_up_walking = sprite_get("body_up_walking", 0);
spr_legs_up_walking = sprite_get("legs_up_walking", 0);
spr_head_right_walking = sprite_get("head_right_walking", 0);
spr_body_right_walking = sprite_get("body_right_walking", 0);
spr_legs_right_walking = sprite_get("legs_right_walking", 0);

sprite_head = spr_head_down_standing;
sprite_body = spr_body_down_standing;
sprite_legs = spr_legs_down_standing;

image_angle = 0; // Default angle
///////////
// Set up ground variables
var friction = 0.2; // Default friction
var is_icy = false; // Default ground type

// Check for ground type
if place_meeting(x, y, obj_ground) {
    if (other.is_wet) {
        friction = 0.1; // Reduce friction for wet ground
    }
    if (other.is_icy) {
        friction = 0; // Remove friction for icy ground
        is_icy = true; // Set ground type
    }
}

// Movement controls
if keyboard_check(vk_up) {
    // Set walking sprites
    sprite_head = spr_head_up_walking;
    sprite_body = spr_body_up_walking;
    sprite_legs = spr_legs_up_walking;
    image_angle = 0; // Set angle
    if (is_icy) {
        speedarduino
Copy code
    -= 0.1; // Reduce speed when moving up on icy ground
} else {
    speed -= friction; // Apply friction
}
}
if keyboard_check(vk_down) {
// Set walking sprites
sprite_head = spr_head_down_walking;
sprite_body = spr_body_down_walking;
sprite_legs = spr_legs_down_walking;
image_angle = 180; // Set angle
if (is_icy) {
speed += 0.1; // Increase speed when moving down on icy ground
} else {
speed += friction; // Apply friction
}
}
if keyboard_check(vk_left) {
// Set walking sprites
sprite_head = spr_head_left_walking;
sprite_body = spr_body_left_walking;
sprite_legs = spr_legs_left_walking;
image_angle = -90; // Set angle
if (is_icy) {
if (speed > 0) {
speed -= friction; // Reduce speed when moving right on icy ground
} else {
speed += friction; // Increase speed when moving left on icy ground
}
} else {
speed -= friction; // Apply friction
}
}
if keyboard_check(vk_right) {
// Set walking sprites
sprite_head = spr_head_right_walking;
sprite_body = spr_body_right_walking;
sprite_legs = spr_legs_right_walking;
image_angle = 90; // Set angle
if (is_icy) {
if (speed < 0) {
speed += friction; // Increase speed when moving left on icy ground
} else {
speed -= friction; // Reduce speed when moving right on icy ground
}
} else {
speed += friction; // Apply friction
}
}

// Check for maximum speed
if abs(speed) > max_speed {
speed = sign(speed) * max_speed;
}

// Update position
x += speed;
y += speed;

// Set standing sprites if not moving
if speed == 0 {
if image_angle == 0 {
sprite_head = spr_head_down_standing;
sprite_body = spr_body_down_standing;
sprite_legs = spr_legs_down_standing;
} else if image_angle == 180 {
sprite_head = spr_head_up_standing;
sprite_body = spr_body_up_standing;
sprite_legs = spr_legs_up_standing;
} else if image_angle == -90 {
sprite_head = spr_head_left_standing;
sprite_body = spr_body_left_standing;
sprite_legs = spr_legs_left_standing;
} else if image_angle == 90 {
sprite_head = spr_head_right_standing;
sprite_body = spr_body_right_standing;
sprite_legs = spr_legs_right_standing;
}
}

// Walking animation
if abs(speed) > 0 && abs(speed) <= max_speed {
image_speed = abs(speed) / max_speed;
image_index += image_speed;
if (image_index >= image_number) {
image_index = 0;
}
}

//DRAW
// Set the drawing color to white
draw_set_color(c_white);

// Draw the player sprite with the correct head, body, and legs sprites
draw_sprite_ext(sprite_head, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_body, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_legs, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);

// Add any additional drawing code here, such as drawing health bars or other status indicators





// Player movement
var move_speed = 4; // The player's movement speed
var friction = 0.2; // The friction applied to the player's movement

// Horizontal movement
if (keyboard_check(vk_right)) {
    hsp += move_speed;
    sprite_head = spr_player_head_right; // Set the head sprite to face right
    sprite_body = spr_player_body_right; // Set the body sprite to face right
    sprite_legs = spr_player_legs_right; // Set the legs sprite to face right
} else if (keyboard_check(vk_left)) {
    hsp -= move_speed;
    sprite_head = spr_player_head_left; // Set the head sprite to face left
    sprite_body = spr_player_body_left; // Set the body sprite to face left
    sprite_legs = spr_player_legs_left; // Set the legs sprite to face left
} else {
    hsp *= friction; // Apply friction to slow down the player's horizontal movement
}

// Vertical movement
if (keyboard_check(vk_down)) {
    vsp += move_speed;
    sprite_head = spr_player_head_down; // Set the head sprite to face down
    sprite_body = spr_player_body_down; // Set the body sprite to face down
    sprite_legs = spr_player_legs_down; // Set the legs sprite to face down
} else if (keyboard_check(vk_up)) {
    vsp -= move_speed;
    sprite_head = spr_player_head_up; // Set the head sprite to face up
    sprite_body = spr_player_body_up; // Set the body sprite to face up
    sprite_legs = spr_player_legs_up; // Set the legs sprite to face up
} else {
    vsp *= friction; // Apply friction to slow down the player's vertical movement
}

// Update the player's position
x += hsp;
y += vsp;

// Shooting
if (keyboard_check_pressed(vk_space)) {
    // Create a bullet object at the player's position with the correct direction
    var bullet = instance_create_layer(x, y, "Instances", obj_bullet);
    bullet.direction = point_direction(x, y, mouse_x, mouse_y);
}

