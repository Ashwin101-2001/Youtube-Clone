import 'package:shared_preferences/shared_preferences.dart';
import 'package:ytube_search/models/Curl.dart';
import 'package:ytube_search/services/Databasehelper.dart';




String getquerywithoutspace(String q)  //*1
{
  int l = q.length;
// print('l:$l');
  int count = 0;
  for (int i = (l - 1); i >= 0; i--) {
    if (q[i] != "")
      break;
    else {
      count += 1;
    }
  }

  count = l - count;
  String s = q.substring(0, count);
  return s;
}

Curl curlGivenCid(List<Curl> x, String chk) {
  //**2
  for (Curl c in x) {
    if (c.cid == chk) return c;
  }
}

String removeAndFromTitles(String s) //**3
{
  String k = s.replaceAll("&amp;", "&");
  k = k.replaceAll("&#39;", "\'");
  return k;
}









Future<bool> stringchecker (String s) async
{ SharedPreferences myPrefs = await SharedPreferences.getInstance();


} //


String getidqstring  (String k,String id)
{
  return k+id;

}  //

String getidfromstring (String k)
{ return k.substring(k.length-24);


}//

bool keyirukka (SharedPreferences my,String c)
{ for(String key in my.getKeys())
{    if(key.length>24)
  {  //print("KEY :$key");
    key=getidfromstring(key);
  if(key==c)
  {  //print("KEY :$key");
    return true;}


  }}

return false;

}//


void delete(SharedPreferences my,String q)
{    // print('delete');
  for(String k in my.getKeys())
  {  if(k.length==(24+q.length))
    {// print("k:$k");
      String s=getqueryfromkey(k);
      //print('q:$q get:$s');
      if(q==s)
    { //print("found $k");
      my.remove(k);

    }}

   }
} //

String getqueryfromkey(String k)
{  return k.substring(0,k.length-24);

}  //



   String getUrlofch(SharedPreferences my,String cid,String q)
      {  int l=q.length+24;
        for(String k in my.getKeys())
          { if(k.length==l)
            { if(k.substring(k.length-24)==cid)
              { return my.getString(k);


              }
            }



          }




      }//











