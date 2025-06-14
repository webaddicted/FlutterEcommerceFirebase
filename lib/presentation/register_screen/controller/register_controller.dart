import '/core/app_export.dart';
import 'package:grocery_app/data/apiClient/api_client.dart';
import 'package:grocery_app/presentation/register_screen/models/register_model.dart';
import 'package:grocery_app/data/models/items/post_items_resp.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  TextEditingController name = TextEditingController(text: "DeepakSharma");

  TextEditingController email = TextEditingController(text: "deepak@yopmail.com");

  TextEditingController password = TextEditingController(text: "123456789");

  TextEditingController cpassword = TextEditingController(text: "123456789");

  TextEditingController contact = TextEditingController(text: "1234567890");

  Rx<RegisterModel> registerModelObj = RegisterModel().obs;

  PostItemsResp postItemsResp = PostItemsResp();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    name.dispose();
    email.dispose();
    password.dispose();
    cpassword.dispose();
    contact.dispose();
  }

  void callCreateUsers(Map req,
      {VoidCallback? successCall, VoidCallback? errCall}) async {
    return Get.find<ApiClient>().createUser(
        onSuccess: (resp) {
          onCreateUsersSuccess(resp);
          if (successCall != null) {
            successCall();
          }
        },
        onError: (err) {
          onCreateUsersError(err);
          if (errCall != null) {
            errCall();
          }
        },
        requestData: req);
  }

  void onCreateUsersSuccess(var response) {
    postItemsResp = PostItemsResp.fromJson(response);
  }

  void onCreateUsersError(var err) {
    Get.rawSnackbar(
        messageText: Text('$err', style: TextStyle(color: Colors.white)));
  }
}
