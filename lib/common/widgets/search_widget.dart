import 'package:flutter/cupertino.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/app_shadow.dart';
import 'package:study_app/common/widgets/app_textfields.dart';
import 'package:study_app/common/widgets/images_widget.dart';

class AppSearchBar extends StatelessWidget {
  AppSearchBar({super.key,  this.func, this.searchFunc});
  final VoidCallback? func;
  void Function(String? value)? searchFunc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 260,
          height: 40,
          decoration: appBoxShadow(
              color: AppColors.primaryBackground,
              boxBorder: Border.all(color: AppColors.primaryFourthElementText)),
          child: Row(
            children: [
              Container(
                child: const AppImage(imagePath: ImageRes.searchIcon),
              ),
              SizedBox(
                width: 230,
                height: 40,
                child: appTextFieldOnly(
                    func: searchFunc,
                    width: 240, height: 40, hintText: "Tìm kiếm khoá học của bạn"),
              )
            ],
          ),
        ),
        //search button
        GestureDetector(
          onTap: func,
          child: Container(
            padding: EdgeInsets.all(5),
            width: 40,
            height: 40,
            decoration: appBoxShadow(
                boxBorder: Border.all(color: AppColors.primaryElement)),
            child: const AppImage(imagePath: ImageRes.searchButton),
          ),
        )
      ],
    );
  }
}
