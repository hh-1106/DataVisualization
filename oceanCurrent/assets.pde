PImage diffuse, specular, normal, cloud;
int textureSize = 1200;
int loadState = 0;

void loadTexture() {
  thread("loadDiffuse");
  thread("loadSpecular");
  thread("loadNormal");
  thread("loadCloud");
}
void loadDiffuse() {
  diffuse = loadImage("6k_earth_daymap.jpg");
  diffuse.resize(textureSize, textureSize);
  loadState ++;
}
void loadSpecular() {
  specular = loadImage("6k_earth_specular_map.jpg");
  specular.resize(textureSize, textureSize);
  loadState ++;
}
void loadNormal() {
  normal = loadImage("6k_earth_normal_map.jpg");
  normal.resize(textureSize, textureSize);
  loadState ++;
}
void loadCloud() {
  cloud = loadImage("6k_earth_clouds.jpg");
  cloud.resize(textureSize, textureSize);
  loadState ++;
}
