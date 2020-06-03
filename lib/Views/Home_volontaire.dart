import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ListItems.dart';

class Homevolontaire extends StatefulWidget {
  Homevolontaire({Key key}) : super(key: key);
  static const String routeName = '/homevolontaire';
  @override
  _HomevolontaireState createState() => _HomevolontaireState();
}

class _HomevolontaireState extends State<Homevolontaire> {
  String ville = "", region = "";
  int id = 0;
  var idController = new TextEditingController();
  var libelleController = new TextEditingController();
  var datedemandeController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var etatController = new TextEditingController();
  var idUtilisateurController = new TextEditingController();
  var textStyle = TextStyle();
  final connectionissueSanckBar = SnackBar(
    content: Text("404,la connection a echoué"),
  );
  List<Demande> demandes;
  EtatItem selectedEtat;
  List<EtatItem> users = <EtatItem>[
    const EtatItem('Disponible',Icon(Icons.event_available,color:  const Color(0xFF167F67),)),
    const EtatItem('Fermé',Icon(Icons.close,color:  const Color(0xFF167F67),)),
  ];
  void initState() {
    super.initState();
    setState(() {
      idController.text = '1';
    });
  }

  getVille() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ville = prefs.getString('ville');
    });
  }

  getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
    });
  }

  getDemandes() {
    getVille();
    getid();
    APIServices.fetchDemande(ville, id).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandes = demandeList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getDemandes();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
         floatingActionButton: _buildFloatingButton(),
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(text: "Posts"),
              Tab(text: "Nouveux Post"),
            ]),
          ),
          body: TabBarView(children: [
            demandes == null
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildUtilisateurList(),
                _buildForm()
          ])),
    );
  }

  Widget _buildUtilisateurList() {
    return ListView.builder(
      itemCount: demandes.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(demandes[index].libelle.toString()),
              trailing: demandes[index].etat == "d"
                  ? new RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      textColor: Colors.white,
                      onPressed: () => changeEtat(
                          demandes[index].id,
                          demandes[index].libelle,
                          demandes[index].datedemande,
                          demandes[index].description,
                          "e"),
                      child: Text('Intervenir'),
                    )
                  : new RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      textColor: Colors.white,
                      onPressed: () => changeEtat(
                          demandes[index].id,
                          demandes[index].libelle,
                          demandes[index].datedemande,
                          demandes[index].description,
                          "d"),
                      child: Text('Annuler'),
                    ),
              onTap: null,
            ),
          ),
        );
      },
    );
  }

  void changeEtat(int id, String libelle, String datedemande,
      String description, String etat) async {
    Demande demande =
        new Demande.WithId(id, libelle, datedemande, description, etat, 1);
    var saveResponse = await APIServices.putDemandeEncours(demande);
    saveResponse == true ? showSucssesToast() : null;
  }

  void showSucssesToast() {
    Fluttertoast.showToast(
        msg: "Intervention affectée",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
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
           DropdownButton<EtatItem>(
            hint:  Text("Select item"),
            value: selectedEtat,
            onChanged: (EtatItem value) {
              setState(() {
                selectedEtat = value;
              });
            },
            items: users.map((EtatItem etat) {
              return  DropdownMenuItem<EtatItem>(
                value: etat,
                child: Row(
                  children: <Widget>[
                    etat.icon,
                    SizedBox(width: 10,),
                    Text(
                      etat.name,
                      style:  TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
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
    Demande demande = new Demande(
        libelleController.text,
        datedemandeController.text,
        descriptionController.text,
        etatController.text,
        1);
    var saveResponse = await APIServices.postDemande(demande);
    saveResponse == true
        ? showSucssesToast()
        : Scaffold.of(context).showSnackBar(connectionissueSanckBar);
  }
    Widget _buildFloatingButton() {
    return FloatingActionButton(child: Icon(Icons.add), onPressed: () {});
  }
}
