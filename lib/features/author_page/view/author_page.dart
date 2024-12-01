import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/models/msg.dart';
import 'package:study_app/common/models/user.dart';
import 'package:study_app/common/routes/app_routes_names.dart';
import 'package:study_app/global.dart';

import '../../../common/models/course_entities.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/button_widgets.dart';
import '../../../common/widgets/popup_messages.dart';
import '../controller/author_controller.dart';
import '../widget/author_widgets.dart';


class AuthorPage extends ConsumerStatefulWidget {
  const AuthorPage({super.key});

  @override
  ConsumerState<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends ConsumerState<AuthorPage> {
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    ref.read(courseAuthorControllerProvider.notifier).init(args["token"]);
    ref.read(authorCourseListControllerProvider.notifier).init(args["token"]);

    super.didChangeDependencies();
  }
  goChat(AuthorItem authorItem) async {
    final db = FirebaseFirestore.instance;
    UserProfile userProfile = Global.storageService.getUserProfile();

    if (authorItem.token == userProfile.token) {
      toastInfo("Không thể chat！");
      return;
    }
    var from_messages = await db
        .collection("message")
        .withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options) => msg.toFirestore(),
    )
        .where("from_token", isEqualTo: userProfile.token)
        .where("to_token", isEqualTo: authorItem.token)
        .get();
    var to_messages = await db
        .collection("message")
        .withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options) => msg.toFirestore(),
    )
        .where("from_token", isEqualTo: authorItem.token)
        .where("to_token", isEqualTo: userProfile.token)
        .get();

    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      print("----from_messages--to_messages--empty--");
      var msgdata = new Msg(
        from_token: userProfile.token,
        to_token: authorItem.token,
        from_name: userProfile.name,
        to_name: authorItem.name,
        from_avatar: userProfile.avatar,
        to_avatar: authorItem.avatar,
        from_online: userProfile.online,
        to_online: authorItem.online,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      var doc_id = await db
          .collection("message")
          .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore(),
      )
          .add(msgdata);
      Navigator.of(ref.context).pushNamed(AppRoutesNames.CHAT_PAGE, arguments: {
        "doc_id": doc_id.id,
        "to_token": authorItem.token ?? "",
        "to_name": authorItem.name ?? "",
        "to_avatar": authorItem.avatar ?? "",
        "to_online": authorItem.online.toString()
      });
    } else {
      if (!from_messages.docs.isEmpty) {
        print("---from_messages");
        print(from_messages.docs.first.id);
        Navigator.of(ref.context).pushNamed(AppRoutesNames.CHAT_PAGE, arguments: {
          "doc_id": from_messages.docs.first.id,
          "to_token": authorItem.token ?? "",
          "to_name": authorItem.name ?? "",
          "to_avatar": authorItem.avatar ?? "",
          "to_online": authorItem.online.toString()
        });
      }
      if (!to_messages.docs.isEmpty) {
        print("---to_messages");
        print(to_messages.docs.first.id);
        Navigator.of(ref.context).pushNamed(AppRoutesNames.CHAT_PAGE, arguments: {
          "doc_id": to_messages.docs.first.id,
          "to_token": authorItem.token ?? "",
          "to_name": authorItem.name ?? "",
          "to_avatar": authorItem.avatar ?? "",
          "to_online": authorItem.online.toString()
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var authorInfo = ref.watch(courseAuthorControllerProvider);
    var authorCourses = ref.watch(authorCourseListControllerProvider);

    return Scaffold(
      appBar: buildGlobalAppbar(title: "Giáo viên"),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          switch (authorInfo) {
            AsyncData(:final value) => value == null
                ? const Center(
              child: CircularProgressIndicator(color: Colors.black26, strokeWidth: 2),
            )
                : Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
              child: Column(
                children: [
                  AuthorMenu(authorInfo: value),
                  AuthorDescription(authorInfo: value),
                  SizedBox(height: 20.h),
                  AppButton(
                    buttonName: "Nhắn tin",
                    func: () {
                      goChat(value);
                    },
                  ),
                  authorCourses.when(
                    data: (courseData) => courseData != null
                        ? CourseAuthorList(courseData: courseData)
                        : const Text("Không có khoá học khả thi"),
                    loading: () => const CircularProgressIndicator(),
                    error: (e, _) => Text('Lỗi: $e'),
                  ),
                ],
              ),
            ),
            AsyncError(:final error) => Text('Không thể load data: $error'),
            _ => const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 2,
              ),
            ),
          },
        ],
      ),
    );
  }

}



