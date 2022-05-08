import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/feed/model/helplineNumberModel.dart';

class HelplineNumberByPincodeCityRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<HelplineNumberModel> helplineNumberByPincodeCityRepositoryFunction(String pinCode,String city,int page) async {
    final response = await _helper.get("api/helpline-number/pincode-city/listings?pincode=$pinCode&city=$city&page=$page");
    return HelplineNumberModel.fromJson(response);
  }
}