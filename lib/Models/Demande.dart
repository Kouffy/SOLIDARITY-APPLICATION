class Demande {
  int _id;
  String _libelle;
  String _datedemande;
  String _description;
  String _etat;
  int _idUtilisateur;

  Demande(
      this._libelle,
      this._datedemande,
      this._description,
      this._etat,
      this._idUtilisateur,);

  Demande.WithId(
      this._id,
      this._libelle,
      this._datedemande,
      this._description,
      this._etat,
      this._idUtilisateur);

  int get id => _id;
  String get libelle => _libelle;
  String get datedemande => _datedemande;
  String get description => _description;
  String get etat => _etat;
  int get idUtilisateur => _idUtilisateur;




  set libelle(String newlibelle) {
    _libelle = newlibelle;
  }

  set datedemande(String newdatedemande) {
    _datedemande = newdatedemande;
  }

  set description(String newdescription) {
    _description = newdescription;
  }
   set etat(String newetat) {
    _etat = newetat;
  }

  set idUtilisateur(int newidUtilisateur) {
    _idUtilisateur = newidUtilisateur;
  }

 

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["libelle"] = _libelle;
    map["datedemande"] = _datedemande;
    map["description"] = _description;
    map["etat"] = _etat;
    map["idUtilisateur"] = _idUtilisateur;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Demande.fromObject(dynamic o) {
    this._id = o["id"];
    this.libelle = o["libelle"];
    this.datedemande =o["datedemande"];
    this.description =o["description"];
    this.etat =o["etat"];
    this.idUtilisateur =o["idUtilisateur"];
  }
}
