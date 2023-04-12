// Set the initial scale of the sprite
image_xscale = 1;
image_yscale = 1;

// Set the minimum and maximum scale for the bouncing effect
min_scale = 0.9;
max_scale = 1.1;

// Set the speed of the bouncing effect
bounce_speed = 0.1;

// Set the direction of the bouncing effect (1 for up, -1 for down)
bounce_direction = 1;

// Update the sprite scale every step
image_xscale += bounce_speed * bounce_direction;
image_yscale += bounce_speed * bounce_direction;

// Change the direction of the bouncing effect when the scale reaches the minimum or maximum
if (image_xscale <= min_scale || image_xscale >= max_scale) {
    bounce_direction = -bounce_direction;
}
