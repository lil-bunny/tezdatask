import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model.dart/productmodel.dart';

class AuthController extends GetxController {
  var userEmail = TextEditingController();
  var userPassword = TextEditingController();
  var userName = TextEditingController();
  var filepath = ''.obs;
  var loggedIn = false.obs;
  void uploadPic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    filepath.value = result!.files.first.path!;
  }

  var editImage = ''.obs;
  void uploadEditImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    editImage.value = result!.files.first.path!;
  }

  Future<List<String>> validateLogin() async {
    var sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.getStringList(userEmail.text) == null) {
      //Wrong credentials

      return [];
    } else {
      if (sharedPref.getStringList(userEmail.text)![1] == userPassword.text)
        return sharedPref.getStringList(userEmail.text)!;
      else
        return [];
    }
  }

  void updateAccount(List<String> data) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setStringList('current_session', [
      data[0],
      data[1],
      data[2],
      data[3] ?? '',
    ]);
  }

  void createSession(List<String> data) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setStringList('current_session', [
      data[0],
      data[1],
      data[2],
      data[3] ?? '',
    ]);
    loggedIn.value = true;
  }

  void deleteSession() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('current_session');
    loggedIn.value = false;
  }

  void checkSession() async {
    var sharedPref = await SharedPreferences.getInstance();
    print("called shared ${sharedPref.getKeys()} ");
    if (sharedPref.getStringList('current_session') != null) {
      List<String> data = sharedPref.getStringList('current_session')!;
      userEmail.text = data[0];
      userPassword.text = data[1];
      filepath.value = data[2];
      userName.text = data[3];
      loggedIn.value = true;
    } else {
      loggedIn.value = false;
    }
  }

  void removePic() {
    filepath.value = '';
  }

  @override
  void onInit() {
    checkSession();
    super.onInit();
  }
}
