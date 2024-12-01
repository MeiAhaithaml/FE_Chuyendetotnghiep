import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_app/common/widgets/app_shadow.dart';
import 'package:study_app/common/widgets/text_widgets.dart';
import 'package:study_app/features/sign_in/view/sign_in.dart';
import 'package:study_app/global.dart';


import '../models/contants.dart';

class AppOnBoardingPage extends StatelessWidget {
  final PageController controller;
  final String imagePath;
  final String title;
  final String subTitle;
  final int index;
  final BuildContext context;

  const AppOnBoardingPage(
      {super.key,
      required this.context,
      required this.controller,
      required this.imagePath,
      required this.subTitle,
      required this.title,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.fitWidth,
        ),
        Container(
            margin: const EdgeInsets.only(top: 15),
            child: text24Normal(text: title)),
        Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text16Normal(text: subTitle)),
        _nextButton(index, controller, context)
      ],
    );
  }
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index < 3) {
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      } else {
        Global.storageService
            .setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const SignIn()));
      }
    },
    child: Container(
      width: 325,
      height: 50,
      margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
      decoration: appBoxShadow(),
      child: Center(
          child: Text16Normal(
              text: index < 3 ? "Next" : "Get Started", color: Colors.white)),
    ),
  );
}
