// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function vec2_class(vx = 0, vy = 0) constructor{
	self.x = vx;
	self.y = vy;
	static normalize = function(){
		var dis = self.length();
		if(dis == 0){
			return;	
		}
		self.x /= dis;
		self.y /= dis;
	};
	static length = function(){
		return(point_distance(0,0,self.x,self.y));
	};
	static set = function(vx, vy){
		self.x = vx;
		self.y = vy;
	};
	static add = function(v2){
		self.x += v2.x;
		self.y += v2.y;
	};
	static dot = function(v2){
		return(dot_product(self.x,self.y,v2.x,v2.y));
	};
	static scale = function(value){
		self.x *= value;
		self.y *= value;
	};
	static angle = function(){
		return(point_direction(0,0,self.x,self.y));	
	};
	static lengthdir = function(length, angle){
		self.x = lengthdir_x(length, angle);
		self.y = lengthdir_y(length, angle);
	};
	static add_lengthdir = function(length, angle){
		self.x += lengthdir_x(length, angle);
		self.y += lengthdir_y(length, angle);
	};
	static set_length = function(length){
		self.normalize();
		self.scale(length);
	};
	static vector_from_points = function(x1,y1,x2,y2){
		var angle = point_direction(x1,y1,x2,y2);
		var dist = point_distance(x1,y1,x2,y2);
		self.add_lengthdir(dist, angle);
	};
	static to_array = function(){
		return [self.x, self.y];
	};
	static from_array = function(arr){
		self.x = arr[0];
		self.y = arr[1];
	};
}