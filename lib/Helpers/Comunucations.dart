import 'package:solidarite/Toasts.dart';
import 'package:url_launcher/url_launcher.dart';

class Comunications {
 
  static void call(String number) => launch("tel:$number");
  static void sendSms(String number) => launch("sms:$number");
  static void sendEmail(String email) async {
  final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toasts.showFailedToast( 'Pas d\'application d\'email trouvée $url');
    }
  }
}
