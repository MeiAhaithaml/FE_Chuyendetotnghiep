import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/common/widgets/app_bar.dart';
import 'package:study_app/features/course_detail/controller/course_detail_controller.dart';
import 'package:study_app/features/course_detail/view/widget/course_detail_widget.dart';
import 'package:study_app/features/profile/courses_bought/repo/courses_bought_repo.dart';


class CourseDetail extends ConsumerStatefulWidget {
  const CourseDetail({super.key});

  @override
  ConsumerState<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  late var args;
  bool isPurchased = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];
    print(args);
    _checkPurchaseStatus();
  }

  Future<void> _checkPurchaseStatus() async {
    try {
      final courseListResponse = await CoursesBoughtRepo.coursesBought();
      setState(() {
        isPurchased = courseListResponse.data != null &&
            courseListResponse.data!.any((course) => course.id == args);
      });
    } catch (e) {
      print("Error calling coursesBought API: $e");
      setState(() {
        isPurchased = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var stateData =
    ref.watch(courseDetailControllerProvider(index: args.toInt()));
    var lessonData =
    ref.watch(courseLessonListControllerProvider(index: args.toInt()));

    return Scaffold(
      appBar: buildGlobalAppbar(title: "Khoá học"),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stateData.when(
                  data: (data) => data == null
                      ? const SizedBox(
                    child: Text("Không có dữ liệu"),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CourseDetailThumbnail(courseItem: data),
                      CourseDetailIConText(courseItem: data),
                      CourseDetailDescription(courseItem: data),
                      CourseDetailGoBuyButton(courseItem: data),
                      CourseDetailIncludes(courseItem: data),
                    ],
                  ),
                  error: (error, traceStack) =>
                  const Text("Không thể tiến hành tải dữ liệu"),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                // Conditionally display the LessonInfo widget
                if (isPurchased)
                  lessonData.when(
                    data: (data) => data == null
                        ? const SizedBox()
                        : LessonInfo(lessonData: data, ref: ref),
                    error: (error, traceStack) =>
                    const Text("Không thể tiến hành tải bài học"),
                    loading: () => const SizedBox(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),],
      ),
    );
  }
}
