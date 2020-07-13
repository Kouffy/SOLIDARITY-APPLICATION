import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Views/Admin/LoginAdmin.dart';
import 'package:solidarite/Views/Admin/NewAdmin.dart';
import 'package:solidarite/Views/Listeutilisateur.dart';
import 'package:solidarite/Views/LoginType.dart';
import 'package:solidarite/Views/Register.dart';
import 'package:solidarite/Views/Utilisateur/Archives.dart';
import 'package:solidarite/Views/Utilisateur/EditProfile.dart';
import 'package:solidarite/Views/Utilisateur/Home_Demandeur.dart';
import 'package:solidarite/Views/Utilisateur/Home_volontaire.dart';
import 'package:solidarite/Views/Utilisateur/Login.dart';
import 'package:solidarite/Views/Utilisateur/MesPosts.dart';
import 'package:solidarite/Views/Utilisateur/NewDemande.dart';
import 'package:solidarite/Views/Utilisateur/NewReport.dart';
import 'package:solidarite/Views/Utilisateur/Profile.dart';
import 'package:solidarite/Views/Utilisateur/Volontaires.dart';

class Routes {
  static void navigateToArchives(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Archives()),
    );
    Navigator.pop(context);
  }

  static void navigateToVolontaires(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Volontaires()),
    );
    Navigator.pop(context);
  }

  static void navigateToLogin(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  static void navigateToProfile(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );
    Navigator.pop(context);
  }
    static void navigateToMesPosts(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MesPosts()),
    );
    Navigator.pop(context);
  }
      static void navigateToNewReport(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewReport()),
    );
    Navigator.pop(context);
  }
      static void navigateToNewAdmin(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewAdmin()),
    );
    Navigator.pop(context);
  }
  static void logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginType(),
      ),
      (Route route) => false,
    );
  }
}
