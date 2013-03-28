// class to compute a md5 hash using fast-md5 by Timothy W Macinta et al.
// can be found at http://www.twmacinta.com/myjava/fast_md5.php

import com.twmacinta.*;

class Hash {
  private PApplet parent = null;
 
  Hash(PApplet parent){
    this.parent = parent;
  }
 
  public String compute(File file){
    String hash = "";
    try {
      hash = MD5.asHex(MD5.getHash(drawScript));
    } 
    catch (Exception e){
      parent.println(e);    
    }  
    return hash;
  }
}
