import 'package:solidarite/Views/Admin/LoginAdmin.dart';
import 'package:solidarite/Views/Listeutilisateur.dart';
import 'package:solidarite/Views/LoginType.dart';
import 'package:solidarite/Views/Register.dart';
import 'package:solidarite/Views/Utilisateur/EditProfile.dart';
import 'package:solidarite/Views/Utilisateur/Home_Demandeur.dart';
import 'package:solidarite/Views/Utilisateur/Home_volontaire.dart';
import 'package:solidarite/Views/Utilisateur/Login.dart';
import 'package:solidarite/Views/Utilisateur/NewDemande.dart';
import 'package:solidarite/Views/Utilisateur/Profile.dart';

class Routes {
  static const String editprofile = EditProfile.routeName;
  static const String homedemandeur = HomeDemandeur.routeName;
  static const String homevolontaire = Homevolontaire.routeName;
  static const String listutilisaeur = Utilisateurs.routeName;
  static const String login = Login.routeName;
  static const String loginadmin = LoginAdmin.routeName;
  static const String logintypr = LoginType.routeName;
  static const String newdemande = NewDemande.routeName;
  static const String profile = Profile.routeName;
  static const String register = Register.routeName;
}
