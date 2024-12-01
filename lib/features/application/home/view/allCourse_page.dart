import 'package:study_app/common/models/course_entities.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/app_bar.dart';
import 'package:study_app/common/widgets/course_title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:study_app/features/application/home/controller/home_controller.dart';

class AllCoursePage extends ConsumerStatefulWidget {
  const AllCoursePage({super.key});

  @override
  _AllCoursePageState createState() => _AllCoursePageState();
}

class _AllCoursePageState extends ConsumerState<AllCoursePage> {
  @override
  void initState() {
    super.initState();
    ref.read(homeCourseListProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final coursesList = ref.watch(homeCourseListProvider);

    return Scaffold(
      appBar: buildGlobalAppbar(title: "Tất cả khoá học"),
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
          coursesList.when(
            data: (value) {
              if (value == null || value.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return AllCourseWidgets(value: value);
            },
            error: (error, stackTrace) {
              // Xử lý lỗi và hiển thị hình ảnh lỗi nếu có
              return Center(child: Image.asset(ImageRes.nullImage));
            },
            loading: () {
              // Hiển thị khi đang tải dữ liệu
              return const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
          ),
        ],

      ),
    );
  }
}


class AllCourseWidgets extends ConsumerWidget {
  final List<CourseItem> value;
  const AllCourseWidgets({super.key, required this.value});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CourseTileWidgets(value: value);
  }
}
