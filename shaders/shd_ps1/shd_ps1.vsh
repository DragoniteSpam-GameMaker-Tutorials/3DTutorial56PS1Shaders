attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_worldPosition;
varying vec3 v_worldNormal;
varying vec4 v_eyeSpacePosition;

void main() {
    vec4 object_space_pos = vec4(in_Position, 1.0);
    
    v_worldPosition = (gm_Matrices[MATRIX_WORLD] * object_space_pos).xyz;
    v_worldNormal = normalize(gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.)).xyz;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    
    
    vec4 eye_space = gm_Matrices[MATRIX_WORLD_VIEW] * object_space_pos;
    float snap_amount = 2.0;
    eye_space.xy = floor(eye_space.xy / snap_amount) * snap_amount;
    
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * eye_space;
    
    v_vTexcoord *= eye_space.z;
    v_eyeSpacePosition = eye_space;
}