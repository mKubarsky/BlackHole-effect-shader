shader_type canvas_item;

uniform float strengthEffect = 0.3;  
const float effectRadius = 0.5;
const float correctEffectRadiusFactor = 0.3; 
const float horizonRadius = 0.12;

float circle(vec2 position, float feather, float radius)
{
	return smoothstep(feather, feather + radius, length(position - vec2(0.5)));
}

void fragment(){
	vec2 vecToCenter = vec2(0.5, 0.5) - vec2(UV.x, 1f-UV.y);
	float distToCenter = length(vecToCenter);
	vec2 direction = normalize(vecToCenter);
	vec3 col = texture(SCREEN_TEXTURE, SCREEN_UV).xyz; // pixel from texture

	float effect_pixel = circle(UV, 0.1, effectRadius + correctEffectRadiusFactor);

	float effectValue = clamp(effectRadius - effect_pixel, 0f, 1f);  
	float displacement = smoothstep(0f, 1f, effectValue * strengthEffect);

	vec2 uv = SCREEN_UV + direction*displacement;
	
	if(distToCenter < horizonRadius){
		col = vec3(0,0,0); // drow horizon
	} 
	else if (distToCenter < effectRadius && distToCenter > horizonRadius)
	{
		col = texture(SCREEN_TEXTURE, uv).xyz; // drow effect
	}
	COLOR = vec4(col, 1f);
	
}

