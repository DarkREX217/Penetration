/*Weapon
 *
 *  created by: Scott Davis
 *  on: 03/04/2011
 *
 *  The Weapon class is an extension of Item that
 *defines all the attributes that a weapon should
 *have.  This is a class that gets extended to create
 *different types of weapons, but it shouldn't be 
 *instanciated as a weapon to be used.
 *
 *  Other than the getters and setters defined by its
 *fields, some interesting methods are:
 *  Fire,  Reload, (Alt-Fire)
 *
 *  Some weapons that may be defined:
 *  Pistol, SMG, Assault Rifle, Shotgun, Sniper Rifle, 
 *Rocket Launcher, Gernade, Claymore, etc.
 *
 *
 *
 * Issue:  How to handle Ammo types
 *   Do all guns take all kinds of ammo?
 *     -NO!!
 *   Then how do we ensure that the correct
 * ammo goes to the correct gun?
 */


class Weapon extends Item
{
  //fields
    //counters
  int currentAmmo;
  int maxAmmo;
  int clip;
  int maxClip;
  
  //this is still being looked at
  String ammoType;
  
    //firing controls
  int rateOfFire;  //how many frames it makes the gun wait before firing again 
  int reloadRate; //how many frames it makes the gun wait before firing after reloading
  
  int waitTime = 0;
  int exitPointX;
  int exitPointY;
  

  
  //Constructors
  Weapon()
  {
    currentAmmo = 0;
    maxAmmo = 0;
    clip = 0;
    maxClip = 0;
  
    ammoType = "Default";
  
    rateOfFire = 0;
    reloadRate = 0;
    exitPointX = 0;
    exitPointY = 0;

  }


  Weapon(int initAmmo, int maxA, int cl, int maxC, String ammoT, int rof, int rr, int epX, int epY)
  {
    currentAmmo = initAmmo;
    maxAmmo = maxA;
    clip = cl;
    maxClip = maxC;
    ammoType = ammoT;
    rateOfFire = rof;
    reloadRate = rr;
    exitPointX = epX;
    exitPointY = epY;

  }


  //getters and setters
  //getters
  int getAmmo()
  {
    return currentAmmo;
  }

  int getMaxAmmo()
  {
    return maxAmmo;
  }

  int getClip()
  {
    return clip;
  }

  int getMaxClip()
  {
    return maxClip;
  }
  
  String getAmmoType()
  {
    return ammoType;
  }

  int getRateOfFire()
  {
    return rateOfFire;
  }

  int getReloadRate()
  {
    return reloadRate;
  }
  
  int getWaitTime()
  {
    return waitTime;
  }
  
  //setters
  void setAmmo(int newAmmo)
  {
    currentAmmo = newAmmo;
  }

  void setMaxAmmo(int newMax)
  {
    maxAmmo = newMax;
  }

  void setClip(int newClip)
  {
    clip = newClip;
  }

  void setMaxClip(int newMax)
  {
    maxClip = newMax;
  }
  
  void setAmmoType(String ammoT)
  {
    ammoType = ammoT;
  }

  void setRateOfFire(int newROF)
  {
    rateOfFire = newROF;
  }

  void setReloadRate(int newReload)
  {
    reloadRate = newReload;
  }
  
  void setWaitTime(int frameAmount)
  {
    waitTime = frameAmount;
  }
  
  
  
  //action methods
  void fire()
  {
    //try to fire a single unit of ammo
      //can't fire if gun is empty
    if(currentAmmo <= 0)  
    {
      //here is a good place to play a clicking sound
      return;
    }
    
      //can't fire if the clip is out: auto-reload
    if(clip <= 0)
    {
      reload(maxClip);
      //anything else?
    }
      
      //can't fire if the gun is still waiting
    if(waitTime > 0)  
    {
      //don't do anything  else
        //no reason to play a sound
    }
    else
    {  //able to fire weapon
      //create a new instance of that weapon's ammo
//      Ammo bullet = new Ammo(exitPointX, exitPointY,..., ammoType)
      //the above constructor needs to set the bullet to Active
      //decrease the amount of ammo in the gun
//      currentAmmo -= bullet.ammoUsed();
      //decrease the amount in the clip
      
    }
      
  }  //end method fire()
  
  void reload(int amount)
  {
    // make sure the total amount is decreased
    currentAmmo -= amount;    
    clip = amount;

  }
  
}//end class Weapon
