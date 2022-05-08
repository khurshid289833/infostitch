import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/commentsList/model/commentsListModel.dart';

class CommentsListRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CommentsListModel> commentsListRepositoryFunction(int hospitalId) async {
    final response = await _helper.get("api/comments/hospital/$hospitalId");
    return CommentsListModel.fromJson(response);
  }
}