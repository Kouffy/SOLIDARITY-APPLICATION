import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as Img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solidarite/Models/Region.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/Ville.dart';
import 'package:solidarite/Models/api.services.dart';
import 'dart:math' as Math;
import 'package:path_provider/path_provider.dart';
import 'package:solidarite/Toasts.dart';

class Register extends StatefulWidget {
  static const String routeName = '/register';
  final String type;
  Register(this.type);
  //Register({Key key}):super(key:key);
  @override
  _RegisterState createState() => _RegisterState(type);
}

class _RegisterState extends State<Register> {
  String type;
  _RegisterState(this.type);
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

  var nomController = new TextEditingController();
  var prenomController = new TextEditingController();
  var ageController = new TextEditingController();
  var sexeController = new TextEditingController();
  var adresseController = new TextEditingController();
  var pdpController = new TextEditingController();
  var emailController = new TextEditingController();
  var telController = new TextEditingController();
  var loginController = new TextEditingController();
  var passwordController = new TextEditingController();
  var textStyle = TextStyle();
  File _imagePdp;
  String typeDropDownStr = "Volontaire";

  @override
  Widget build(BuildContext context) {
          getRegions();
      getVilles();
 
      villes==null? null :_dropDownMenuItemsVille = getDropDownMenuItemsVille();
      regions==null? null :_dropDownMenuItemsRegion = getDropDownMenuItemsRegion();
setDrops();
   
    return Scaffold(
      appBar: _builAppBar(),
      body: _buildForm(),
    );
  }


  Widget _builAppBar() {
    return AppBar(title: Text('S\'inscrire'));
  }

  Widget _buildForm() {
    return Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Selectionner une image de profile :'),
                SizedBox(
                  height: 10.0,
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 120.0,
                      width: 120.0,
                      child: Center(
                        child: _imagePdp == null
                            ? new Image.asset('assets/images/user.png')
                            :  Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(_imagePdp)  ,
                                    
                                    ))),
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: getImageGallery,
                        child: Container(
                          width: 100.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          padding: EdgeInsets.all(10.0),
                          child: Center(child: Icon(Icons.image)),
                        )),
                    SizedBox(
                      width: 10.0,
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: getImageGallery,
                        child: Container(
                          width: 100.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          padding: EdgeInsets.all(10.0),
                          child: Center(child: Icon(Icons.camera)),
                        )),
                  ],
                ),
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
                          controller: sexeController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Sexe",
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
                      Container(
                          color: Colors.white,
                          child: new Center(
                              child: new DropdownButton(
                                hint: Text("Choisir une Region: "),
                            value: _currentRegion,
                            items: _dropDownMenuItemsRegion,
                            onChanged: changedDropDownItemRegion,
                          ))),
                      Container(
                          color: Colors.white,
                          child: new Center(
                              child: new DropdownButton(
                                hint: Text("Choisir une Ville: "),
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
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                onPressed: () => enregistrerUtilisateur(),
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
                    child: Text('S\'inscrire',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                )),
            SizedBox(
              height: 20.0,
            )
          ],
        ));
  }

  void enregistrerUtilisateur() async {
    Utilisateur utilisateur = new Utilisateur(
        nomController.text,
        prenomController.text,
        int.parse(ageController.text),
        sexeController.text,
        adresseController.text,
        _currentRegion,
       _currentCity,
        pdpController.text,
        emailController.text,
        telController.text,
        loginController.text,
        passwordController.text,
        type);
    utilisateur.pdp = _imagePdp.path.split("/").last;
    var saveResponse = await APIServices.postUtilisateur(utilisateur);
    var saveImageResponse = await APIServices.postUtilisateurPhoto(_imagePdp);
   if( saveResponse && saveImageResponse){
   Toasts.showSucssesToast("Inscrit avec succès");
         Navigator.pop(context, true);
  }
  else{
Toasts.showFailedToast("verifier vos informations");
  }
         
  }

  Future getImageGallery() async {
    try {
      var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      int rand = new Math.Random().nextInt(100000);
      Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(image, width: 500);
      var compressImg = new File("$path/image_$rand.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
      setState(() {
        _imagePdp = compressImg;
      });
    } catch (e) {
      print("gallery/Imagepdp : " + e.toString());
    }
  }

  Future getImageCamera() async {
    try {
      var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      int rand = new Math.Random().nextInt(100000);
      Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(image, width: 500);
      var compressImg = new File("$path/image_$rand.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
      setState(() {
        _imagePdp = compressImg;
      });
    } catch (e) {
      print("camera/Imagepdp : " + e.toString());
    }
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
