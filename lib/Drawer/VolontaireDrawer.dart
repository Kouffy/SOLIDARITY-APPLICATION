import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Helpers/SessionManager.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Routes/routes.dart';

class VolontaireDrawer extends StatefulWidget {
  @override
  _VolontaireDrawerState createState() => _VolontaireDrawerState();
}

class _VolontaireDrawerState extends State<VolontaireDrawer> {
  String ville, pdpuser, nomuser, email;

  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionManager.isUserLoggedIn().then((isLogged) {
      if (isLogged) {
        setState(() {
          ville = prefs.getString('ville');
          pdpuser = prefs.getString('pdp');
          nomuser = prefs.getString('nom');
          nomuser = " ";
          nomuser += prefs.getString('prenom');
          email = prefs.getString('email');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getPreferences();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.supervised_user_circle,
              text: 'Profile',
              onTap: () => Routes.navigateToProfile(context)),
          _createDrawerItem(
              icon: Icons.supervised_user_circle,
              text: 'Mes posts',
              onTap: () => Routes.navigateToMesPosts(context)),
          _createDrawerItem(
              icon: Icons.report,
              text: 'Envoyer un rapport',
              onTap: () => Routes.navigateToNewReport(context)),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Deconnection',
              onTap: () => Routes.logout(context)),
          ListTile(
            title: Text('Solidarite v 0.0.1'),
            subtitle: Text('copyrights : el mouktafi mohamed 2020'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/DrawerHeader.jpeg'))),
      accountName: nomuser == null ? Text("username") : new Text(nomuser),
      accountEmail: email == null
          ? Text(
              " votre email",
              style: new TextStyle(fontSize: 13.0),
            )
          : Text(
              email,
              style: new TextStyle(fontSize: 13.0),
            ),
      currentAccountPicture: CircleAvatar(
          radius: 30.0,
          backgroundImage: pdpuser == null
              ? AssetImage('assets/images/user.png')
              : NetworkImage(APIServices.urlBase +
                  APIServices.urlUtilisateur +
                  APIServices.urlGetImageUtilisateur +
                  pdpuser)),
      onDetailsPressed: () {
        Routes.navigateToProfile(context);
      },
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
