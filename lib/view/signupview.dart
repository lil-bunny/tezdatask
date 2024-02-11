import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertask/controller/authcontroller.dart';
import 'package:fluttertask/model.dart/usermode.dart';
import 'package:fluttertask/view/dashboard.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupView extends StatefulWidget {
  AuthController authController;
  SignupView({super.key, required this.authController});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  widget.authController.filepath.value == ''
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(
                              File(widget.authController.filepath.value)),
                          backgroundColor: Colors.grey,
                        ),
                  GestureDetector(
                    onTap: () {
                      widget.authController.uploadPic();
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color.fromARGB(255, 219, 221, 223),
                      child: Icon(Icons.edit),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 252, 249, 249),
                ),
                width: w / 2.5,
                child: TextFormField(
                  controller: widget.authController.userName,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.abc),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 252, 249, 249),
                ),
                width: w / 2.5,
                child: TextFormField(
                  controller: widget.authController.userEmail,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 252, 249, 249),
                ),
                width: w / 2.5,
                child: TextFormField(
                  controller: widget.authController.userPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.remove_red_eye_outlined),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ))),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(0)),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () async {
                  if (widget.authController.userName.text != '' &&
                      widget.authController.userEmail.text != '' &&
                      widget.authController.userPassword.text != '') {
                    var user = UserModel(
                      name: widget.authController.userName.text,
                      email: widget.authController.userEmail.text,
                      password: widget.authController.userPassword.text,
                      filePath: widget.authController.filepath.value,
                    );
                    //Storing to local storage
                    var sharedPref = await SharedPreferences.getInstance();
                    await sharedPref.setStringList(
                        '${widget.authController.userEmail.text}', [
                      '${widget.authController.userEmail.text}',
                      '${widget.authController.userPassword.text}',
                      '${widget.authController.filepath.value}',
                      '${widget.authController.userName.text}'
                    ]);
                    widget.authController.loggedIn.value = true;
                    widget.authController.createSession(
                        [user.email, user.password, user.filePath, user.name]);
                    print('${[
                      user.email,
                      user.password,
                      user.filePath,
                      user.name
                    ]}');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        width: w / 2,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        behavior: SnackBarBehavior.floating,
                        content: Container(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            tileColor: const Color.fromARGB(255, 255, 254, 254),
                            leading:
                                Icon(Icons.check_circle, color: Colors.green),
                            title: Text(
                                'Your account has been succesfully created',
                                style: TextStyle(color: Colors.black)),
                          ),
                        )));
                    Navigator.pop(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => UserDashboard(
                    //           authController: widget.authController),
                    //     ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        width: w / 2,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        behavior: SnackBarBehavior.floating,
                        content: Container(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            tileColor: const Color.fromARGB(255, 255, 254, 254),
                            leading: Icon(Icons.error, color: Colors.red),
                            title: Text('Enter necessary details',
                                style: TextStyle(color: Colors.black)),
                          ),
                        )));
                  }
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white),
                ))),
      ),
    );
  }
}
