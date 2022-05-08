import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/feed/model/helplineNumberModel.dart';

class HelplineNumberByStateDistrictRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<HelplineNumberModel> helplineNumberByStateDistrictRepositoryFunction(String state,String district,int page) async {
    List<String> state1 = state.split('(');
    String stateSplit = state1[0];
    final response = await _helper.get("api/helpline-number/state-district/listings?state=$stateSplit&district=$district&page=$page");
    return HelplineNumberModel.fromJson(response);
  }
}