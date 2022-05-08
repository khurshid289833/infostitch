import 'dart:async';
import 'package:infostitch/screen/addReply/model/addReplyModel.dart';
import 'package:infostitch/screen/addReply/repository/addReplyRepository.dart';
import 'package:infostitch/screen/api_base/api_response.dart';

class AddReplyBloc {
  AddReplyRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<AddReplyModel>> get addReplyBlocSink => _controller.sink;

  Stream<ApiResponse<AddReplyModel>> get addReplyBlocStream => _controller.stream;

  AddReplyBloc() {
    _controller = StreamController<ApiResponse<AddReplyModel>>.broadcast();
    _repository = AddReplyRepository();
  }

  addReplyBlocFunction(body,String token) async {
    addReplyBlocSink.add(ApiResponse.loading("Fetching",));
    try {
      AddReplyModel response = await _repository.addReplyRepositoryFunction(body,token);
      addReplyBlocSink.add(ApiResponse.completed(response));
    } catch (e) {
      addReplyBlocSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    addReplyBlocSink?.close();
  }

}