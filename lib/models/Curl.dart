class Curl
{ int _id;
  String _cid;
  String _URL;
  String _firstDate;
  String _recentDate;
  String _searches;

  Curl(this._cid, this._URL, this._firstDate, this._recentDate,this._searches);




  int get id => _id;

String get cid => _cid;
String get URL => _URL;

String get firstDate => _firstDate;
String get recentDate => _recentDate;
String get searches => _searches;

void updateSearches(String s)
  {   var x=this.searches.split("||");
     if(x!=null)
       x=x.toSet().toList();



    if(this._searches==null)
      _searches=s;
     else
       if(!x.contains(s))  // chk if already there
    _searches= _searches+"||"+s;

  }




set cid(String d) {

  this._cid = d;
}
set URL(String d) {

  this._URL=d;
}
set searches(String d) {

  this._searches=d;
}


set firstDate(String d) {

  this._firstDate = d;

}

set recentDate(String d) {

  this._recentDate = d;
}



// Convert a Note object into a Map object
Map<String, dynamic> toMap() {

  var map = Map<String, dynamic>();
  if (id != null) {
    map['id'] = _id;
  }
  map['cid'] = _cid;
  map['URL'] = _URL;
  map['firstDate'] = _firstDate;
  map['recentDate'] = _recentDate;
  map['searches'] = _searches;


  return map;
}

// Extract a Note object from a Map object
Curl.fromMapObject(Map<String, dynamic> map) {
  this._id = map['id'];
  this._cid = map['cid'];
  this._URL = map['URL'];
  this._firstDate = map['firstDate'];
  this._recentDate = map['recentDate'];
  this._searches = map['searches'];



}


}