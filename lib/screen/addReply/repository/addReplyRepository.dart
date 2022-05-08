import 'package:infostitch/screen/addReply/model/addReplyModel.dart';
import 'package:infostitch/screen/api_base/api_base_helper.dart';

class AddReplyRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AddReplyModel> addReplyRepositoryFunction(body,String token) async {
    final response = await _helper.postWithHeader("api/add/comment-reply", body,"Bearer " + token);
    return AddReplyModel.fromJson(response);
  }
}