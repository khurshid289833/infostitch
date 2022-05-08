import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/feed/model/vaccinationCentersByPincodeModel.dart';

class VaccinationCentersByPincodeRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<VaccinationCentersByPincodeModel> VaccinationCentersByPincodeRepositoryFunction(String pincode) async {
    final response = await _helper.get("api/cowin/vaccine/availability/pincode?pincode=$pincode");
    return VaccinationCentersByPincodeModel.fromJson(response);
  }
}