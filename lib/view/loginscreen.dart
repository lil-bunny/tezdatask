import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertask/controller/authcontroller.dart';
import 'package:fluttertask/view/signupview.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthView extends StatefulWidget {
  AuthController authController;
  AuthView({super.key, required this.authController});

  @override
  State<AuthView> createState() => AuthViewState();
}

class AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h / 2,
                  width: w / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              'https://agentestudio.com/uploads/post/image/187/main_Article_Covers_NFT.png'))),
                ),
                SizedBox(
                  height: 10,
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
                  height: 10,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: w / 2.5,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () async {
                            //load data from shared pref

                            if (widget.authController.userEmail.text == '' ||
                                widget.authController.userPassword.text == '') {
                              return;
                            } else {
                              print("great");
                              var loginData =
                                  await widget.authController.validateLogin();

                              if (loginData.length != 0) {
                                print("logindata=${loginData}");
                                //create a session and for creating i must load the existing data
                                //load data->create session

                                widget.authController.createSession(loginData);
                              } else {
                                print(
                                    "wrong cred ${widget.authController.userEmail.text} ${widget.authController.userPassword.text}");
                                // print('${}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        width: w,
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        behavior: SnackBarBehavior.floating,
                                        content: Container(
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            tileColor: const Color.fromARGB(
                                                255, 255, 254, 254),
                                            leading: Icon(Icons.error,
                                                color: Colors.red),
                                            title: Text('Wrong credentials',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        )));
                              }
                              ;
                              widget.authController.checkSession();
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ))),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupView(
                                    authController: widget.authController),
                              ));
                        },
                        child: Text(
                          'Signup',
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
