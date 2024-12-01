import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/widgets/app_bar.dart';
import 'package:study_app/common/widgets/search_widget.dart';
import 'package:study_app/features/search/widget/courses_search_widgets.dart';

import '../../../common/utils/image_res.dart';
import '../controller/courses_search_controller.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(coursesSearchControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppbar(title: "Tìm kiếm"),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  AppSearchBar(
                    searchFunc: (search) {
                      ref
                          .watch(coursesSearchControllerProvider.notifier)
                          .searchData(search!);
                    },
                  ),
                  SizedBox(height: 8.h),
                  const TopSearchWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: switch (searchProvider) {
                      AsyncData(:final value) => value == null || (value.isEmpty)
                          ?  Text('')
                          : CoursesSearchWidgets(value: value),
                      AsyncError(:final error) =>
                          Center(child: Text('')),
                      _ => Center(child: Text('')),
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
