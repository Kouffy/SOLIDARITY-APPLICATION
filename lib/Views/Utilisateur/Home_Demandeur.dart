import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Commentaire.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Views/Utilisateur/NewDemande.dart';

import '../../Toasts.dart';

class HomeDemandeur extends StatefulWidget {
  static const String routeName = '/homedemandeur';
  @override
  _HomeDemandeurState createState() => _HomeDemandeurState();
}

class _HomeDemandeurState extends State<HomeDemandeur> {
  int id = 0;
  String ville = "";
  List<Demande> demandesActive;
  List<Demande> posts;
  TextEditingController commentaireController = new TextEditingController();
    final connectionissueSanckBar = SnackBar(
    content: Text("404,la connection a echoué"),
  );

  getDemandesActive() {
    APIServices.fetchDemandeActive(id).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandesActive = demandeList;
      });
    });
  }

  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
      ville = prefs.getString('ville');
      print(id);
    });
  }

  getPosts() {
    APIServices.fetchPosts(ville).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        posts = demandeList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    getDemandesActive();
    getPosts();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: _buildFloatingButton(),
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(text: "Mes demandes"),
              Tab(text: "Posts"),
            ]),
          ),
          body: TabBarView(children: [
            demandesActive == null
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildDemandesActiveList(),
            posts == null
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildPostsList(),
          ])),
    );
  }

  Widget _buildDemandesActiveList() {
    return ListView.builder(
      itemCount: demandesActive.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(demandesActive[index].libelle),
              trailing: demandesActive[index].etat == "d"
                  ? new RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      textColor: Colors.white,
                      onPressed: () => changeEtat(
                          demandesActive[index].id,
                          demandesActive[index].libelle,
                          demandesActive[index].datedemande,
                          demandesActive[index].description,
                          "d"),
                      child: Text('Intialiser'),
                    )
                  : new RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      textColor: Colors.white,
                      onPressed: () => changeEtat(
                          demandesActive[index].id,
                          demandesActive[index].libelle,
                          demandesActive[index].datedemande,
                          demandesActive[index].description,
                          "t"),
                      child: Text('Finir'),
                    ),
              onTap: null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostsList() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: Column(
              children: <Widget>[
                Container(
                  child: new Column(
                    children: <Widget>[
                      new Text(posts[index].libelle),
                      new Text(posts[index].description),
                    ],
                  ),
                ),
                Container(
                  child: new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new TextField(
                          decoration: const InputDecoration(
                              hintText: "votre comentaire"),
                          style: new TextStyle(),
                          controller: commentaireController,
                        ),
                      ),
                      RaisedButton(child: Text('Publier'), onPressed: (){ commenter(id,posts[index].id);})
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  void changeEtat(int id, String libelle, String datedemande,
      String description, String etat) async {
    Demande demande =
        new Demande.WithId(id, libelle, datedemande, description, etat, 1);
    var saveResponse = await APIServices.putDemandeEncours(demande);
    saveResponse == true ? Toasts.showSucssesToast("zahia") : null;
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateToNewDemande();
        });
  }

  void navigateToNewDemande() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewDemande()),
    );
  }
  void commenter(int idUser,int idDemande) async {
         Commentaire commentaire = new Commentaire(commentaireController.text,DateTime.now().toString(),idUser,idDemande);
    var saveResponse = await APIServices.postCommantaire(commentaire);
    saveResponse == true
        ? Toasts.showSucssesToast('Commentaire publié')
        : Scaffold.of(context).showSnackBar(connectionissueSanckBar);
       // Navigator.pop(context);
  }
  

}

