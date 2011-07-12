/* PenetrationFileIO
 *
 * Scott Davis
 * 03/20/2011
 *
 *  Used for parsing data in PenetrationFileIO
 *
 *  Pair( variableName,  value )
 */
 
class ParsePair
{
  //fields
  String varName;
  String dataValue;
  
  ParsePair()
  {
    varName = "";
    dataValue = "";
  }
  
  ParsePair(String var, String val)
  {
    varName = var;
    dataValue = val;
  }
  
  String getVariable()
  {
    return varName;
  }
  String getValue()
  {
    return dataValue;
  }
    
  void setVariable(String var)
  {
    varName = var;
  }
  void setValue(String val)
  {
    dataValue = val;
  }
  
  String toString()
  {
    return "Pair<" + varName + ", " + dataValue + ">";
  }
}//end class
