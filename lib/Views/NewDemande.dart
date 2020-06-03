import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';

class NewDemande extends StatefulWidget {
  static const String routeName = '/newdemande';
  //Register({Key key}):super(key:key);
  @override
  _NewDemandeState createState() => _NewDemandeState();
}

class _NewDemandeState extends State<NewDemande> {
  var idController = new TextEditingController();
  var libelleController = new TextEditingController();
  var datedemandeController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var etatController = new TextEditingController();
  var idUtilisateurController = new TextEditingController();
  var textStyle = TextStyle();
  String typeDropDownStr = "Volontaire";
  final connectionissueSanckBar = SnackBar(
    content: Text("404,la connection a echoué"),
  );
  void initState() {
    super.initState();
    idController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme.title;
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
            TextField(
              controller: libelleController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Libelle ...",
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
              controller: datedemandeController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Date ...",
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
              controller: descriptionController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Description ...",
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
              controller: etatController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Etat  ...",
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
                onPressed: () => enregistrerDemande(),
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
                    child: Text('Publier',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ))
          ],
        ));
  }

  void enregistrerDemande() async {
     Demande demande = new Demande(libelleController.text, datedemandeController.text, descriptionController.text, etatController.text, 1);
    var saveResponse = await APIServices.postDemande(demande);
    saveResponse == true
        ? showSucssesToast()
        : Scaffold.of(context).showSnackBar(connectionissueSanckBar);
  }

  void showSucssesToast() {
    Fluttertoast.showToast(
        msg: "Commande Publiée",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
  }

}
