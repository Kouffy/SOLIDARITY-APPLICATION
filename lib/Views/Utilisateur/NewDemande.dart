import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';

class NewDemande extends StatefulWidget {
  static const String routeName = '/newdemande';
  @override
  _NewDemandeState createState() => _NewDemandeState();
}

class _NewDemandeState extends State<NewDemande> {
  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idController.text = prefs.getInt('id').toString();
      print('logged user :' + idController.text);
    });
  }
  var idController = new TextEditingController();
  var libelleController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var idUtilisateurController = new TextEditingController();
  var textStyle = TextStyle();
  String typeDropDownStr = "Volontaire";
  final connectionissueSanckBar = SnackBar(
    content: Text("404,la connection a echoué"),
  );
  void initState() {
    super.initState();
    getPreferences();
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
    return AppBar(title: Text('Nouvelle Demande'));
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
     Demande demande = new Demande(libelleController.text,DateTime.now().toString(), descriptionController.text,'d',int.parse(idController.text));
    var saveResponse = await APIServices.postDemande(demande);
    saveResponse == true
        ? showSucssesToast()
        : Scaffold.of(context).showSnackBar(connectionissueSanckBar);
        Navigator.pop(context);
  }
  void showSucssesToast() {
    Fluttertoast.showToast(
        msg: "Post Publiée",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
  }

}
