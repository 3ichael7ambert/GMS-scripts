/// @desc init_zaxis(z-start, height, shape);
/// @param z-start
/// @param height
/// @param shape
function init_zaxis(_zpos=0, _height=16, _shape = "rectangle"){
	position = {
		z: _zpos,			/// position on z axis
		z_speed: 0,		/// speed in z direction
		z_ground: 0,	/// lowest position you can fall to
		z_gravity: 0.5,	/// accelerate down
		z_height: _height,	/// height of object
		z_step: 4,		/// climb on object a little higher
		shape: _shape,	/// "square", "circle", "rectangle" supported, defaults to "square"
		shape_data: [45,135,225,315],	/// set default shape data for a square
		fix_angle: function(angle){
			if(angle < self.shape_data[0]) return 0;
			if(angle < self.shape_data[1]) return 90;
			if(angle < self.shape_data[2]) return 180;
			if(angle < self.shape_data[3]) return 270;
			return 0;
		}
	};
	
	/// calculate shape data for a rectangle
	if(_shape == "rectangle"){
		var _cx = (bbox_left + bbox_right) * 0.5;
		var _cy = (bbox_top + bbox_bottom) * 0.5; 
		/// top right corner
		position.shape_data[0] = point_direction(_cx,_cy,bbox_top,bbox_right);
		/// top left corner
		position.shape_data[1] = point_direction(_cx,_cy,bbox_top,bbox_left);
		/// bottom left corner
		position.shape_data[2] = point_direction(_cx,_cy,bbox_bottom,bbox_left);
		/// bottom right corner
		position.shape_data[3] = point_direction(_cx,_cy,bbox_bottom,bbox_right);
	}
}

/// run this in the step Event for z movement to work
function update_zaxis(){
	/// always move when speed is applied
	position.z += position.z_speed;
	/// move in z direction, 
	/// Z_Axis is assumed to point in the -Y direction (+z)
	/// therefore, positive z_speed is up, -z_speed is down
	if(position.z > position.z_ground){
		position.z_speed -= position.z_gravity;
	} else {
		/// if below ground, adjust to ground position
		position.z = max(position.z, position.z_ground);
		/// if falling, stop falling
		position.z_speed = max(position.z_speed, 0);
	}
}


function update_zground(targets){
	/// check for collision
	var _list = ds_list_create();
	var _detected = false;
	instance_position_list(x, y, targets, _list, 0);
	
	/// default lowest point
	position.z_ground = 0;
	
	/// loop through all collision instances
	for(var i = 0; i < ds_list_size(_list); i++){
		var _collide = _list[| i];
		
		/// if collision occurs, we want to get on top of that object if possible
		if(_collide != noone && variable_instance_exists(_collide, "position")){
			var _pos2 = _collide.position;
			/// if self is above the top of the other object, z_ground will now be at that height
			if(position.z + position.z_step > _pos2.z + _pos2.z_height){
				position.z_ground = max(position.z_ground, _pos2.z + _pos2.z_height);
				_detected = true;
			} 
		}
	}
	/// remove list to clear memory
	ds_list_destroy(_list);
}

/// run this in the step Event, set "targets" to obstacles you want to jump on
function collision_check_zaxis(xto, yto, targets, get_obj=false){
	/// check for collision
	var _list = ds_list_create();
	instance_position_list(xto, yto, targets, _list, 0);
	
	/// loop through all collision instances
	for(var i = 0; i < ds_list_size(_list); i++){
		var _collide = _list[| i];
		
		/// if collision occurs, we want to get on top of that object if possible
		if(_collide != noone && variable_instance_exists(_collide, "position")){
			var _pos2 = _collide.position;
			/// if self is above the top of the other object, z_ground will now be at that height
			var zfeet = position.z + position.z_step;
			var zhead = position.z + position.z_height;
			
			/// check if connecting with block
			if(zfeet < _pos2.z + _pos2.z_height && zhead > _pos2.z){
				/// also, going to fall into this!
				if(position.z_ground - position.z_step < _pos2.z + _pos2.z_height){
					ds_list_destroy(_list);
					if(get_obj){
						return _collide;	
					}
					return true;
				}
			} 
		}
	}
	/// remove list to clear memory
	ds_list_destroy(_list);
	if(get_obj){
		return noone;	
	}
	return false;
}

/// call this to jump
/// force is the speed of the jump
/// on_ground is whether to free jump or require being on the ground
function jump_zaxis(force, on_ground=true){
	if(on_ground && (position.z - position.z_step) > position.z_ground){
		show_debug_message("no jump, {0} / {1}", position.z, position.z_ground);
		return 0;
	}
	position.z_speed = force;
}

/// draw self on z_axis (best for debug)
function draw_zaxis(shape_id=0){
	var yy = y;
	var aa = image_alpha;
	var bb = image_blend;
	y -= position.z_ground;
	draw_sprite_stretched_ext(spr_shadow,shape_id,
		bbox_left,bbox_top,bbox_right-bbox_left,bbox_bottom-bbox_top,
		c_black, 0.5
	);
	y = yy;

	image_alpha = aa;
	image_blend = bb;
	y -= position.z;
	draw_self();
	y = yy;
}

/// place in step event of slope object
/// based on collision mask, works best as rectangle
function update_slope_object(player, z1, z2, on_yaxis=1){
	/// change height based on player position
	/// z1 = top or left
	/// z2 = bottom or right
	/// on_yaxis -> slope is on yaxis
	
	var ds = 0;	/// ratio between 0 and 1
	if(on_yaxis){
		/// slope is on the Y axis, top z1 bottom z2
		ds = (player.y - bbox_top) / (bbox_bottom - bbox_top);
	} else {
		// slope is on the X axis, left z1, right z2
		ds = (player.x - bbox_left) / (bbox_right - bbox_left);
	}
	ds = clamp(ds, 0, 1);
	
	/// "height" changes depending on your position (like a slope)
	position.z_height = lerp(z1, z2, ds);
	
}