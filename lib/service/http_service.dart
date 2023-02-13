import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../model/erroe_responce.dart';
import 'package:http/http.dart' as http;

class HttpService{

  // region Get Api Call
  Future<Map<String, dynamic>> getApiCall(String apiUrl) async {
    Map<String, dynamic> jsonResponse;

    // http header
    var header = {"content-type": "application/json"};
    // //  Request Body
    // var body = json.encode(param);
    //  parsed Url
    var url = Uri.parse(apiUrl);
    print(url);
    //  Timeout duration
    var duration = const Duration(seconds:20);

    try {
      //  Execute Http Post
      var response = await http.get(url, headers: header).timeout(duration);

     // print(response.body.toString());

      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      // Region - Handle Http 400
      if (response.statusCode == 400) {
        throw ApiErrorResponseMessage.fromJson(jsonResponse);
      }
      // endregion

      //  //region - Handle None Http 200
      //  if (response.statusCode != 200) {
      //    throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
      //
      //  }
      // // endregion

      //#region Region - Handle Http 200 api error
      // var isStatusOk = jsonResponse["status"] == "OK";
      // if (!isStatusOk) {
      //   throw ApiErrorResponseMessage.fromJson(json.decode(response.body));
      // }
      // endregion

      // handle socket exception
    } on SocketException catch (exception) {
      throw ApiErrorResponseMessage(errorMessage: "No Internet Connection.", status: "No Internet");
    } on TimeoutException catch (exception) {
      throw ApiErrorResponseMessage(errorMessage: "Time out please try again.", status: "Timeout");
    }

    return jsonResponse;
  }
// endregion
}