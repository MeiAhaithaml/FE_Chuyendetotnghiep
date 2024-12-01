import 'package:flutter/cupertino.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/image_res.dart';



class AppImage extends StatelessWidget {
 final String imagePath;
 final double width;
 final double height;

  const AppImage({super.key,this.imagePath = ImageRes.defaultImg, this.height =16, this.width = 16});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath.isEmpty ? ImageRes.defaultImg : imagePath,
      width: width,
      height: height,
    );
  }
}

Widget appImageWithColor(
    {String imagePath = ImageRes.defaultImg,
    double width = 16,
    double height = 16,
    Color color = AppColors.primaryElement}) {
  return Image.asset(
    imagePath.isEmpty ? ImageRes.defaultImg : imagePath,
    width: width,
    height: height,
  );
}
