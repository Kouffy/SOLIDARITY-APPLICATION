class Demande {
  int _id;
  String _libelle;
  String _datedemande;
  String _description;
  String _etat;
  String _priorite;
  int _idutilisateur;

  Demande(
      this._libelle,
      this._datedemande,
      this._description,
      this._etat,
      this._priorite,
      this._idutilisateur,);

  Demande.WithId(
      this._id,
      this._libelle,
      this._datedemande,
      this._description,
      this._etat,
      this._priorite,
      this._idutilisateur);

  int get id => _id;
  String get libelle => _libelle;
  String get datedemande => _datedemande;
  String get description => _description;
  String get etat => _etat;
  String get priorite => _priorite;
  int get idutilisateur => _idutilisateur;




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

  set priorite(String newpriorite) {
    _priorite = newpriorite;
  }

  set idutilisateur(int newidutilisateur) {
    _idutilisateur = newidutilisateur;
  }

 

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["libelle"] = _libelle;
    map["datedemande"] = _datedemande;
    map["description"] = _description;
    map["etat"] = _etat;
    map["priorite"] = _priorite;
    map["idutilisateur"] = _idutilisateur;
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
    this.priorite =o["priorite"];
    this.idutilisateur =o["idutilisateur"];
  }
}
