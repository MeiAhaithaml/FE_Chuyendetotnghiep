import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:study_app/common/services/http_util.dart';
import 'package:study_app/main.dart';


import '../../../common/global_loader/global_loader.dart';
import '../../../common/models/contants.dart';
import '../../../common/models/user.dart';
import '../../../common/widgets/popup_messages.dart';
import '../../../global.dart';
import '../provider/sign_in_notifier.dart';
import '../repo/sigin_in_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController {

  SignInController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignIn(WidgetRef ref) async {
    var state = ref.watch(signInNotifierProvider);
    String email = state.email;
    String password = state.password;

    emailController.text = email;
    passwordController.text = password;


    if (state.email.isEmpty || email.isEmpty) {
      toastInfo("Vui lòng nhập email của bạn");
      return;
    }
    if ((state.password.isEmpty) || password.isEmpty) {
      toastInfo("Vui lòng nhập mật khẩu của bạn ");
      return;
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {

      final credential = await SignInRepo.firebaseSignIn(email, password);

      if(credential.user==null){
        toastInfo("Không tìm thấy người dùng");
        return;
      }

      if(!credential.user!.emailVerified){
        toastInfo("Bạn cần phải xác nhận email của bạn trước!");
        return;
      }
      var user = credential.user;

      if(user!=null){

        String? displayName = user.displayName;
        String? email = user.email;
        String? id = user.uid;
        String? photoUrl = user.photoURL;
        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.avatar = photoUrl;
        loginRequestEntity.name = displayName;
        loginRequestEntity.email = email;
        loginRequestEntity.open_id = id;
        loginRequestEntity.type = 2;
        asyncPostAllData(loginRequestEntity);
        if (kDebugMode) {
          print("Người dùng đăng nhập");
        }
      }else{
        toastInfo("Đăng nhập sai");
      }
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        toastInfo("Không tìm thấy người dùng");
      }else if(e.code=='wrong-password'){
        toastInfo("Sai  mật khẩu ");
      }


    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    try {
      var result = await SignInRepo.login(params: loginRequestEntity);
      if(result.code==200){
        try{
              Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data));
              Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
          navKey.currentState?.pushNamedAndRemoveUntil("/application", (route) => false);
        }catch(e){
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }else{
        toastInfo("Login error");
      }
    } catch (e) {
      print("Error: $e");
      print("Error: ${e.toString()}");

    }





  }


}
