import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/common/widgets/app_bar.dart';
import 'package:study_app/features/favorite_page/controller/favorite_controller.dart';
import 'package:study_app/features/favorite_page/widget/favorite_widget.dart';

import '../../../common/utils/image_res.dart';


class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(favoriteControllerProvider.notifier).loadFavoriteCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final coursesList = ref.watch(favoriteControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppbar(title: "Yêu thích"),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          switch (coursesList) {
            AsyncData(:final value) => value == null || (value.isEmpty)
                ? Center(
              child: Image.asset(ImageRes.nullImage),
            )
                : FavoriteWidgets(value: value),
            AsyncError(:final error) => Center(
              child: Image.asset(ImageRes.nullImage),
            ),
            _ => const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 2,
                ),
              ),
            ),
          },
        ],
      ),
    );
  }


}


