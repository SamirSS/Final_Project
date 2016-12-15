class Snow{
  
  PVector loc;
  PVector acc;
  PVector vel;
  PVector wind;
  PVector grav;
  float mass;
  float snowsize;
 
  Snow(){
    snowsize = 7;
 
    loc = new PVector(random(width), -snowsize);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    wind = new PVector(random(-0.007, 0.007), 0);
 
    mass = 80/snowsize;
    grav = new PVector(0, 0.08);
  }
 
  void display(){
    drawSnow();
    moveSnow();
    applyForce(grav);
    applyForce(wind);
  }
 
  void drawSnow(){
    noStroke();
    fill(250, 190);
    ellipse(loc.x, loc.y, snowsize, snowsize);
  }
 
  void applyForce(PVector force){
    PVector pv = PVector.div(force, mass);
    acc.add(pv);
  }
 
  void moveSnow(){
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }
  
}