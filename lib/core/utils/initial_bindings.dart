import 'package:flutter/foundation.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/core/utils/firebase_utility.dart';
import 'package:grocery_app/data/apiClient/api_client.dart';
import 'package:firebase_core/firebase_core.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(PrefUtils());
    Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    await initFirebase();
  }

  // const firebaseConfig = {
  //   apiKey: "AIzaSyBe2BuCGdIDWMWBd7eLeq_mqfU6FmVL5MA",
  //   authDomain: "pingmexx.firebaseapp.com",
  //   databaseURL: "https://pingmexx-default-rtdb.firebaseio.com",
  //   projectId: "pingmexx",
  //   storageBucket: "pingmexx.firebasestorage.app",
  //   messagingSenderId: "798685713139",
  //   appId: "1:798685713139:web:a5fd7483073d3c1dca1d86",
  //   measurementId: "G-R1BY6CD4S0"
  // };const firebaseConfig = {
  //   apiKey: "AIzaSyBe2BuCGdIDWMWBd7eLeq_mqfU6FmVL5MA",
  //   authDomain: "pingmexx.firebaseapp.com",
  //   databaseURL: "https://pingmexx-default-rtdb.firebaseio.com",
  //   projectId: "pingmexx",
  //   storageBucket: "pingmexx.firebasestorage.app",
  //   messagingSenderId: "798685713139",
  //   appId: "1:798685713139:web:a5fd7483073d3c1dca1d86",
  //   measurementId: "G-R1BY6CD4S0"
  // };
}
