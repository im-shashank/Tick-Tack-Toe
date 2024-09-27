shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV - 0.5;
	float d = length(uv);
	float r = 0.3;
	float c = 0.0;
	float a = 0.0;
	if (d<r && d>(r-0.05)){
		c = 0.5;
	}
	if(d<r && d>(r-0.05)){
		a = 1.0;
	}
	
	COLOR = vec4(vec3(c), a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
