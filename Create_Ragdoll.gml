function Create_Ragdoll(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12, argument13, argument14, argument15) {
	/*
	 --------------- target_part Chart --------------
	|                  0 = none                      |
	|                  1 = head                      |
	|                  2 = torso                     |
	|                  3 = waist                     |
	|                  4 = upperleg1                 |
	|                  5 = upperleg2                 |
	|                  6 = lowerleg1                 |
	|                  7 = lowerleg2                 |
	 ------------------------------------------------
	 Thank you for buying this script from me at Coders Dynamic. I hope it makes your life easier while you make awesome games!
 
	 Here are some notes to get you set up for your Ragdolls:
	 - Target part is the part that is targeted with the forcex and forcey. So if you wanted the torso to be hit by a large mass,
	 this can make the ragdoll be pushed by his chest.
 
	 - The Initial force is what the whole ragdoll will experiance when the ragdoll is spawned.
 
	 - Don't worry about the sprite sizes, this code was made with utility in mind, so the ragdoll parts WILL adjust to any part you give it, 
	 however keep in mind this will make Humanoid ragdolls only.
 
	 - You NEED to have obj_ragPart, this object will make and keep all the needed stuff for thr different parts of the ragdoll.
 
	 - Included with this is also obj_ragdoll, which doesn't need to be used, however it comes with some nice framerate enhancing code so you don't need to
	 worry about it.
 
	 - Each ragdoll part does have the capibility to fall off from the ragdoll if there is enough force delt upon it. You can even add collision events
	 to obj_ragPart and make it lose health to bullets, magic, ect.
 
	 - Note that Direction should be 1 or -1. 1 is facing right, where as -1 is faceing left.
	*/

	/// @function  Create_Ragdoll
	/// @param	Origin
	/// @param	Head_Sprite 
	/// @param	Neck_Sprite
	/// @param  Torso_Sprite
	/// @param  Waist_Sprite
	/// @param  UpperArm_Sprite
	/// @param  LowerArm_Sprite
	/// @param  UpperLeg_sprite
	/// @param  LowerLeg_Sprite
	/// @param  Foot_Sprite
	/// @param  Target Force x
	/// @param  Target Force y
	/// @param  Target_Part
	/// @param  Direction
	/// @param  Initial_forcex
	/// @param  Initial_forcey

	//This sets up all the argument variables to their corrisponding variable
	ragdoll = argument0;
	head	= argument1;
	neck	= argument2;
	torso	= argument3;
	waist	= argument4;
	upperArm= argument5;
	lowerArm= argument6;
	upperLeg= argument7;
	lowerLeg= argument8;
	foot	= argument9;
	forcex	= argument10;
	forcey	= argument11;
	target_part = argument12;
	dir		= argument13
	ini_forcex = argument14;
	ini_forcey = argument15;

	if (!variable_global_exists("global.cur_rag")){global.cur_rag = 1;}

	x = ragdoll.x;
	y = ragdoll.y;
	ragID = -1;//Negative numbers will make the ragdoll not collide with itself
	var myDepth = depth;

	//Settings
	gibs = true;

	//Head
	h = instance_create_depth(x,y,myDepth,obj_ragPart); //Creates the ragpart instance, under the "h" variable.
	with h{
	    title = "head"; //This sets the title variable in obj_ragPart, this is so other objects can know what part it is.
	    dir = other.dir; //This sets the scale_x variable.
	    ini_forcex = other.ini_forcex; //This is the initial X-cordinate force on the part.
	    ini_forcey = other.ini_forcey; //This is the initial Y-cordinate force on the part.
	    sprite_index = other.head; // This sets the sprite of obj_ragPart, to the head variable already defined above.
	    fix = physics_fixture_create(); //This starts to create a physics hitbox
	    physics_fixture_set_circle_shape(fix, sprite_get_width(other.head)/2); //This sets the shape of the physics hitbox
	    physics_fixture_set_collision_group(fix,other.ragID); //This makes it never collide with itself aslong as ragID is negative
	    physics_fixture_set_density(fix, .1); //This sets it's density (I calculated each human bodypart for their proper density)
	    physics_fixture_set_friction(fix, .5); //This sets the friction
	    physics_fixture_set_linear_damping(fix, .5) //This sets the air resistance, which was also calculated.
	    physics_fixture_bind(fix,self); //This sets the physics hitbox to radpart now.
	    //physics_mass_properties(.05,0,0,phy_inertia); //This sets the mass of the bodypart this can cause issues, use carefully
	    joint = false; //This is a variable in obj_ragPart, which should be false if it is not connected to anything (this is the only part that does that)
	    if other.target_part = 1{ //This checks the part that was hit, if one was hit.
	        forcex = other.forcex; //This adds a new X force to it, if the head was hit. 
	        forcey = other.forcey; //This add a new y force to it, if the head was hit.
	        hp = irandom_range(-10,50); //This is the hp variable, if the head was hit then it will go down for the initial ragdoll.
	    }
	}
	if gibs {h.hp = 999999999};

	//Neck
	n = instance_create_depth(x,h.y+(sprite_get_height(head)/2)+(sprite_get_height(neck)/2)-1,myDepth,obj_ragPart);
	with n{
	    title = "neck";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.neck;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.neck)/2, sprite_get_height(other.neck)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .05);
	    physics_fixture_set_friction(fix, .4);
	    physics_fixture_set_linear_damping(fix, .1)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(.1,0,0,phy_inertia)
	    j = physics_joint_revolute_create(other.h, self, x, other.h.y+sprite_get_height(other.head)/2, 0, 0, true, 0, 0, false, true); //This makes a joint on the part so it's connected to "head"
	    target_j = other.h;
	    joint = true;
	}
	if gibs {n.hp = 999999999};


	//Torso
	t = instance_create_depth(x,n.y+(sprite_get_height(neck)/2)+(sprite_get_height(torso)/2)-1,myDepth,obj_ragPart);
	with t{
	    title = "torso";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.torso;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.torso)/2, sprite_get_height(other.torso)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .6);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .5)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(22,0,0,phy_inertia);
	    j = physics_joint_revolute_create(self,other.n , x, other.n.y+sprite_get_height(other.neck)/2, -20 , 20, true, 0, 0, false, true);
	    target_j = other.n;
	    joint = true;
	    if other.target_part = 2{
	        forcex = other.forcex;
	        forcey = other.forcey;
	    }
	}
	if gibs {t.hp = 999999999};
	//Waist
	w = instance_create_depth(x,t.y+(sprite_get_height(torso)/2)+(sprite_get_height(waist)/2)-3,myDepth,obj_ragPart);
	with w{
	    title = "waist";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.waist;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.waist)/2, sprite_get_height(other.waist)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .4);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .3)
	    physics_fixture_bind(fix,other.w);
	    //physics_mass_properties(5,0,0,phy_inertia);
	    j = physics_joint_revolute_create(other.t, self, x, other.t.y+sprite_get_height(other.torso)/2, -20, 20, true, 0, 0, false, true);
	    target_j = other.t;
	    joint = true;
	    if other.target_part = 3{
	        forcex = other.forcex;
	        forcey = other.forcey;
	        hp = irandom_range(40,70) - (abs(other.forcex + other.forcey)/2);
	    }
	}
	if gibs {w.hp = 999999999};

	//Upper Arm 1
	UA1 = instance_create_depth(x,t.y-(sprite_get_height(torso)/2)+(sprite_get_height(upperArm)/2)+1,myDepth,obj_ragPart);
	with UA1{
	    title = "upperArmFront";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.upperArm;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.upperArm)/2, sprite_get_height(other.upperArm)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .2);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .2)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(2,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.t, self, other.t.x, other.t.y-(sprite_get_height(other.torso)/2)+(sprite_get_height(other.upperArm)/2)+1, -175, 45, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.t, self, other.t.x, other.t.y-(sprite_get_height(other.torso)/2)+(sprite_get_height(other.upperArm)/2)+1, -45, 175, true, 0, 0, false, true);
	    }
	    target_j = other.t;
	    depth = -1;
	    joint = true;
	}
	if gibs {UA1.hp = 999999999};

	//Upper Arm 2
	UA2 = instance_create_depth(x,t.y-(sprite_get_height(torso)/2)+(sprite_get_height(upperArm)/2)+1,myDepth,obj_ragPart);
	with UA2{
	    title = "upperArmBack";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.upperArm;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.upperArm)/2, sprite_get_height(other.upperArm)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .2);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .2)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(2,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.t, self, other.t.x, other.t.y-(sprite_get_height(other.torso)/2)+(sprite_get_height(other.upperArm)/2)+1, -175, 45, true, 0, 0, false, true);
	    }else{
	         j = physics_joint_revolute_create(other.t, self, other.t.x, other.t.y-(sprite_get_height(other.torso)/2)+(sprite_get_height(other.upperArm)/2)+1, -45, 175, true, 0, 0, false, true);
	    }
	    target_j = other.t;
	    depth = 1;
	    joint = true;
	}
	if gibs {UA2.hp = 999999999};

	//Lower Arm 1
	LA1 = instance_create_depth(x,UA1.y+(sprite_get_height(upperArm)/2)+(sprite_get_height(lowerArm)/2)-1,myDepth,obj_ragPart);
	with LA1{
	    title = "lowerArmFront";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.lowerArm;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.lowerArm)/2, sprite_get_height(other.lowerArm)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .2);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .2)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(1,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.UA1, self, other.UA1.x, other.UA1.y+(sprite_get_height(other.upperArm)/2), -75, 0, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.UA1, self, other.UA1.x, other.UA1.y+(sprite_get_height(other.upperArm)/2), 0, 75, true, 0, 0, false, true);
	    }
	    target_j = other.UA1;
	    depth = -1;
	    joint = true;
	}
	if gibs {LA1.hp = 999999999};

	//Lower Arm 2
	LA2 = instance_create_depth(x,UA2.y+(sprite_get_height(upperArm)/2)+(sprite_get_height(lowerArm)/2)-1,myDepth,obj_ragPart);
	with LA2{
	    title = "lowerArmBack";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.lowerArm;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.lowerArm)/2, sprite_get_height(other.lowerArm)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .2);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .2)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(1,0,0,self);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.UA2, self, other.UA2.x, other.UA2.y+(sprite_get_height(other.upperArm)/2), -75, 0, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.UA2, self, other.UA2.x, other.UA2.y+(sprite_get_height(other.upperArm)/2), 0, 75, true, 0, 0, false, true);
	    }
	    target_j = other.UA2;
	    depth = 1;
	    joint = true;
	}
	if gibs {LA2.hp = 999999999};

	//Upper Leg 1
	UL1 = instance_create_depth(x,w.y+(sprite_get_height(waist)/2)+(sprite_get_height(upperLeg)/2)-1,myDepth,obj_ragPart);
	with UL1{
	    title = "upperLegFront";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.upperLeg;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.upperLeg)/2, sprite_get_height(other.upperLeg)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .3);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .3)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(4,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.w, self, x, other.w.y+sprite_get_height(other.waist)/2, -90, 5, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.w, self, x, other.w.y+sprite_get_height(other.waist)/2, -5, 90, true, 0, 0, false, true);
	    }
	    target_j = other.w;
	    depth = -1;
	    joint = true;
	    if other.target_part = 4{
	        forcex = other.forcex;
	        forcey = other.forcey;
	        hp = irandom_range(-10,30) - (abs(other.forcex + other.forcey)/2);
	    }
	}
	if gibs {UL1.hp = 999999999};

	//Upper Leg 2
	UL2 = instance_create_depth(x,w.y+(sprite_get_height(waist)/2)+(sprite_get_height(upperLeg)/2)-1,myDepth,obj_ragPart);
	with UL2{
	    title = "upperLegBack";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.upperLeg;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.upperLeg)/2, sprite_get_height(other.upperLeg)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .5);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .3)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(4,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.w, self, x, other.w.y+sprite_get_height(other.waist)/2, -90, 5, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.w, self, x, other.w.y+sprite_get_height(other.waist)/2, -5, 90, true, 0, 0, false, true);
	    }
	    target_j = other.w;
	    depth = 1;
	    joint = true;
	    if other.target_part = 5{
	        forcex = other.forcex;
	        forcey = other.forcey;
	        hp = irandom_range(-10,30) - (abs(other.forcex + other.forcey)/2);
	    }
	}
	if gibs {UL2.hp = 999999999};

	//Lower Leg 1
	LL1 = instance_create_depth(x,UL1.y+(sprite_get_height(upperLeg)/2)+(sprite_get_height(lowerLeg)/2)-1,myDepth,obj_ragPart);
	with LL1{
	    title = "lowerLegFront";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.lowerLeg;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.lowerLeg)/2, sprite_get_height(other.lowerLeg)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .4);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .2)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(2,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.UL1, self, x, other.UL1.y+sprite_get_height(other.upperLeg)/2, 0, 100, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.UL1, self, x, other.UL1.y+sprite_get_height(other.upperLeg)/2, -100, 0, true, 0, 0, false, true);
	    }
	    target_j = other.UL1;
	    depth = -1;
	    joint = true;
	    if other.target_part = 6{
	        forcex = other.forcex;
	        forcey = other.forcey;
	        hp = irandom_range(-20,30) - (abs(other.forcex + other.forcey)/2);
	    }
	}
	if gibs {LL1.hp = 999999999};

	//Lower Leg 2
	LL2 = instance_create_depth(x,UL2.y+(sprite_get_height(upperLeg)/2)+(sprite_get_height(lowerLeg)/2)-1,myDepth,obj_ragPart);
	with LL2{
	    title = "lowerLegBack";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.lowerLeg;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.lowerLeg)/2, sprite_get_height(other.lowerLeg)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .4);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .2)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(2,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.UL2, self, x, other.UL2.y+sprite_get_height(other.upperLeg)/2, 0, 100, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.UL2, self, x, other.UL2.y+sprite_get_height(other.upperLeg)/2, -100, 0, true, 0, 0, false, true);
	    }
	    target_j = other.UL2;
	    depth = 1;
	    joint = true;
	    if other.target_part = 7{
	        forcex = other.forcex;
	        forcey = other.forcey;
	        hp = irandom_range(-20,30) - (abs(other.forcex + other.forcey)/2);
	    }
	}
	if gibs {LL2.hp = 999999999};

	//Foot 1
	F1 = instance_create_depth(x,LL1.y+(sprite_get_height(lowerLeg)/2)+(sprite_get_height(foot)/2)-1,myDepth,obj_ragPart);
	with F1{
	    title = "footFront";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.foot;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.foot)/2, sprite_get_height(other.foot)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .2);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .2)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(1,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.LL1, self, x, other.LL1.y+sprite_get_height(other.lowerLeg)/2, -45, 5, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.LL1, self, x, other.LL1.y+sprite_get_height(other.lowerLeg)/2, -5, 45, true, 0, 0, false, true);
	    }
	    target_j = other.LL1;
	    depth = -1;
	    joint = true;
	}
	if gibs {F1.hp = 999999999};

	//Foot 2
	F2 = instance_create_depth(x,LL1.y+(sprite_get_height(lowerLeg)/2)+(sprite_get_height(foot)/2)-1,myDepth,obj_ragPart);
	with F2{
	    title = "footBack";
	    dir = other.dir;
	    ini_forcex = other.ini_forcex;
	    ini_forcey = other.ini_forcey;
	    sprite_index = other.foot;
	    fix = physics_fixture_create();
	    physics_fixture_set_box_shape(fix, sprite_get_width(other.foot)/2, sprite_get_height(other.foot)/2);
	    physics_fixture_set_collision_group(fix,other.ragID);
	    physics_fixture_set_density(fix, .2);
	    physics_fixture_set_friction(fix, .5);
	    physics_fixture_set_linear_damping(fix, .2)
	    physics_fixture_bind(fix,self);
	    //physics_mass_properties(1,0,0,phy_inertia);
	    if dir = 1{
	        j = physics_joint_revolute_create(other.LL2, self, x, other.LL2.y+sprite_get_height(other.lowerLeg)/2, -45, 5, true, 0, 0, false, true);
	    }else{
	        j = physics_joint_revolute_create(other.LL2, self, x, other.LL2.y+sprite_get_height(other.lowerLeg)/2, -5, 45, true, 0, 0, false, true);
	    }
	    target_j = other.LL2;
	    depth = 1;
	    joint = true;
	}
	if gibs {F2.hp = 999999999};

	//This sets the master object
	ragdoll.h= h;
	ragdoll.n = n;
	ragdoll.t = t;
	ragdoll.w = w;
	ragdoll.UA1 = UA1;
	ragdoll.UA2 = UA2;
	ragdoll.LA1 = LA1;
	ragdoll.LA2 = LA2;
	ragdoll.UL1 = UL1;
	ragdoll.UL2 = UL2;
	ragdoll.LL1 = LL1;
	ragdoll.LL2 = LL2;
	ragdoll.F1 = F1;
	ragdoll.F2 = F2;
	global.cur_rag++;


}
