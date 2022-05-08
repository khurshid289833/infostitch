import 'dart:async';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/voteForComment/model/voteForCommentModel.dart';
import 'package:infostitch/screen/voteForComment/repository/voteForCommentRepository.dart';

class VoteForCommentBloc {
  VoteForCommentRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<VoteForCommentModel>> get voteForCommentSink => _controller.sink;

  Stream<ApiResponse<VoteForCommentModel>> get voteForCommentStream => _controller.stream;

  VoteForCommentBloc() {
    _controller = StreamController<ApiResponse<VoteForCommentModel>>.broadcast();
    _repository = VoteForCommentRepository();
  }

  voteForHospitalBlocFunction(body,token) async {
    voteForCommentSink.add(ApiResponse.loading("Fetching",));
    try {
      VoteForCommentModel response = await _repository.voteForCommentRepositoryFunction(body,token);
      voteForCommentSink.add(ApiResponse.completed(response));
    } catch (e) {
      voteForCommentSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    voteForCommentSink?.close();
  }

}