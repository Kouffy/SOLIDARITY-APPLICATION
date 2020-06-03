class Commentaire {
  int _id;
  String _contenu;
  String _datecommentaire;
  int _idDemande;
  int _idUtilisateur;

  Commentaire(
      this._contenu,
      this._datecommentaire,
      this._idDemande,
      this._idUtilisateur,);

  Commentaire.withId(
      this._id,
      this._contenu,
      this._datecommentaire,
      this._idDemande,
      this._idUtilisateur);

  int get id => _id;
  String get contenu => _contenu;
  String get datecommentaire => _datecommentaire;
  int get idDemande => _idDemande;
  int get idUtilisateur => _idUtilisateur;




  set contenu(String newcontenu) {
    _contenu = newcontenu;
  }

  set datecommentaire(String newdatecommentaire) {
    _datecommentaire = newdatecommentaire;
  }

  set idDemande(int newidDemande) {
    _idDemande = newidDemande;
  }
   set idUtilisateur(int newidUtilisateur) {
    _idUtilisateur = newidUtilisateur;
  }


 

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["contenu"] = _contenu;
    map["datecommentaire"] = _datecommentaire;
    map["idDemande"] = _idDemande;
    map["idUtilisateur"] = _idUtilisateur;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Commentaire.fromObject(dynamic o) {
    this._id = o["id"];
    this.contenu = o["contenu"];
    this.datecommentaire =o["datecommentaire"];
    this.idDemande =o["idDemande"];
    this.idUtilisateur =o["idUtilisateur"];
  }
}
