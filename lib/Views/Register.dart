import 'dart:io';
import 'package:image/image.dart' as Img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';
import 'dart:math' as Math;
import 'package:path_provider/path_provider.dart';
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

  var nomController = new TextEditingController();
  var prenomController = new TextEditingController();
  var ageController = new TextEditingController();
  var sexeController = new TextEditingController();
  var adresseController = new TextEditingController();
  var regionController = new TextEditingController();
  var villeController = new TextEditingController();
  var pdpController = new TextEditingController();
  var emailController = new TextEditingController();
  var telController = new TextEditingController();
  var loginController = new TextEditingController();
  var passwordController = new TextEditingController();
  var textStyle = TextStyle();
File _imagePdp;
  String typeDropDownStr = "Volontaire";
  final connectionissueSanckBar = SnackBar(content: Text("404 , la connection a echoué"),);
  @override
  Widget build(BuildContext context) {
    print(type);
    textStyle = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: _builAppBar(),
      body: _buildForm(),
    );
  }

  Widget _builAppBar() {
    return AppBar(title: Text('S\'enregistrer'));
  }

  Widget _buildForm() {
    return Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
        

                     new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 120.0,
                                width: 120.0,
                                child: Center(
                                  child: _imagePdp == null
                                      ? new Text('Pas d\'image selectionne ')
                                      : new Image.file(_imagePdp),
                                ),
                              ),
                            ],
                          ),
                        
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            RaisedButton(
                              child: Icon(Icons.image),
                              onPressed: getImageGallery,
                            ),
                            RaisedButton(
                              child: Icon(Icons.camera),
                              onPressed: getImageCamera,
                            ),
                          ],
                        ),
            TextField(
              controller: nomController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Nom ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: prenomController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Prenom ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: ageController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Age ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
             SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: sexeController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Sexe ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: adresseController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Adresse ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: regionController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Region ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: villeController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Ville ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: emailController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Email ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: telController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Tel ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
             TextField(
              controller: loginController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Login ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: passwordController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Password ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
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
                      onPressed: () =>  enregistrerUtilisateur(),
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
                          child: Text('S\'enregistrer',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ),
                      ))
          ],
        ));
  }
  void enregistrerUtilisateur() async {
    Utilisateur utilisateur = new Utilisateur(nomController.text, prenomController.text, int.parse(ageController.text),sexeController.text,adresseController.text,regionController.text,villeController.text,pdpController.text,emailController.text,telController.text,loginController.text,passwordController.text,type);
    utilisateur.pdp = _imagePdp.path.split("/").last;
    var saveResponse = await APIServices.postUtilisateur(utilisateur);
    var saveImageResponse = await APIServices.postUtilisateurPhoto(_imagePdp);
    saveResponse && saveImageResponse ? Navigator.pop(context,true) : Scaffold.of(context).showSnackBar(connectionissueSanckBar);
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


}
