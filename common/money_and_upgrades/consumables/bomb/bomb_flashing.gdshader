shader_type spatial;

uniform vec4 flash_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); 
uniform float flash_strength;

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = flash_color.rgb;
	ALPHA = flash_strength;
	EMISSION = flash_color.rgb * flash_strength;
}
