import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/app_bar.dart';
import 'package:study_app/features/profile/courses_bought/controller/courses_bought_controller.dart';
import 'package:study_app/features/profile/courses_bought/widget/courses_bought_widgets.dart';

import '../../../../common/widgets/app_shadow.dart';
import '../../../course_detail/view/course_detail.dart';


class CoursesBought extends ConsumerWidget {
  const CoursesBought({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesList = ref.watch(coursesBoughtControllerProvider);
    int i = 0;
    return Scaffold(
        appBar: buildGlobalAppbar(title: "Khoá học của tôi"),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg5.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            switch (coursesList) {
              AsyncData(:final value) => value == null || (value.isEmpty)
                  ? Image.asset(ImageRes.nullImage)
                  : CoursesBoughtWidgets(value:value),
              AsyncError(:final error) => Center(child: Image.asset(ImageRes.nullImage)),
              _ => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 2,
                    ),
                  ))
            },
          ],

        ));
  }
}
