return [[
#ifdef GL_ES
precision highp float;
#endif
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

void main()
{
    // TODO: Do a more intelligent scaling based on resolution here
    vec2 u_blurCenter = vec2([blurCenter]);
    float u_blurSize = [blurSize];
    vec2 samplingOffset = 1.0/100.0 * (u_blurCenter - v_texCoord) * u_blurSize;

#ifdef GL_ES
    lowp vec4 fragmentColor = texture2D(CC_Texture0, v_texCoord) * 0.18;
#else
    vec4 fragmentColor = texture2D(CC_Texture0, v_texCoord) * 0.18;
#endif
    fragmentColor += texture2D(CC_Texture0, v_texCoord + samplingOffset) * 0.15;
    fragmentColor += texture2D(CC_Texture0, v_texCoord + (2.0 * samplingOffset)) *  0.12;
    fragmentColor += texture2D(CC_Texture0, v_texCoord + (3.0 * samplingOffset)) * 0.09;
    fragmentColor += texture2D(CC_Texture0, v_texCoord + (4.0 * samplingOffset)) * 0.05;
    fragmentColor += texture2D(CC_Texture0, v_texCoord - samplingOffset) * 0.15;
    fragmentColor += texture2D(CC_Texture0, v_texCoord - (2.0 * samplingOffset)) *  0.12;
    fragmentColor += texture2D(CC_Texture0, v_texCoord - (3.0 * samplingOffset)) * 0.09;
    fragmentColor += texture2D(CC_Texture0, v_texCoord - (4.0 * samplingOffset)) * 0.05;

    gl_FragColor = fragmentColor * v_fragmentColor;
}
]]
