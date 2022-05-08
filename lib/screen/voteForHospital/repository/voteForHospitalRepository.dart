import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/voteForHospital/model/voteForHospitalModel.dart';

class VoteForHospitalRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<VoteForHospitalModel> voteForHospitalRepositoryFunction(body,token) async {
    final response = await _helper.postWithHeader("api/hospital/vote", body,"Bearer " + token);
    return VoteForHospitalModel.fromJson(response);
  }
}