class Region {
  int _id;
  String _region;

  Region(
    this._region,
  );

  Region.WithId(this._id,this._region);

  int get id => _id;
  String get region => _region;



  set region(String newregion) {
    _region = newregion;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["region"] = _region;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Region.fromObject(dynamic o) {
    this._id = o["id"];
    this.region = o["region"];
  }
}
