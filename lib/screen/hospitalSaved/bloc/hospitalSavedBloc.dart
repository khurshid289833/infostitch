import 'dart:async';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/hospitalSaved/model/hospitalSavedModel.dart';
import 'package:infostitch/screen/hospitalSaved/repository/hospitalSavedRepository.dart';

class HospitalSavedBloc {
  HospitalSavedRepository _repository;
  StreamController _controller;

  StreamSink<ApiResponse<HospitalSavedModel>> get hospitalSavedSink => _controller.sink;

  Stream<ApiResponse<HospitalSavedModel>> get hospitalSavedStream => _controller.stream;

  HospitalSavedBloc() {
    _controller = StreamController<ApiResponse<HospitalSavedModel>>.broadcast();
    _repository = HospitalSavedRepository();
  }

  hospitalSavedBlocFunction(body,token) async {
    hospitalSavedSink.add(ApiResponse.loading("Fetching",));
    try {
      HospitalSavedModel response = await _repository.hospitalSavedRepositoryFunction(body, token);
      hospitalSavedSink.add(ApiResponse.completed(response));
    } catch (e) {
      hospitalSavedSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
    hospitalSavedSink?.close();
  }

}