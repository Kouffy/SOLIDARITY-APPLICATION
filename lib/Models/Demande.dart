class Demande {
  int _id;
  String _libelle;
  String _datedemande;
  String _description;
  String _etat;
  int _idUtilisateur;
  String _pdpuser;
  String _nomuser;

  Demande(
    this._libelle,
    this._datedemande,
    this._description,
    this._etat,
    this._idUtilisateur,
    this._pdpuser,
    this._nomuser,
  );

  Demande.WithId(
    this._id,
    this._libelle,
    this._datedemande,
    this._description,
    this._etat,
    this._idUtilisateur,
    this._pdpuser,
    this._nomuser,
  );

  int get id => _id;
  String get libelle => _libelle;
  String get datedemande => _datedemande;
  String get description => _description;
  String get etat => _etat;
  int get idUtilisateur => _idUtilisateur;
  String get pdpuser => _pdpuser;
  String get nomuser => _nomuser;

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

  set pdpuser(String newpdpuser) {
    _pdpuser = newpdpuser;
  }

  set nomuser(String newnomuser) {
    _nomuser = newnomuser;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["libelle"] = _libelle;
    map["datedemande"] = _datedemande;
    map["description"] = _description;
    map["etat"] = _etat;
    map["idUtilisateur"] = _idUtilisateur;
    map["pdpuser"] = _pdpuser;
    map["nomuser"] = _nomuser;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Demande.fromObject(dynamic o) {
    this._id = o["id"];
    this.libelle = o["libelle"];
    this.datedemande = o["datedemande"];
    this.description = o["description"];
    this.etat = o["etat"];
    this.idUtilisateur = o["idUtilisateur"];
    this.pdpuser = o["pdpuser"];
    this.nomuser = o["nomuser"];
  }
}
