import 'dart:async';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/voteForHospital/model/voteForHospitalModel.dart';
import 'package:infostitch/screen/voteForHospital/repository/voteForHospitalRepository.dart';

class VoteForHospitalBloc {
  VoteForHospitalRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<VoteForHospitalModel>> get voteForHospitalSink => _controller.sink;

  Stream<ApiResponse<VoteForHospitalModel>> get voteForHospitalStream => _controller.stream;

  VoteForHospitalBloc() {
    _controller = StreamController<ApiResponse<VoteForHospitalModel>>.broadcast();
    _repository = VoteForHospitalRepository();
  }

  voteForHospitalBlocFunction(body,token) async {
    voteForHospitalSink.add(ApiResponse.loading("Fetching",));
    try {
      VoteForHospitalModel response = await _repository.voteForHospitalRepositoryFunction(body,token);
      voteForHospitalSink.add(ApiResponse.completed(response));
    } catch (e) {
      voteForHospitalSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    voteForHospitalSink?.close();
  }

}