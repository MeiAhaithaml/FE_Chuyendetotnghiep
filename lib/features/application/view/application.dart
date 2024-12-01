import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/features/application/view/widgets/widgets.dart';

import '../../../common/utils/app_colors.dart';
import '../../../common/widgets/app_shadow.dart';
import '../provider/application_nav_notifier.dart';

class Application extends ConsumerStatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  ConsumerState<Application> createState() => _ApplicationPage();
}

class _ApplicationPage extends ConsumerState<Application> with WidgetsBindingObserver {
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(applicationNavIndexProvider.notifier).init();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("-didChangeAppLifecycleState-" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive:
        print("Ứng dụng có thể bị tạm dừng bất kỳ lúc nào.");
        break;
      case AppLifecycleState.resumed:
        print("Ứng dụng đã chuyển từ nền lên nền trước.");
        break;
      case AppLifecycleState.paused:
        print("Ứng dụng không hiển thị, đang ở chế độ nền.");
        break;
      case AppLifecycleState.detached:
        print("Ứng dụng đã kết thúc.");
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = ref.watch(applicationNavIndexProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: appScreens(index: index),
          bottomNavigationBar: Container(
            width: 375.w,
            height: 58.h,
            decoration: appBoxShadowWithRadius(),
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (value) {
                ref.read(applicationNavIndexProvider.notifier).changeIndex(value);
              },
              elevation: 0,
              items: bottomTabs,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: AppColors.primaryElement,
              unselectedItemColor: AppColors.primaryFourthElementText,
            ),
          ),
        ),
      ),
    );
  }
}
