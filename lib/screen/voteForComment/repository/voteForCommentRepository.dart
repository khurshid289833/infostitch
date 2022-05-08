import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/voteForComment/model/voteForCommentModel.dart';

class VoteForCommentRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<VoteForCommentModel> voteForCommentRepositoryFunction(body,token) async {
    final response = await _helper.postWithHeader("api/track/vote", body,"bearer "+ token);
    return VoteForCommentModel.fromJson(response);
  }
}