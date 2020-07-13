class Commentaire {
  int _id;
  String _contenu;
  String _dateCommentaire;
  int _idUtilisateur;
  int _idDemande;
  String _pdpuser;
  String _nomuser;

  Commentaire(
    this._contenu,
    this._dateCommentaire,
    this._idUtilisateur,
    this._idDemande,
    this._pdpuser,
    this._nomuser,
  );

  Commentaire.withId(
    this._id,
    this._contenu,
    this._dateCommentaire,
    this._idUtilisateur,
    this._idDemande,
    this._pdpuser,
    this._nomuser,
  );

  int get id => _id;
  String get contenu => _contenu;
  String get dateCommentaire => _dateCommentaire;
  int get idDemande => _idDemande;
  int get idUtilisateur => _idUtilisateur;
  String get pdpuser => _pdpuser;
  String get nomuser => _nomuser;

  set contenu(String newcontenu) {
    _contenu = newcontenu;
  }

  set dateCommentaire(String newdatecommentaire) {
    _dateCommentaire = newdatecommentaire;
  }

  set idDemande(int newidDemande) {
    _idDemande = newidDemande;
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
    map["contenu"] = _contenu;
    map["dateCommentaire"] = _dateCommentaire;
    map["idUtilisateur"] = _idUtilisateur;
    map["idDemande"] = _idDemande;
    map["pdpuser"] = _pdpuser;
    map["nomuser"] = _nomuser;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Commentaire.fromObject(dynamic o) {
    this._id = o["id"];
    this.contenu = o["contenu"];
    this.dateCommentaire = o["dateCommentaire"];
    this.idUtilisateur = o["idUtilisateur"];
    this.idDemande = o["idDemande"];
    this.pdpuser = o["pdpuser"];
    this.nomuser = o["nomuser"];
  }
}
