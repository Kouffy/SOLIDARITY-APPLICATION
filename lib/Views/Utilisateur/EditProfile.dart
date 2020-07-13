import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solidarite/Models/Region.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/Ville.dart';
import 'package:solidarite/Models/api.services.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/editprofile';
  final Utilisateur utilisateur;
  EditProfile(this.utilisateur);
  @override
  _EditProfileState createState() => _EditProfileState(utilisateur);
}

class _EditProfileState extends State<EditProfile> {
  List<Ville> villes;
  List<Region> regions;
  List<DropdownMenuItem<String>> _dropDownMenuItemsVille;
  List<DropdownMenuItem<String>> _dropDownMenuItemsRegion;
  String _currentCity;
  String _currentRegion;
    bool zeb = false;
  setDrops()
  {
    if(!zeb){
            villes==null? null :_currentCity = _dropDownMenuItemsVille[0].value;
     regions==null? null : _currentRegion = _dropDownMenuItemsRegion[0].value;
     zeb = true;
    }

  }
  getVilles() {
    APIServices.fetchVille().then((response) {
      Iterable list = json.decode(response.body);
      List<Ville> villeList = List<Ville>();
      villeList = list.map((model) => Ville.fromObject(model)).toList();
      setState(() {
        villes = villeList;
      });
    });
  }

  getRegions() {
    APIServices.fetchRegion().then((response) {
      Iterable list = json.decode(response.body);
      List<Region> regionList = List<Region>();
      regionList = list.map((model) => Region.fromObject(model)).toList();
      setState(() {
        regions = regionList;
      });
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsVille() {
    List<DropdownMenuItem<String>> items = new List();
    for (Ville city in villes) {
      items.add(
          new DropdownMenuItem(value: city.ville, child: new Text(city.ville)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsRegion() {
    List<DropdownMenuItem<String>> items = new List();
    for (Region city in regions) {
      items.add(new DropdownMenuItem(
          value: city.region, child: new Text(city.region)));
    }
    return items;
  }

  Utilisateur utilisateur;
  _EditProfileState(this.utilisateur);
  var nomController = new TextEditingController();
  var prenomController = new TextEditingController();
  var ageController = new TextEditingController();
  var adresseController = new TextEditingController();
  var regionController = new TextEditingController();
  var villeController = new TextEditingController();
  var pdpController = new TextEditingController();
  var emailController = new TextEditingController();
  var telController = new TextEditingController();
  var loginController = new TextEditingController();
  var passwordController = new TextEditingController();
  var typeController = new TextEditingController();
  var textStyle = TextStyle();
  final connectionissueSanckBar = SnackBar(
    content: Text("404,la connection a echoué"),
  );
  @override
  Widget build(BuildContext context) {
    getRegions();
    getVilles();
    nomController.text = utilisateur.nom;
    prenomController.text = utilisateur.prenom;
    ageController.text = utilisateur.age.toString();
    adresseController.text = utilisateur.adreesee;
    pdpController.text = utilisateur.pdp;
    emailController.text = utilisateur.email;
    telController.text = utilisateur.tel;
    loginController.text = utilisateur.login;
    passwordController.text = utilisateur.password;
    typeController.text = utilisateur.type;
    textStyle = Theme.of(context).textTheme.title;

    villes == null
        ? null
        : _dropDownMenuItemsVille = getDropDownMenuItemsVille();
    regions == null
        ? null
        : _dropDownMenuItemsRegion = getDropDownMenuItemsRegion();
setDrops();
   

    return Scaffold(
      appBar: _builAppBar(),
      body: _buildForm(),
    );
  }

  Widget _builAppBar() {
    return AppBar(title: Text('Modifier mon Profile'));
  }

  Widget _buildForm() {
    return Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 120.0,
                    width: 120.0,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: utilisateur.pdp == null
                          ? new AssetImage('assets/images/user.png')
                          : new NetworkImage(APIServices.urlBase +
                              APIServices.urlUtilisateur +
                              APIServices.urlGetImageUtilisateur +
                              utilisateur.pdp),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)),
                        ]),
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: nomController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nom",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: prenomController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Prenom",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: ageController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Age",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: adresseController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Adresse",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Text("Choisir une Region: "),
                      Container(
                          color: Colors.white,
                          child: new Center(
                              child: new DropdownButton(
                            value: _currentRegion,
                            items: _dropDownMenuItemsRegion,
                            onChanged: changedDropDownItemRegion,
                          ))),
                      new Text("Choisir une Ville: "),
                      Container(
                          color: Colors.white,
                          child: new Center(
                              child: new DropdownButton(
                            value: _currentCity,
                            items: _dropDownMenuItemsVille,
                            onChanged: changedDropDownItemVille,
                          ))),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: telController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Tel",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: loginController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Login",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ]),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                onPressed: () => modifierUtilisateur(),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ])),
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text('Modifier',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                )),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  void modifierUtilisateur() async {
    var saveResponse = await APIServices.putUtilisateur(utilisateur);
    saveResponse == true
        ? Navigator.pop(context, true)
        : Scaffold.of(context).showSnackBar(connectionissueSanckBar);
  }

  void changedDropDownItemVille(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

  void changedDropDownItemRegion(String selectedRegion) {
    setState(() {
      _currentRegion = selectedRegion;
    });
  }
}
