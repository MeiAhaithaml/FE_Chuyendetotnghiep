import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/widgets/course_title_widget.dart';
import 'package:study_app/common/widgets/text_widgets.dart';

class CoursesSearchWidgets extends ConsumerWidget {
  final List<CourseItem> value;

  const CoursesSearchWidgets({super.key, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CourseSearchWidgets(value: value);
  }
}

class TopSearchWidget extends StatelessWidget {
  const TopSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text16Normal(
          text: "Top tìm kiếm",
          color: AppColors.primaryText,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            TopWidget(text: "Toán cao cấp"),
            TopWidget(text: "Đại số"),
            TopWidget(text: "Tin học"),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            TopWidget(text: "Văn học"),
            TopWidget(text: "Lịch sử"),
            TopWidget(text: "Công nghệ"),


          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text16Normal(
          text: "Kết quả tìm kiếm",
          color: AppColors.primaryText,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}

class TopWidget extends StatelessWidget {
  final String text;

  const TopWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color(0xFFEDEEF0),
        height: 42,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text14Normal(
              text: text,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
