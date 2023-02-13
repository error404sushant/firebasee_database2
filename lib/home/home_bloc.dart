import 'dart:async';
import 'dart:convert';

import 'package:firebase_data/service/http_service.dart';
import 'package:firebase_data/until/app_constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/erroe_responce.dart';
import '../model/home_responce.dart';
import '../service/home_service.dart';

enum HomeState { Loading, Success, Failed }

class HomeBloc {
  //region veriable
  BuildContext context;
  late HomeServices homeServices;
  late HomeResponse homeResponse;
  late HttpService httpService;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  //endregion
  //region Controller
  final homeCtl = StreamController<HomeState>.broadcast();

  //endregion

  //region |Constructor|
  HomeBloc(this.context);

  //endregion
  //region init
  void init() {
    homeServices = HomeServices();
    httpService = HttpService();
    getDataAndUploadFire();
  }

  //endregion

  //region get api data and upload to firebase
  void getDataAndUploadFire() async {
    //Loading
    homeCtl.sink.add(HomeState.Loading);
    //Map type variable
    Map<String, dynamic> response;
    //Api call and store map type data
    response = await httpService.getApiCall(AppConstants.baseUrl);
    //Add response to firebase
    await ref.set(response);
    //Get data from Firebase
    getDataFromFirebase();
  }
//endregion

  // region Get data from firebase
  void getDataFromFirebase() {
    ref.onValue.listen((DatabaseEvent event) {
      //Convert response to string
      print(event.snapshot.value);
      //Encode Object data to json
      var encoded = jsonEncode(event.snapshot.value);
      //Map type variable
      Map<String, dynamic> response;
      //Decode
      response = json.decode(encoded);
      //Pars data to model class
      homeResponse = HomeResponse.fromJson(response);
       print(homeResponse.data!.length);
      //Success
      homeCtl.sink.add(HomeState.Success);
    });
  }

// endregion

//region Open url
  Future<void> launchAppUrl({required Uri url}) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch $url');
    }
  }
//endregion


}
