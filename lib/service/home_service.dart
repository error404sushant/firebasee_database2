
import 'package:firebase_data/until/app_constant.dart';

import '../model/home_responce.dart';
import 'http_service.dart';

class HomeServices {
  // region Common Variables
  late HttpService httpService;

  // endregion


  // region | Constructor |
  HomeServices() {
    httpService = HttpService();
  }

// endregion

  // region update BuildingDetailsResponse
  Future<HomeResponse> getData() async {
    // region get body
   // var body = {"data": '{"system_id": "$systemId", "userid": "$userId" }'};

    // endregion
    Map<String, dynamic> response;

    //#region Region - Execute Request
    response = await httpService.getApiCall( AppConstants.baseUrl);
    print(response);
    // return response;
    return HomeResponse.fromJson(response);
  }

// endregion

}
