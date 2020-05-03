class Utilisateur {
  int _id;
  String _nom;
  String _prenom;
  int _age;
  String _adresse;
  String _region;
  String _ville;
  String _pdp;
  String _email;
  String _tel;
  String _login;
  String _password;
  String _type;
  Utilisateur(
      this._nom,
      this._prenom,
      this._age,
      this._adresse,
      this._region,
      this._ville,
      this._pdp,
      this._email,
      this._tel,
      this._login,
      this._password,
      this._type);

  Utilisateur.WithId(
      this._id,
      this._nom,
      this._prenom,
      this._age,
      this._adresse,
      this._region,
      this._ville,
      this._pdp,
      this._email,
      this._tel,
      this._login,
      this._password,
      this._type);

  int get id => _id;
  String get nom => _nom;
  String get prenom => _prenom;
  int get age => _age;
  String get adreesee => _adresse;
  String get region => _region;
  String get ville => _ville;
  String get pdp => _pdp;
  String get email => _email;
  String get tel => _tel;
  String get login => _login;
  String get password => _password;
  String get type => _type;

  set nom(String newnom) {
    _nom = newnom;
  }

  set prenom(String newprenom) {
    _prenom = newprenom;
  }

  set age(int newage) {
    _age = newage;
  }

  set adresse(String newadresse) {
    _adresse = newadresse;
  }

  set region(String newregion) {
    _region = newregion;
  }

  set ville(String newville) {
    _ville = newville;
  }

  set pdp(String newpdp) {
    _pdp = newpdp;
  }

  set email(String newemail) {
    _email = newemail;
  }

  set tel(String newtel) {
    _tel = newtel;
  }

  set login(String newlogin) {
    _login = newlogin;
  }

  set password(String newpassword) {
    _password = newpassword;
  }

  set type(String newtype) {
    _type = newtype;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["nom"] = _nom;
    map["prenom"] = _prenom;
    map["age"] = _age;
    map["adresse"] = _adresse;
    map["region"] = _region;
    map["ville"] = _ville;
    map["pdp"] = _pdp;
    map["email"] = _email;
    map["tel"] = _tel;
    map["login"] = _login;
    map["password"] = _password;
    map["type"] = _type;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Utilisateur.fromObject(dynamic o) {
    this._id = o["id"];
    this.nom = o["nom"];
    this.prenom =o["prenom"];
    this.age =o["age"];
    this.adresse =o["adresse"];
    this.region =o["region"];
    this.ville =o["ville"];
    this.pdp =o["pdp"];
    this.email =o["email"];
    this.tel =o["tel"];
    this.login =o["login"];
    this.password =o["password"];
    this.type =o["type"];

  }
}
