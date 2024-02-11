import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertask/controller/authcontroller.dart';
import 'package:fluttertask/controller/controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model.dart/productmodel.dart';
import '../model.dart/usermode.dart';

class MyProfile extends StatefulWidget {
  UserController controller;
  AuthController authController;
  MyProfile(
      {super.key, required this.controller, required this.authController});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    widget.controller.loadSavedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    Widget cardData(ProductData productData, index) {
      return GestureDetector(
        onTap: () {},
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: h * 0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: CachedNetworkImageProvider(productData.image)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                width: w,
              ),
              Positioned(
                bottom: h * 0.02,
                child: Container(
                  width: w,
                  height: h * 0.12,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    title: Container(
                      height: h * 0.05,
                      child: Text(
                        productData.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    isThreeLine: true,
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('\$' + productData.price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                    dense: true,
                    trailing: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      child: IconButton(
                          onPressed: () {
                            widget.controller.addToFavById(
                                widget.controller.savedItems[index].id);
                          },
                          icon: widget.controller.savedItems[index].fav
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          FileImage(File(widget.authController.filepath.value)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.authController.userName.text}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: w,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.authController.editImage.value =
                                widget.authController.filepath.value;
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                showDragHandle: true,
                                builder: (context) {
                                  var editEmail = TextEditingController();
                                  var editName = TextEditingController();
                                  var editPass = TextEditingController();
                                  editEmail.text =
                                      widget.authController.userEmail.text;
                                  editName.text =
                                      widget.authController.userName.text;
                                  editPass.text =
                                      widget.authController.userPassword.text;

                                  return Obx(
                                    () => Scaffold(
                                      appBar:
                                          AppBar(title: Text('Edit Profile')),
                                      body: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                widget.authController.editImage
                                                            .value ==
                                                        ''
                                                    ? CircleAvatar(
                                                        radius: 50,
                                                        backgroundColor:
                                                            Colors.grey,
                                                      )
                                                    : CircleAvatar(
                                                        radius: 50,
                                                        backgroundImage:
                                                            FileImage(File(widget
                                                                .authController
                                                                .editImage
                                                                .value)),
                                                        backgroundColor:
                                                            Colors.grey,
                                                      ),
                                                GestureDetector(
                                                  onTap: () {
                                                    widget.authController
                                                        .uploadEditImage();
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 219, 221, 223),
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromARGB(
                                                    255, 252, 249, 249),
                                              ),
                                              width: w / 1.5,
                                              child: TextFormField(
                                                controller: widget
                                                    .authController.userName,
                                                decoration: InputDecoration(
                                                    hintText: 'Name',
                                                    prefixIcon: Icon(Icons.abc),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromARGB(
                                                    255, 252, 249, 249),
                                              ),
                                              width: w / 1.5,
                                              child: TextFormField(
                                                controller: widget
                                                    .authController.userEmail,
                                                decoration: InputDecoration(
                                                    hintText: 'Email',
                                                    prefixIcon:
                                                        Icon(Icons.email),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color.fromARGB(
                                                    255, 252, 249, 249),
                                              ),
                                              width: w / 1.5,
                                              child: TextFormField(
                                                controller: widget
                                                    .authController
                                                    .userPassword,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    hintText: 'Password',
                                                    prefixIcon: Icon(Icons
                                                        .remove_red_eye_outlined),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
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
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black)),
                                              onPressed: () async {
                                                if (widget.authController
                                                            .userName.text !=
                                                        '' &&
                                                    widget.authController
                                                            .userEmail.text !=
                                                        '' &&
                                                    widget
                                                            .authController
                                                            .userPassword
                                                            .text !=
                                                        '') {
                                                  widget.authController.filepath
                                                          .value =
                                                      widget.authController
                                                          .editImage.value;
                                                  var user = UserModel(
                                                    name: widget.authController
                                                        .userName.text,
                                                    email: widget.authController
                                                        .userEmail.text,
                                                    password: widget
                                                        .authController
                                                        .userPassword
                                                        .text,
                                                    filePath: widget
                                                        .authController
                                                        .filepath
                                                        .value,
                                                  );
                                                  //Storing to local storage
                                                  var sharedPref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await sharedPref.setStringList(
                                                      '${widget.authController.userEmail.text}',
                                                      [
                                                        '${widget.authController.userEmail.text}',
                                                        '${widget.authController.userPassword.text}',
                                                        '${widget.authController.filepath.value}',
                                                        '${widget.authController.userName.text}'
                                                      ]);
                                                  widget.authController.loggedIn
                                                      .value = true;
                                                  widget.authController
                                                      .updateAccount([
                                                    user.email,
                                                    user.password,
                                                    user.filePath,
                                                    user.name
                                                  ]);
                                                  print('${[
                                                    user.email,
                                                    user.password,
                                                    user.filePath,
                                                    user.name
                                                  ]}');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          width: w,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: Container(
                                                            child: ListTile(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              tileColor: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  255,
                                                                  254,
                                                                  254),
                                                              leading: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .green),
                                                              title: Text(
                                                                  'Your account details has been succesfully updated',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black)),
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
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          width: w / 2,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: Container(
                                                            child: ListTile(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              tileColor: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  255,
                                                                  254,
                                                                  254),
                                                              leading: Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .red),
                                                              title: Text(
                                                                  'Enter necessary details',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black)),
                                                            ),
                                                          )));
                                                }
                                              },
                                              child: Text(
                                                'Update Account',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))),
                                    ),
                                  );
                                });
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          child: Text(
                            'Edit profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: w,
                        child: ElevatedButton(
                          onPressed: () async {
                            widget.authController.deleteSession();
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    widget.controller.savedItems.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.controller.savedItems.length,
                            itemBuilder: (context, index) => cardData(
                                widget.controller.savedItems[index], index),
                          )
                        : Container(
                            height: h / 2,
                            width: w,
                            child: Center(
                              child: Text('No saved items'),
                            ),
                          )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
