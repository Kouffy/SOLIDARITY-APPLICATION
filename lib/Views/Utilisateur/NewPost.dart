import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';

class NewPost extends StatefulWidget {
  static const String routeName = '/NewPost';
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
         int id = 0;
  String ville,pdpuser="",nomuser="";
    getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
      ville = prefs.getString('ville');
      pdpuser = prefs.getString('pdp');
      nomuser = prefs.getString('nom');
      nomuser += " ";
      nomuser += prefs.getString('prenom');
      print(id);
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
    return AppBar(title: Text('Nouveau Post'));
  }
  Widget _buildForm() {
    return Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
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
                          controller: libelleController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Objet du post",
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
                          controller: descriptionController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Ajouter  une description",
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
     Demande demande = new Demande(libelleController.text,DateTime.now().toString(), descriptionController.text,'d',id,pdpuser,nomuser);
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
