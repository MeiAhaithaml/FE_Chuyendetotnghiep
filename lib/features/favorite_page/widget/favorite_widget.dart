import '../../../common/models/course_entities.dart';
import '../../../common/widgets/course_title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class FavoriteWidgets extends ConsumerWidget {
  final List<CourseItem> value;
  const FavoriteWidgets({super.key, required this.value});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CourseTileWidgets(value: value);
  }
}
