// wrapper class for using the BeanShell Interpreter (www.beanshell.org) in Processing.
// it just keeps the user away from setting up the interpreter context
// and all that try / catch stuff.
class Interpreter{
  PApplet parent     = null; // field storing the reference to the Proccesing PApplet
  bsh.Interpreter ip = null; // field for our beanshell interpreter

  // constructor
  Interpreter(PApplet parent){
    // store reference to parent PApplet
    this.parent = parent; 
    try{
      // create a new beanshell interpreter object
      ip = new bsh.Interpreter(); 
      // let the interpreter import the processing core libs
      ip.eval("import processing.core.*;"); 
      // export parents PApplet as p to the interpreter
      ip.set("p", parent); 
      // and import p into the current context
      ip.eval("importObject(p);"); 
    }
    catch(bsh.EvalError e){
      // if BeanShell is tired today, it will tell us here
      println(e);
    }
  }

  // evaluate a File 
  public void call(File file){ // maybe overkill to use the file object... but keeps the api simple
    try{
      // load File into interpreter and eval it
      ip.source(file.getPath());
    } 
    catch(bsh.EvalError e){
      // next just let the interpreter complain about all the typos we made...
      println(e);
    } 
    catch(FileNotFoundException e){ 
      // ...about a wrong path...
      println(e);
    }
    catch(IOException e){
      // ...or about some lower level related errors
      println(e);
    }
  }

  // evaluate a String
  public void call(String code){
    try{
      // load a String to the interpreter and eval it
      ip.eval(code);
    } 
    catch(bsh.EvalError e){
      // let the interpreter complain about all the typos we made...
      println(e);
    } 
  }

  // import object or value from interpreter to processing
  // primitive types (e.g int, char, boolean) are returned wrapped 
  // in their primitive wrappers (e.g. Integer, Character, Boolean). 
  public Object getObject(String name){
    Object obj = null;
    try{
      obj = ip.get(name);
    } 
    catch(bsh.EvalError e){
      // interpreter complains
      println(e);
    }
    finally{
      return obj;
    }
  }

  // export an object or value to the interpreter
  // primitive types (e.g int, char, boolean) must be wrapped 
  // in their primitive wrappers (e.g. Integer, Character, Boolean). 
  public void setObject(String name, String obj){
    try{
      ip.set(name, obj);
    } 
    catch(bsh.EvalError e){
      // interpreter complains
      println(e);
    }
  }
}
