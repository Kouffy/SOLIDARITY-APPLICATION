import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:solidarite/Models/Utilisateur.dart';

class APIServices {
  static String utilisateurUrl = 'http://192.168.1.5:9090/api/utilisateur/';

  static Future fetchUtilisateur() async {
    return await http.get(utilisateurUrl);
  }

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<bool> postUtilisateur(Utilisateur utilisateur) async {
    var monUtilisateur = utilisateur.toMap();
    var utilisateurBody = convert.json.encode(monUtilisateur);
    var res =
        await http.post(utilisateurUrl, headers: header, body: utilisateurBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> deletetUtilisateur(int id) async {
    var res =
        await http.delete(utilisateurUrl + id.toString(), headers: header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future getUtilisateurLogin(String login, String password) async {
    var res =  await http.get(utilisateurUrl + login + "/" + password);
    return res;
  }
}
