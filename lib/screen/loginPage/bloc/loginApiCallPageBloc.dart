import 'dart:async';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/loginPage/model/loginApiCallPageModel.dart';
import 'package:infostitch/screen/loginPage/repository/loginApiCallPageRepository.dart';

class LoginApiCallPageBloc {
  LoginApiCallPageRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<LoginApiCallPageModel>> get LoginApiCallPageBlocSink => _controller.sink;

  Stream<ApiResponse<LoginApiCallPageModel>> get LoginApiCallPageBlocStream => _controller.stream;

  LoginApiCallPageBloc() {
    _controller = StreamController<ApiResponse<LoginApiCallPageModel>>.broadcast();
    _repository = LoginApiCallPageRepository();
  }

  LoginApiCallPageBlocFunction(body) async {
    LoginApiCallPageBlocSink.add(ApiResponse.loading(
      "Fetching",
    ));
    try {
      LoginApiCallPageModel response = await _repository
          .LoginApiCallPageRepositoryFunction(body);
      LoginApiCallPageBlocSink.add(ApiResponse.completed(response));
    } catch (e) {
      LoginApiCallPageBlocSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    LoginApiCallPageBlocSink?.close();
  }

}