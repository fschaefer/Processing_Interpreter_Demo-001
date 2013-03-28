// sketch showing usage of beanshell scripts in Processing.
//
// project includes bsh-2.0b4.jar from http://www.beanshell.org/
// and fast-md5-2.6.jar build from sources found at 
// http://www.twmacinta.com/myjava/fast_md5.php

Interpreter ip   = null;

File setupScript = null;
File drawScript  = null;

String aString   = null;

String oldHash   = "";
String newHash   = "";

Hash md5         = null;

void setup(){
  // create a new hash object
  md5 = new Hash(this);
  
  // for export / import tests
  aString = "from Processing";

  // our beanshell script files
  setupScript = new File(dataPath("setup.bsh"));
  drawScript  = new File(dataPath("draw.bsh"));

  // create a new interpreter object
  ip = new Interpreter(this);
  // export object to beanshell script
  ip.setObject("aString", aString);
  // call our setup script
  ip.call(setupScript);

  // import the string back from beanshell
  println("Processing is printing a String " + ip.getObject("aString"));
}

void draw(){
  // compute md5 hash for the beanshell script
  newHash = md5.compute(drawScript);
  
  // test hash of script file and eval only if file is modified (reduce the disk I/O)
  if (!oldHash.equals(newHash)){
    ip.call(drawScript);
    oldHash = newHash;
  }
}

