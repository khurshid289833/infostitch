import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/notifyUser/model/notifyUserModel.dart';

class NotifyUserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<NotifyUserModel> notifyUserRepositoryFunction(body,String token) async {
    final response = await _helper.postWithHeader("api/notify/me", body,"Bearer " + token);
    return NotifyUserModel.fromJson(response);
  }
}
