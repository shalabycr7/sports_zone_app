import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi {
  final fireMes = FirebaseMessaging.instance;

  Future<void> intitNot() async {
    await fireMes.requestPermission();
    final fCTok = await fireMes.getToken();
    print(fCTok);
  }
}
