// Define the joystick axis IDs
var joy_x = 0;
var joy_y = 1;

// Read the joystick input
var joy_x_axis = gamepad_axis_value(0, joy_x);
var joy_y_axis = gamepad_axis_value(0, joy_y);

// Calculate the point direction based on the joystick input
var direction = point_direction(0, 0, joy_x_axis, -joy_y_axis);

// Set the point direction variable
point_direction_variable = direction;
