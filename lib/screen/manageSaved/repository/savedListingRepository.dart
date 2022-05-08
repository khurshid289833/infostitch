import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/manageSaved/model/savedListingModel.dart';

class SavedListingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SavedListingModel> savedListingRepositoryFunction(int pageNumber,String token) async {
    final response = await _helper.postWithHeader("api/hospital-n-resources/saved/listings?page=$pageNumber",{},"Bearer " + token);
    return SavedListingModel.fromJson(response);
  }
}