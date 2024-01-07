import 'package:spinner_try/shivanshu/models/globals.dart';

class PrefStorage {
  PrefStorage._();
  static final instance = PrefStorage._();

  static String? get myRoomUrl {
    return prefs.getString('myRoomUrl');
  }

  static set myRoomUrl(String? url) {
    if (url == null) {
      prefs.remove('myRoomUrl');
    } else {
      prefs.setString('myRoomUrl', url);
    }
  }

  static String? get myRoomName {
    return prefs.getString('myRoomName');
  }

  static set myRoomName(String? url) {
    if (url == null) {
      prefs.remove('myRoomName');
    } else {
      prefs.setString('myRoomName', url);
    }
  }

  static String? get fcmToken {
    return prefs.getString('fcmToken');
  }

  static set fcmToken(String? url) {
    if (url == null) {
      prefs.remove('fcmToken');
    } else {
      prefs.setString('fcmToken', url);
    }
  }

  static bool? get hasAgency {
    return prefs.getBool('hasAgency');
  }

  static set hasAgency(bool? url) {
    if (url == null) {
      prefs.remove('hasAgency');
    } else {
      prefs.setBool('hasAgency', url);
    }
  }

  static void clear() {
    prefs.clear();
  }
}
