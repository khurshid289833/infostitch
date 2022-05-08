import 'package:infostitch/screen/api_base/api_base_helper.dart';
import 'package:infostitch/screen/stateListing/model/stateListingModel.dart';

class StateListingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<StateListingModel> StateListingRepositoryFunction() async {
    final response = await _helper.get("api/getall/states");
    return StateListingModel.fromJson(response);
  }
}