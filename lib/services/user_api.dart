// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:money_service_server/constant/baseurl_constant.dart';
import 'package:money_service_server/models/user.dart';

class UserApi {
  final dio = Dio();
  Future<bool> registerUser(User user, File? userFile) async {
    try {
      final formData = FormData.fromMap({
        'userFullname': user.userFullname,
        'userBirthDate': user.userBirthDate,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
          'userImage': await MultipartFile.fromFile(
            userFile.path,
            filename: userFile.path.split('/').last,
            contentType: DioMediaType('image', userFile.path.split('.').last),
          ),
      });

      final responseData = await dio.post(
        '$baseUrl/user/',
        data: formData,
        options: Options(headers: {'content-type': 'multipart/form-data'}),
      );
      print(responseData.statusCode);
      if (responseData.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return false;
    }
  }

  Future<User> loginUser(User user) async {
    try {
      final responseData = await dio.get(
        '$baseUrl/user/${user.userName}/${user.userPassword}/',
      );
      if (responseData.statusCode == 200) {
        return User.fromJson(responseData.data['info']);
      } else {
        return User();
      }
    } catch (err) {
      print('ERROR: ${err}');
      return User();
    }
  }
}
