import 'dart:io';
import 'package:dio/dio.dart';
import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/profile/model/profileUpdateModel.dart';

class ProfileUpdateRepository {

  ApiBaseHelper _helper = ApiBaseHelper();
  final Dio _dio = Dio();

  Future<ProfileUpdateModel> ProfileUpdateRepositoryFunction(Map body, File imageFile1, String token) async {

    if (imageFile1 != null) {
      print("Image Path : ${imageFile1.path}");

      var filenames = await MultipartFile.fromFile(File(imageFile1.path).path, filename: imageFile1.path);
      FormData formData = FormData.fromMap({"profile_pic": filenames});
      Response res = await _dio.post(ApiBaseHelper.baseUrl + "api/upload/profile-image", data: formData, options: Options(headers: {"Authorization": "Bearer " + token}));

      print("Response Data : ${res.data}");
      print("Data within Response Data : ${res.data['data']}");

      if (res.data['status'] == 200) {
        print("Profile Picture Path : ${res.data["data"]["profile_pic"]}");
        body["profile_pic"] = res.data["data"]["profile_pic"];
        final response = await _helper.postWithHeader("api/update/profile", body, "Bearer $token");
        return ProfileUpdateModel.fromJson(response);
      }

    }else {
      final response = await _helper.postWithHeader("api/update/profile", body, "Bearer $token");
      return ProfileUpdateModel.fromJson(response);
    }
  }
}



