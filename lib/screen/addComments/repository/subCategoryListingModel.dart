import 'package:infostitch/screen/addComments/model/subCategoryListingModel.dart';
import 'package:infostitch/screen/api_base/api_base_helper.dart';

class SubCategoryListingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SubCategoryListingModel> subCategoryListingRepositoryFunction(int catId) async {
    final response = await _helper.get("api/subcategory/listings?category_id=$catId");
    return SubCategoryListingModel.fromJson(response);
  }
}