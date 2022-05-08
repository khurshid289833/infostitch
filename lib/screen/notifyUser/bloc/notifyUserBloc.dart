import 'dart:async';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/notifyUser/model/notifyUserModel.dart';
import 'package:infostitch/screen/notifyUser/repository/notifyUserRepository.dart';

class NotifyUserBloc {
  NotifyUserRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<NotifyUserModel>> get notifyUserSink => _controller.sink;

  Stream<ApiResponse<NotifyUserModel>> get notifyUserStream => _controller.stream;

  NotifyUserBloc() {
    _controller = StreamController<ApiResponse<NotifyUserModel>>.broadcast();
    _repository = NotifyUserRepository();
  }

  notifyUserBlocFunction(body,String token) async {
    notifyUserSink.add(ApiResponse.loading("Fetching",));
    try {
      NotifyUserModel response = await _repository.notifyUserRepositoryFunction(body, token);
      notifyUserSink.add(ApiResponse.completed(response));
    } catch (e) {
      notifyUserSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    notifyUserSink?.close();
  }

}