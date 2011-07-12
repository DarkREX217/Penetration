/* PenetrationFileIO
 *
 * Scott Davis
 * 03/20/2011
 *
 *
 *
 *  Notes on usage:
 *
 */

import java.util.ArrayList;
import java.util.StringTokenizer;


class PenetrationFileIO<Template>
{
 
  //global varaibles
  PrintWriter output;
  BufferedReader reader;
  String aLine ;
  
  String filePath;
  String fileName;
  String fileExt;
  
  //make this an arrayList with pairs
  ArrayList<ParsePair> fileData = new ArrayList<ParsePair>();
  int dataSize = 0;
  
  
  
  //Constructor
  PenetrationFileIO()
  {
  }
  
  //methods
    //getters
  String getPath()
  {
    return filePath;
  }
  String getFileName()
  {
    return fileName;
  }
  String getExt()
  {
    return fileExt;
  }
  ArrayList getData()
  {
    return fileData;
  }
  int getDataSize()
  {
    return dataSize;
  }

    //setters
  void setPath(String path)
  {
    filePath = path;
  }
  void setFileName(String name)
  {
    fileName = name;
  }
  void setExt(String ext)
  {
    fileExt = ext;
  }
  
  
  
  void printFile()
  {
    validate();
    while (aLine != null)
    {
      aLine = getLine();
      if(aLine != null )
      {
        println( aLine );
      }
    }
  }//end printFile
  
  void printData()
  {
    for(int i = 0; i < dataSize; i++)
    {
      println("Data[" + i + "] -> " +
      fileData.get(i).getVariable() + ": " +
      fileData.get(i).getValue() );
    }
  }
  
  
  void loadFile()
  {
    validate();
//    checkData();
    loadData( fileData );
  }
  
  void loadFile(String path)
  {
    reader = createReader(path);
    loadData( fileData );
  }
  
  void writeFile(Template genericObject)
  {
    //use the file extension to determine which format to use
    if(fileExt.equals(".lvl") )
    {
      println("Writing a level file.");
      writeLevel(genericObject);
    }
    if(fileExt.equals(".itl") )
    {
      //write and item list for an inventory
      println("Writing an item list.");
      
    }
  }  






// private helper methods

  private String getLine()
  {
    String thisLine = "";
    try
    {
      thisLine = reader.readLine();
      return thisLine;
    }
    catch(IOException e)
    {
      e.printStackTrace();
      thisLine = null;
    }
    catch(Exception e)
    {
      println("Caught exception: " + e + ".");
      thisLine = null;
    }
    return thisLine;
  }
  
  
  
  
  private void loadData(ArrayList fillData)
  {
    int dataIndex = 0;
    dataSize = 0;
    while (aLine != null)
    {
      aLine = getLine();
      ParsePair thisPair = new ParsePair();
      
      if(aLine != null )
      {
//        println("  Analyzing String: " + aLine);
        
        String testString = "";
        int beginValue = 0;
  
        //find the "=" sign
        for(int curChar = 0; curChar < aLine.length(); curChar++)
        {
          char testChar = aLine.charAt(curChar);
//          println("    [" + curChar + "]= " + testChar );
  
          if( curChar == aLine.length() - 1)
          {
            testString += testChar;
            testString = testString.substring(beginValue, testString.length() );
//            println("testString= " + testString + ".  This should be the variable value.");
            thisPair.setValue(testString);
            fillData.add(thisPair);
//            println("   data[" + dataIndex + "]= " + fillData[dataIndex]);
            dataIndex++;
            dataSize++;
            beginValue = 0;
            
          }
          
          if( testChar == '=' )
          {
//            println("Found = sign at: " + curChar + ".  Moving to next characer.");
//            println("testString= " + testString + ".  Tagging it now.");
            thisPair.setVariable(testString);          
            beginValue = curChar ;
          }
          else
          {
            testString += testChar;
          }
        }//end for: reached end of the String
      }//end if: no more Strings to parse
    }//end while: reached EOF
  }

  
  
  
  
  /*
  private void checkData()
  {
    if (fileExt.equals(".lvl") )
    {
      dataSize = 4;  //temp solution
      fileData = new String[dataSize][2];
    }
  }
  */
  
  
  private void writeLevel(Template writeMe)
  {
    output = createWriter(filePath + fileName + fileExt);      
    Level outputLevel = (Level)writeMe;
    output.println("level_name=" + outputLevel.level_name);
    output.println("level_width=" + outputLevel.level_width);  
    output.println("level_height=" + outputLevel.level_height);
    output.println("posX=" + outputLevel.posX);    
    output.println("posY=" + outputLevel.posY);        
    output.println("initialSpawnX=" + outputLevel.initialSpawnX);        
    output.println("initialSpawnY=" + outputLevel.initialSpawnY);
    output.println("backgroundImagePath=" + outputLevel.backgroundImagePath);
//This loop writes in everthing that is in the spacialObjectList that is writable
    for(int i = 0; i < outputLevel.size(); i++ )
    {
      Spacial temp = (Spacial)outputLevel.get(i);  
      StringTokenizer st = new StringTokenizer( temp.getClass().toString(), "$");
      st.nextToken(); //skip the first one, it looks like: "class Spacial$"
      String className = st.nextToken();
      if(className.equals("Obstruction") )
      {
        output.println("Obstruction=" + temp.getX() + "," + temp.getY() +
            temp.getW() + "," + temp.getH() );
      }
      //other classes can go here
      if(className.equals("Blip") )
      {
        output.println("Blip=" + temp.getX() + "," + temp.getY()  );
      }
        
    }
   
    
    output.flush(); 
    output.close();
    
  }
  
  

  private void validate()
  {
//    println("Validating file");
    if (filePath != null)
    {
      reader = createReader(filePath + fileName + fileExt);      
    }
    else
    {
      reader = createReader(fileName + fileExt);
    }
    try
    {
      String thisLine = reader.readLine();
    }
    catch(IOException e)
    {
      println("Investigate this stack trace:");
      e.printStackTrace();
    }
    catch(Exception e)
    {
      println("Caught exception: " + e + ".  There is an error reading your file: " + fileName + fileExt);
    }
    
    if (filePath != null)
    {
      reader = createReader(filePath + fileName + fileExt);      
    }
    else
    {
      reader = createReader(fileName + fileExt);  
    }
    aLine = "";  
  } 
  
  
}//end class
