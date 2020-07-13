class Ville {
  int _id;
  String _ville;
  int _idRegion;

  Ville(
    this._ville,
    this._idRegion,
  );

  Ville.WithId(this._id, this._ville, this._idRegion);

  int get id => _id;
  String get ville => _ville;
  int get region => _idRegion;

  set ville(String newville) {
    _ville = newville;
  }

  set idRegion(int newregion) {
    _idRegion = newregion;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["ville"] = _ville;
    map["region"] = _idRegion;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Ville.fromObject(dynamic o) {
    this._id = o["id"];
    this.ville = o["ville"];
    this.idRegion = o["region"];
  }
}
