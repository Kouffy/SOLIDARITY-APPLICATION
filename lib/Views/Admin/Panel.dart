import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solidarite/Drawer/AdminDrawer.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/Rapport.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Views/Admin/NewAdmin.dart';
import '../../Toasts.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  List<Utilisateur> utilisateurs;
  List<Rapport> rapports;
  List<Demande> demandes;
  TextEditingController usercontroller = new TextEditingController();
  String filteruser;
  TextEditingController postcontroller = new TextEditingController();
  String filterpost;
  getUtilisateurs() {
    APIServices.fetchUtilisateur().then((response) {
      Iterable list = json.decode(response.body);
      List<Utilisateur> utilisateurList = List<Utilisateur>();
      utilisateurList =
          list.map((model) => Utilisateur.fromObject(model)).toList();
      setState(() {
        utilisateurs = utilisateurList;
      });
    });
  }

  getRapports() {
    APIServices.fetchAllRapports().then((response) {
      Iterable list = json.decode(response.body);
      List<Rapport> rapportList = List<Rapport>();
      rapportList = list.map((model) => Rapport.fromObject(model)).toList();
      setState(() {
        rapports = rapportList;
      });
    });
  }

  getDemandes() {
    APIServices.fetchAllDemande().then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandes = demandeList;
      });
    });
  }

  @override
  void dispose() {
    usercontroller.dispose();
    postcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    usercontroller.addListener(() {
      setState(() {
        filteruser = usercontroller.text;
      });
    });
    postcontroller.addListener(() {
      setState(() {
         filterpost = postcontroller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUtilisateurs();
    getDemandes();
    getRapports();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          drawer: AdminDrawer(),
          floatingActionButton: _buildFloatingButton(),
          appBar: AppBar(
            title: Text('Tableau de bord admin'),
            bottom: TabBar(tabs: [
              Tab(text: "Utilisateurs"),
              Tab(text: "Posts"),
              Tab(text: "Rapports")
            ]),
          ),
          body: TabBarView(children: [
            utilisateurs == null || utilisateurs.length == 0
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildUtilisateurList(),
            demandes == null || demandes.length == 0
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildDemandeList(),
            rapports == null || rapports.length == 0
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildRapportList(),
          ])),
    );
  }

  Widget _buildUtilisateurList() {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[100]))),
              child: TextField(
                controller: usercontroller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Chercher un utilisateur",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
          ),
          new Expanded(
              child: ListView.builder(
            itemCount: utilisateurs.length,
            itemBuilder: (context, index) {
              return filteruser == null || filteruser == ""
                  ? Card(
                      color: Colors.blue[50],
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          title: Text(utilisateurs[index].nom +
                              ' ' +
                              utilisateurs[index].prenom),
                          subtitle: Text("email : " +
                              utilisateurs[index].email +
                              '\n' +
                              " mobile :" +
                              utilisateurs[index].tel),
                          leading: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(APIServices
                                              .urlBase +
                                          APIServices.urlUtilisateur +
                                          APIServices.urlGetImageUtilisateur +
                                          utilisateurs[index].pdp)))),
                          trailing: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              onPressed: () =>
                                  supprimerUtilisateur(utilisateurs[index].id),
                              child: Container(
                                height: 40,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text('Supprimer',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                              )),
                          onTap: null,
                        ),
                      ),
                    )
                  : utilisateurs[index].nom.contains(filteruser)
                      ? Card(
                          color: Colors.blue[50],
                          elevation: 2.0,
                          child: ListTile(
                            title: ListTile(
                              title: Text(utilisateurs[index].nom +
                                  ' ' +
                                  utilisateurs[index].prenom),
                              subtitle: Text("email : " +
                                  utilisateurs[index].email +
                                  '\n' +
                                  " mobile :" +
                                  utilisateurs[index].tel),
                              leading: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              APIServices.urlBase +
                                                  APIServices.urlUtilisateur +
                                                  APIServices
                                                      .urlGetImageUtilisateur +
                                                  utilisateurs[index].pdp)))),
                              trailing: new RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.all(0.0),
                                  onPressed: () => supprimerUtilisateur(
                                      utilisateurs[index].id),
                                  child: Container(
                                    height: 40,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ])),
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text('Supprimer',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  )),
                              onTap: null,
                            ),
                          ),
                        )
                      : Container();
            },
          ))
        ]);
  }

  Widget _buildDemandeList() {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[100]))),
              child: TextField(
                controller: postcontroller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Chercher un post",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
          ),
          new Expanded(
              child: ListView.builder(
            itemCount: demandes.length,
            itemBuilder: (context, index) {
                 return filterpost == null || filterpost == ""
                  ? GestureDetector(
                  child: Card(
                      color: Colors.blue[50],
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              APIServices.urlBase +
                                                  APIServices.urlUtilisateur +
                                                  APIServices
                                                      .urlGetImageUtilisateur +
                                                  demandes[index].pdpuser)))),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(demandes[index].nomuser)
                            ],
                          ),
                          Card(
                              elevation: 2.0,
                              color: Colors.blue[100],
                              child: ListTile(
                                title: Text(demandes[index].libelle),
                                subtitle: Text(demandes[index].description),
                              )),
                          new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              onPressed: () =>
                                  supprimerDemande(demandes[index].id),
                              child: Container(
                                height: 40,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text('Supprimer',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                              )),
                        ],
                      )),
                  onTap: () {}) : demandes[index].libelle.contains(filterpost)
                      ? GestureDetector(
                  child: Card(
                      color: Colors.blue[50],
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              APIServices.urlBase +
                                                  APIServices.urlUtilisateur +
                                                  APIServices
                                                      .urlGetImageUtilisateur +
                                                  demandes[index].pdpuser)))),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(demandes[index].nomuser)
                            ],
                          ),
                          Card(
                              elevation: 2.0,
                              color: Colors.blue[100],
                              child: ListTile(
                                title: Text(demandes[index].libelle),
                                subtitle: Text(demandes[index].description),
                              )),
                          new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              onPressed: () =>
                                  supprimerDemande(demandes[index].id),
                              child: Container(
                                height: 40,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text('Supprimer',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                              )),
                        ],
                      )),
                  onTap: () {}) : Container();
            },
          ))
        ]);
  }

  Widget _buildRapportList() {
    return ListView.builder(
      itemCount: rapports.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(rapports[index].libelle),
              subtitle: Text(rapports[index].contenu + '\n envoyé par : mohamed moktafi'),
              trailing: new RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () => supprimerRapport(rapports[index].id),
                  child: Container(
                    height: 40,
                    width: 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ])),
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text('Supprimer',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ),
                  )),
              onTap: null,
            ),
          ),
        );
      },
    );
  }

  void supprimerDemande(int id) async {
    var saveResponse = await APIServices.deletetDemande(id);
    saveResponse == true ? Toasts.showSucssesToast("Post Supprimé") :Toasts.showFailedToast("Erreur");
  }

  void supprimerUtilisateur(int id) async {
    var saveResponse = await APIServices.deletetUtilisateur(id);
    saveResponse == true ? Toasts.showSucssesToast("Utilisateur Supprimé"):Toasts.showFailedToast("Erreur");
  }

  void supprimerRapport(int id) async {
    var saveResponse = await APIServices.deleteRapport(id);
    saveResponse == true ? Toasts.showSucssesToast("Rapport Supprimé") :Toasts.showFailedToast("Erreur");
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateToNewAdimin();
        });
  }

  void navigateToNewAdimin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewAdmin()),
    );
  }
}
