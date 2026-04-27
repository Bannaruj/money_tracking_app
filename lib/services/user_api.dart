// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:money_service_server/models/user.dart';

class UserApi {
  final supabase = Supabase.instance.client;

  Future<bool> registerUser(User user, File? userFile) async {
    try {
      String userImage = '';

      if (userFile != null) {
        final fileName = 'user_${DateTime.now().millisecondsSinceEpoch}_${userFile.path.split('/').last}';
        await supabase.storage.from('user_images').upload(fileName, userFile);
        userImage = fileName;
      }

      await supabase.from('user_tb').insert({
        'userFullname': user.userFullname,
        'userBirthDate': user.userBirthDate,
        'userName': user.userName,
        'userPassword': user.userPassword,
        'userImage': userImage,
      });

      return true;
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return false;
    }
  }

  Future<User> loginUser(User user) async {
    try {
      final data = await supabase
          .from('user_tb')
          .select()
          .eq('userName', user.userName!)
          .eq('userPassword', user.userPassword!)
          .maybeSingle();

      if (data != null) {
        return User.fromJson(data);
      } else {
        return User();
      }
    } catch (err) {
      print('ERROR: $err');
      return User();
    }
  }

  Future<User?> updateUser(int userId, String fullName, File? userFile, String? currentImage) async {
    try {
      String userImage = currentImage ?? '';

      if (userFile != null) {
        final fileName = 'user_${DateTime.now().millisecondsSinceEpoch}';
        await supabase.storage.from('user_images').upload(fileName, userFile);
        userImage = fileName;
      }

      final data = await supabase.from('user_tb').update({
        'userFullname': fullName,
        'userImage': userImage,
      }).eq('userId', userId).select().single();

      return User.fromJson(data);
    } catch (err) {
      print('ERROR updating user: $err');
      return null;
    }
  }
}
