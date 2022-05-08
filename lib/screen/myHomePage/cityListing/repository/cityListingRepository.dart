import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/myHomePage/cityListing/model/cityListingModel.dart';

class CityListingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CityListingModel> cityListingRepositoryFunction(int pincode) async {
    final response = await _helper.get("api/location/listings/pincode?pincode=$pincode");
    return CityListingModel.fromJson(response);
  }
}