/**
 * inspiraed by ElementMo's GLSLEarth (https://github.com/ElementMo/GLSLEarth)
 */
class Earth {
  PShader shader;
  //PShape globe;
  float angle = 0;
  float lightRotation = 0;

  Earth() {
    noStroke();
    shader = loadShader("frag.glsl", "vert.glsl");
    //globe = createShape(SPHERE, 500);
    sphereDetail(100);
  }

  void show() {
    resetShader();
    shader(shader);
    shader.set("u_smoothness", 40.0);
    shader.set("u_specular_strength", 0.0);
    shader.set("u_cloud_brightness", cloudBrightness);
    shader.set("u_fresnel", fresnel);
    shader.set("u_fresnel_strength", fresnelStrength);
    shader.set("u_texture", diffuse);
    shader.set("u_texture_specular", specular);
    shader.set("u_texture_normal", normal);
    shader.set("u_texture_cloud", cloud);

    lights = LM.pg.get();
    lights.resize(textureSize, textureSize);
    shader.set("u_texture_lights", lights);

    pointLight(255, 255, 255,
      10000*cos(lightRotation), -5000, 10000*sin(lightRotation));

    rotateY(angle);
    //globe.setTexture(LM.pg);
    //shape(globe);
    noStroke();
    sphere(500);
    angle += rotateSpeed;
  }
}
