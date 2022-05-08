import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/feed/model/hospitalsListingModel.dart';

class HospitalListingByPincodeCityRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<HospitalsListingModel> hospitalListingByPincodeCityRepositoryFunctionGet(String pincode,String city, int pageno) async {
    final response = await _helper.get("api/hospital-n-resources/pincode-city/listings?pincode=$pincode&city=$city&page=$pageno");
    return HospitalsListingModel.fromJson(response);
  }
  Future<HospitalsListingModel> hospitalListingByPincodeCityRepositoryFunctionPost(String pincode,String city, int pageno,String token) async {
    final response = await _helper.postWithHeader("api/post/hospital-n-resources/pincode-city/listings?pincode=$pincode&city=$city&page=$pageno",{},"Bearer "+token);
    return HospitalsListingModel.fromJson(response);
  }
}