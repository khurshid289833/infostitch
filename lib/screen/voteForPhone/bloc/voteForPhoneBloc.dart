import 'dart:async';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/voteForPhone/model/voteForPhoneModel.dart';
import 'package:infostitch/screen/voteForPhone/repository/voteForPhoneRepository.dart';

class VoteForPhoneBloc {

  VoteForPhoneRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<VoteForPhoneModel>> get voteForPhoneSink => _controller.sink;

  Stream<ApiResponse<VoteForPhoneModel>> get voteForPhoneStream => _controller.stream;

  VoteForPhoneBloc(){
    _controller = StreamController<ApiResponse<VoteForPhoneModel>>.broadcast();
    _repository = VoteForPhoneRepository();
  }


  voteForPhoneBlocFunction(body,token) async {
    voteForPhoneSink.add(ApiResponse.loading("Fetching",));
    try {
      VoteForPhoneModel response = await _repository.voteForPhoneRepositoryFunction(body,token);
      voteForPhoneSink.add(ApiResponse.completed(response));
    } catch (e) {
      voteForPhoneSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    voteForPhoneSink?.close();
  }

}