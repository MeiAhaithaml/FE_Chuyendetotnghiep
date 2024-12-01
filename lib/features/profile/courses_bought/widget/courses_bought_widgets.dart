import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/widgets/course_title_widget.dart';


class CoursesBoughtWidgets extends ConsumerWidget {
  final List<CourseItem> value;
  const CoursesBoughtWidgets({super.key, required this.value});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CourseTileWidgets(value: value);
  }
}
