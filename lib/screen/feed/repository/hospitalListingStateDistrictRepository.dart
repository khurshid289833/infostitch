import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/feed/model/hospitalsListingModel.dart';

class HospitalListingByStateDistrictRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<HospitalsListingModel> hospitalListingByStateDistrictRepositoryFunctionGet(String state,String district, int pageno) async {
    List<String> state1 = state.split('(');
    String stateSplit = state1[0];
    final response = await _helper.get("api/hospital-n-resources/state-district/listings?state=$stateSplit&district=$district&page=$pageno");
    return HospitalsListingModel.fromJson(response);
  }
  Future<HospitalsListingModel> hospitalListingByStateDistrictRepositoryFunctionPost(String state,String district, int pageno,String token) async {
    List<String> state1 = state.split('(');
    String stateSplit = state1[0];
    final response = await _helper.postWithHeader("api/post/hospital-n-resources/state-district/listings?state=$stateSplit&district=$district&page=$pageno",{},"Bearer "+token);
    return HospitalsListingModel.fromJson(response);
  }
}