import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/notification/model/notificationModel.dart';

class NotificationRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  Future<NotificationModel> notificationRepositoryFunction(String token) async {
    final response = await _apiBaseHelper.getWithHeader("api/notification/listings", "Bearer "+token);
    return NotificationModel.fromJson(response);
  }
}