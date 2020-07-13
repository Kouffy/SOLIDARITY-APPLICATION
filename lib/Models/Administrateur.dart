class Administrateur {
  int _id;
  String _nom;
  String _prenom;
 String _login;
 String _password;

  Administrateur(
    this._nom,
  this._prenom,
 this._login,
this._password,
  );

  Administrateur.WithId(this._nom, this._prenom, this._login,this._password);

  int get id => _id;
   String get nom => _nom;
    String get prenom => _prenom;
     String get login => _login;
       String get password => _password;

  set nom(String newnom) {
    _nom = newnom;
  }

  set prenom(String newprenom) {
    _prenom = newprenom;
  }
  set login(String newlogin) {
    _login = newlogin;
  }
    set password(String newpassword) {
    _password = newpassword;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["nom"] = _nom;
    map["prenom"] = _prenom;
        map["login"] = _login;
    map["password"] = _password;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Administrateur.fromObject(dynamic o) {
    this._id = o["id"];
    this.nom = o["nom"];
    this.prenom = o["prenom"];
    this.login=o["login"];
    this.password=o["password"];
  }
}
