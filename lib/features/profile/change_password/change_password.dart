import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/app_bar.dart';
import 'package:study_app/common/widgets/app_textfields.dart';
import 'package:study_app/common/widgets/button_widgets.dart';
import 'package:study_app/features/profile/change_password/controller/change_controller.dart';
import 'package:study_app/features/profile/change_password/provider/change_password_notifier.dart';



import '../../../common/global_loader/global_loader.dart';


class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends ConsumerState<ChangePassword> {
  late ChangePasswordController _controller;

  @override
  void didChangeDependencies() {

    _controller = ChangePasswordController();

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = ref.watch(changePasswordNotifierProvider);


    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppbar(title: "Đổi mật khẩu"),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  //email text box
                  Consumer(
                    builder: (_, WidgetRef ref, child){

                      return appTextField(
                        controller: _controller.passwordController,
                        text: "Mật khẩu mới",
                        iconName:  ImageRes.lock,
                        hintText: "Vui lòng nhập mật khẩu",
                          obscureText: true,
                        func: (value) => ref
                            .read(changePasswordNotifierProvider.notifier).setPassword(value),


                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //password text box
                  appTextField(
                      controller:  _controller.confirmPasswordController,
                      text: "Xác nhận mật khẩu",
                      iconName:  ImageRes.lock,
                      hintText: "Xác nhận mật khẩu",
                      obscureText: true,
                      func: (value) => ref
                          .read(changePasswordNotifierProvider.notifier).setConfirm(value),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: AppButton(
                        buttonName: "Đổi mật khẩu",
                        func:()=> _controller.handleChange(context,ref),

                      )),
                  SizedBox(
                    height: 20.h,)
                ],
              ),
            ) ),
      ),
    );
  }
}
