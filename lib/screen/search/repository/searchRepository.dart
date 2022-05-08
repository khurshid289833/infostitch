import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/search/model/searchModel.dart';

class SearchRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SearchModel> searchRepositoryFunctionGet(String search,int page) async {
    final response = await _helper.get("api/hospital-n-resources/name/listings?search=$search&page=$page");
    return SearchModel.fromJson(response);
  }
  Future<SearchModel> searchRepositoryFunctionPost(String search,int page,String token) async {
    final response = await _helper.postWithHeader("api/post/hospital-n-resources/name/listings?search=$search&page=$page",{},"Bearer " + token);
    return SearchModel.fromJson(response);
  }
}