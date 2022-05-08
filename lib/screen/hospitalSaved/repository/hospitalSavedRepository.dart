import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/hospitalSaved/model/hospitalSavedModel.dart';

class HospitalSavedRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<HospitalSavedModel> hospitalSavedRepositoryFunction(body,token) async {
    final response = await _helper.postWithHeader("api/hospital/save", body,"Bearer " + token);
    return HospitalSavedModel.fromJson(response);
  }
}