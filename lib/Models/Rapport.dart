class Rapport {
  int _id;
  String _libelle;
  String _dateRapport;
  String _contenu;
  int _idUtilisateur;

  Rapport(
      this._libelle,
      this._dateRapport,
      this._contenu,
      this._idUtilisateur,);

  Rapport.WithId(
      this._id,
      this._libelle,
      this._dateRapport,
      this._contenu,
      this._idUtilisateur);

  int get id => _id;
  String get libelle => _libelle;
  String get dateRapport => _dateRapport;
  String get contenu => _contenu;
  int get idUtilisateur => _idUtilisateur;




  set libelle(String newlibelle) {
    _libelle = newlibelle;
  }

  set dateRapport(String newdateRapport) {
    _dateRapport = newdateRapport;
  }

  set contenu(String newcontenu) {
    _contenu = newcontenu;
  }

  set idUtilisateur(int newidUtilisateur) {
    _idUtilisateur = newidUtilisateur;
  }

 

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["libelle"] = _libelle;
    map["dateRapport"] = _dateRapport;
    map["contenu"] = _contenu;
    map["idUtilisateur"] = _idUtilisateur;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Rapport.fromObject(dynamic o) {
    this._id = o["id"];
    this.libelle = o["libelle"];
    this.dateRapport =o["dateRapport"];
    this.contenu =o["description"];
    this.idUtilisateur =o["idUtilisateur"];
  }
}
