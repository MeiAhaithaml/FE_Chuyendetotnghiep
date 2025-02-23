import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:study_app/common/widgets/popup_messages.dart';


/// SHA256
String duSHA256(String input) {
  String salt = 'EIpWsyfiy@R@X#qn17!StJNdZK1fFF8iV6ffN!goZkqt#JxO';
  var bytes = utf8.encode(input + salt);
  var digest = sha256.convert(bytes);

  return digest.toString();
}

String getRandomString(int length){
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

Future<bool> request_permission(Permission permission) async{
  var permission_status = await permission.status;
  print("permission_status------${permission_status}");
  if(permission_status != PermissionStatus.granted) {
    var status = await permission.request();

    if(status != PermissionStatus.granted) {
      print("denied");
      toastInfo("Please open the setting page to set permissions");
      await openAppSettings();
      return false;
    }
  }

  return true;
}
