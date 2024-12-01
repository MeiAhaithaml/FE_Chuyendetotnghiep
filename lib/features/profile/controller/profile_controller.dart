import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/user.dart';
import '../../../global.dart';
import '../repo/profile_repo.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController{

  @override
  UserProfile build()=>Global.storageService.getUserProfile();
  Future<void> updateAvatar(File avatar) async {
    try {
      await ProfileRepo.updateAvatar(avatar);
      final updatedProfile = Global.storageService.getUserProfile();
      state = updatedProfile;
    } catch (e) {
      throw Exception("Error updating avatar: $e");
    }
  }

}