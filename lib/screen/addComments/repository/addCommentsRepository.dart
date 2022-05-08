import 'package:infostitch/screen/addComments/model/addCommentsModel.dart';
import 'package:infostitch/screen/api_base/api_base_helper.dart';

class AddCommentsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AddCommentsModel> addCommentsRepositoryFunction(body,String token) async {
    final response = await _helper.postWithHeader("api/add/comment", body,"Bearer " + token);
    return AddCommentsModel.fromJson(response);
  }
}