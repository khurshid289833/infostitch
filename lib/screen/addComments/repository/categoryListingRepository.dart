import 'package:infostitch/screen/addComments/model/categoryListingModel.dart';
import 'package:infostitch/screen/api_base/api_base_helper.dart';

class CategoryListingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CategoryListingModel> categoryListingRepositoryFunction() async {
    final response = await _helper.get("api/category/listings");
    return CategoryListingModel.fromJson(response);
  }
}