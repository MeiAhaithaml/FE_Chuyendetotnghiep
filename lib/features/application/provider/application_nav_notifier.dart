import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/common/api/chat.dart';
import 'package:study_app/common/models/base_entities.dart';
import 'package:study_app/common/models/chat.dart';
import 'package:study_app/global.dart';
part 'application_nav_notifier.g.dart';

@riverpod
class ApplicationNavIndex extends _$ApplicationNavIndex{
  @override
  int build(){
    return 0;
  }

  void changeIndex(int val){
    state = val;
  }
  void init(){
    firebaseMessage();
  //  CallVocieOrVideo();
  }

  // void CallVocieOrVideo() async {
  //   var _prefs = await SharedPreferences.getInstance();
  //   await _prefs.reload();
  //   var res = await _prefs.getString("CallVocieOrVideo") ?? "";
  //   print("CallVocieOrVideo-----${res}");
  //   if (res.isNotEmpty) {
  //     var data = jsonDecode(res);
  //     await _prefs.setString("CallVocieOrVideo", "");
  //     print(data);
  //     // "call_role":"audience",
  //     String to_token = data["to_token"];
  //     String to_name = data["to_name"];
  //     String to_avatar = data["to_avatar"];
  //     String call_type = data["call_type"];
  //     String doc_id = data["doc_id"]??"";
  //     DateTime expire_time = DateTime.parse(data["expire_time"]);
  //     DateTime nowtime = DateTime.now();
  //     var Seconds = nowtime.difference(expire_time).inSeconds;
  //     print("Seconds------");
  //     print(Seconds);
  //     if (Seconds < 30) {
  //       String title = "";
  //       String appRoute = "";
  //       if (call_type == "voice") {
  //         title = "Voice call";
  //         appRoute = AppRoutes.VoiceCall;
  //       } else {
  //         title = "Video call";
  //         appRoute = AppRoutes.VideoCall;
  //       }
  //       Global.TopSnakbarKey.currentState?.show(to_name, to_token, to_avatar, doc_id, "audience", title, appRoute);
  //     }
  //   }
  // }

  void firebaseMessage() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    if (fcmToken != null) {
      BindFcmTokenRequestEntity bindFcmTokenRequestEntity =
      new BindFcmTokenRequestEntity();
      bindFcmTokenRequestEntity.fcmtoken = fcmToken;
      await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);
    }
  }

  void sendNotifications(String call_type, String to_token, String to_avatar,
      String to_name,String doc_id) async {
    CallRequestEntity callRequestEntity = new CallRequestEntity();
    callRequestEntity.call_type = call_type;
    callRequestEntity.to_token = to_token;
    callRequestEntity.to_avatar = to_avatar;
    callRequestEntity.doc_id = doc_id;
    callRequestEntity.to_name = to_name;
    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    print("sendNotifications");
    print(res);
    if (res.code == 0) {
      print("sendNotifications success");
    }
  }


}
