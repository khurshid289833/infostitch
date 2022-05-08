import 'dart:async';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/profile/model/profileUpdateModel.dart';
import 'package:infostitch/screen/profile/repository/profileUpdateRepository.dart';

class ProfileUpdateBloc {
  ProfileUpdateRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<ProfileUpdateModel>> get ProfileUpdateBlocSink => _controller.sink;

  Stream<ApiResponse<ProfileUpdateModel>> get ProfileUpdateBlocStream => _controller.stream;

  ProfileUpdateBloc() {
    _controller = StreamController<ApiResponse<ProfileUpdateModel>>.broadcast();
    _repository = ProfileUpdateRepository();
  }

  ProfileUpdateBlocFunction(body,profile_pic,String token) async {
    ProfileUpdateBlocSink.add(ApiResponse.loading("Fetching",));
    try {
      ProfileUpdateModel response = await _repository.ProfileUpdateRepositoryFunction(body,profile_pic,token);
      ProfileUpdateBlocSink.add(ApiResponse.completed(response));
    } catch (e) {
      ProfileUpdateBlocSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    ProfileUpdateBlocSink?.close();
  }

}