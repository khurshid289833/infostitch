import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/loginPage/model/loginApiCallPageModel.dart';

class LoginApiCallPageRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<LoginApiCallPageModel> LoginApiCallPageRepositoryFunction(body) async {
    final response = await _helper.post("api/user/login", body);
    return LoginApiCallPageModel.fromJson(response);
  }
}
