import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app/common/global_loader/global_loader.dart';
import 'package:study_app/common/utils/app_colors.dart';
import 'package:study_app/common/utils/image_res.dart';
import 'package:study_app/common/widgets/app_bar.dart';
import 'package:study_app/common/widgets/button_widgets.dart';
import 'package:study_app/common/widgets/text_widgets.dart';
import 'package:study_app/features/sign_in/controller/sign_in_controller.dart';
import 'package:study_app/features/sign_in/provider/sign_in_notifier.dart';
import 'package:study_app/features/sign_in/sign_admin/controller/sign_admin_controller.dart';
import 'package:study_app/features/sign_in/sign_admin/provider/sign_admin_notifier.dart';
import 'package:study_app/features/sign_in/view/widgets/sign_in_widgets.dart';

import '../../../../common/widgets/app_textfields.dart';

class SignInAdmin extends ConsumerStatefulWidget {
  const SignInAdmin({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInAdmin> createState() => _SignInAdminState();
}

class _SignInAdminState extends ConsumerState<SignInAdmin> {
  late SignAdminController _controller;

  @override
  void didChangeDependencies() {
    _controller = SignAdminController();

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final signInAdminProvider = ref.watch(signAdminNotifierProvider);
    final loader = ref.watch(appLoaderProvider);

    return SafeArea(
      child: Scaffold(
          appBar: buildAppbar(title: "Đăng nhập "),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bghome.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              loader == false
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text16Normal(
                              text: "Đăng nhập với tư cách giáo viên",
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 80.h,
                          ),
                          Consumer(
                            builder: (_, WidgetRef ref, child) {
                              return appTextField(
                                controller: _controller.userNameController,
                                text: "Tên đăng nhập",
                                iconName: ImageRes.user,
                                hintText: "Vui lòng nhập",
                                func: (value) => ref
                                    .read(signAdminNotifierProvider.notifier)
                                    .onUserNameChange(value),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          appTextField(
                              controller: _controller.passwordController,
                              text: "Mật khẩu",
                              iconName: ImageRes.lock,
                              hintText: "Nhập mật khẩu",
                              obscureText: true,
                              func: (value) => ref
                                  .read(signInNotifierProvider.notifier)
                                  .onUserPasswordChange(value)),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 80.h,
                          ),
                          //app login button
                          Center(
                              child: AppButton(
                            buttonName: "Đăng nhập",
                            func: () => _controller.handleSignAdmin(ref),
                          )),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                              child: AppButton(
                                  buttonName: "Đăng nhập học viên",
                                  isLogin: false,
                                  context: context,
                                  func: () =>
                                      Navigator.pushNamed(context, "/sign_in")))
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                        color: AppColors.primaryElement,
                      ),
                    ),
            ],
          )),
    );
  }
}
