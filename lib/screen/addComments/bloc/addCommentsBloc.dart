import 'dart:async';
import 'package:infostitch/screen/addComments/model/addCommentsModel.dart';
import 'package:infostitch/screen/addComments/repository/addCommentsRepository.dart';
import 'package:infostitch/screen/api_base/api_response.dart';

class AddCommentsBloc {
  AddCommentsRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<AddCommentsModel>> get addCommentsBlocSink => _controller.sink;

  Stream<ApiResponse<AddCommentsModel>> get addCommentsBlocStream => _controller.stream;

  AddCommentsBloc() {
    _controller = StreamController<ApiResponse<AddCommentsModel>>.broadcast();
    _repository = AddCommentsRepository();
  }

  addCommentsBlocFunction(body,String token) async {
    addCommentsBlocSink.add(ApiResponse.loading("Fetching",));
    try {
      AddCommentsModel response = await _repository.addCommentsRepositoryFunction(body,token);
      addCommentsBlocSink.add(ApiResponse.completed(response));
    } catch (e) {
      addCommentsBlocSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    addCommentsBlocSink?.close();
  }

}