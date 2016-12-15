// libraries
import com.temboo.core.*;
import com.temboo.Library.Yahoo.Weather.*;
import controlP5.*;

ArrayList<Snow> snow; 

// rando weather globals
int temp;
int text;
int bgcolor;
String cityname;
XML weatherResults;

ControlP5 cp5;

// fonts
PFont fonttemp;
PFont fontloc;

TembooSession weathersesh = new TembooSession("samirss", "WeatherApp", "YHcwDA1gE6qlHqKnZfN4Dq7DOKeV5tVZ");

void setup(){
  size(500, 500);
  background(0);
  
  cp5 = new ControlP5(this);
  cp5.addTextfield("Enter a city").setPosition(35, 100).setSize(200, 40).setAutoClear(false);
  cp5.addBang("Submit").setPosition(255, 100).setSize(80, 40); 
  
  snow = new ArrayList<Snow>();  
  for (int i = 0; i < 1; i++){
    snow.add(new Snow());
  }
  
}

void draw(){
  // 'Submit' is the new 'draw'
  letItSnow();
}

void Submit(){
  cityname = cp5.get(Textfield.class, "Enter a city").getText();
  print("city = " + cityname);
  println();
  
  // font setup
  fonttemp = createFont("Arial", 100);
  fontloc = createFont("ZXX-Sans", 40);
  fill(255);
  
  // location display using created function
  runGetWeatherByAddressChoreo(); 
  getTemperatureFromXML();
  //getPrecipitationFromXML();
  displayColor();
  displayText();
}

void letItSnow(){
  background(bgcolor);
  
  if((frameCount % 10) == 0){
      snow.add(new Snow());
  }   
  for(Snow s: snow){
    s.display();
  }
}

void runGetWeatherByAddressChoreo(){
  // create object using the session
  GetWeatherByAddress getWeatherByAddressChoreo = new GetWeatherByAddress(weathersesh);

  // set address inputs
  getWeatherByAddressChoreo.setAddress(cityname);

  // run and store
  GetWeatherByAddressResultSet getWeatherByAddressResults = getWeatherByAddressChoreo.run();

  // store in xml
  weatherResults = parseXML(getWeatherByAddressResults.getResponse());
}

void getTemperatureFromXML(){
  // get weather condition
  XML condition = weatherResults.getChild("channel/item/yweather:condition");

  // get current temp
  temp = condition.getInt("temp");

  // print temp
  println("The current temperature in "+cityname+" is "+temp+"ºF");
}

void getPrecipitationFromXML(){
  // get weather condition
  XML precip = weatherResults.getChild("channel/item/yweather:condition");

  // get current precipitation
  text = precip.getInt("text");

  // print condition(code & text)
  println("The current condition type in "+cityname+" is "+text);
}

void displayColor(){  
  // temp range
  int minTemp = 0;
  int maxTemp = 99;

  // temp -> rgb color value
  float tempColor = map(temp, minTemp, maxTemp, 0, 255);    

  // backround on a blue(cold) to red(hot) scale
  bgcolor = color(tempColor, 0, 255-tempColor);
  background(bgcolor);
}

void displayText(){
  int spacing = 35;
  
  // displays for the fonts
    // temp display
    textFont(fonttemp);
    text(temp+"ºF", spacing, 375);
    // loc display
    textFont(fontloc);
    text("in "+cityname, spacing, 400, width-spacing, height-spacing);
}