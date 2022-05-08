import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/feed/model/vaccinationCentersByDistrictIdModel.dart';

class VaccinationCentersByDistrictIdRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<VaccinationCentersByDistrictIdModel> vaccinationCentersByDistrictIdRepositoryFunction(int districtID) async {
    final response = await _helper.get("api/cowin/vaccine/availability/district-id?district_id=$districtID");
    return VaccinationCentersByDistrictIdModel.fromJson(response);
  }
}