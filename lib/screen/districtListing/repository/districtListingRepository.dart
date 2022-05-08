import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/districtListing/model/districtListingModel.dart';

class DistrictListingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DistrictListingModel> districtListingRepositoryFunction(int state_id) async {
    final response = await _helper.get("api/getall/districtBystate/stateId?state_id=$state_id");
    return DistrictListingModel.fromJson(response);
  }
}