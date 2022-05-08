import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/voteForPhone/model/voteForPhoneModel.dart';

class VoteForPhoneRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<VoteForPhoneModel> voteForPhoneRepositoryFunction(body, token) async {
    final response = await _apiBaseHelper.postWithHeader("api/hospital-n-resources/sendvote", body, "Bearer " + token);
    return VoteForPhoneModel.fromJson(response);
  }
}
