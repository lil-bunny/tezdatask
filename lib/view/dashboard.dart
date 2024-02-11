import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertask/controller/authcontroller.dart';
import 'package:fluttertask/controller/controller.dart';
import 'package:fluttertask/model.dart/productmodel.dart';
import 'package:fluttertask/view/profileview.dart';
import 'package:get/get.dart';
import 'package:swipe_widget/swipe_widget.dart';

class UserDashboard extends StatefulWidget {
  AuthController authController;
  UserDashboard({super.key, required this.authController});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  var controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.height;

    Widget cardData(ProductData productData, index) {
      return SwipeWidget(
        angle: 0.5,
        onSwipe: () {
          print("hey");
        },
        onUpdate: (distance) {
          print("disance=${distance}");
        },
        child: GestureDetector(
          onTap: () {
            print("tap");
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => Container(
                  height: h * 0.9,
                  child: Scaffold(
                    appBar: AppBar(
                      actions: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                setState(() {});
                                controller.addToFavById(
                                    controller.productList[index].id);
                              },
                              icon: controller.productList[index].fav
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                    )),
                        ),
                      ],
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.5),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    body: Container(
                        height: h,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: h / 2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                productData.image)),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                      width: w * 0.15,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ButtonBar(
                                        children: [
                                          Text(
                                            controller
                                                .productList[index].rating.rate
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(Icons.star,
                                              color: Colors.amber, size: 18),
                                          Text(controller
                                              .productList[index].rating.count
                                              .toString())
                                        ],
                                      ),
                                    ),
                                  )
                                  // ElevatedButton.icon(
                                  //     onPressed: () {},
                                  //     icon: Icon(Icons.star),
                                  //     label: Text(controller
                                  //         .productList[index].rating.rate
                                  //         .toString()))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      productData.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    // Text(
                                    //   productData.category.name,
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w500,
                                    //       fontSize: 12),
                                    // ),
                                    Text(
                                      '\$' + productData.price.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      productData.description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        color: Colors.white),
                    bottomNavigationBar: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {},
                          child: Text(
                            'Buy now',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ),
            );
          },
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
                  width: w / 2.5,
                ),
                Positioned(
                  bottom: h * 0.02,
                  child: Container(
                    width: w / 3,
                    height: h * 0.12,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      // leading: CircleAvatar(),
                      // contentPadding: EdgeInsets.all(20),

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
                          // Container(
                          //   height: h * 0.05,
                          //   child: Text(
                          //     productData.description.substring(
                          //         0, (productData.description.length).toInt()),
                          //     overflow: TextOverflow.fade,
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
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
                              controller.addToFav(index);
                            },
                            icon: controller.productList[index].fav
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
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            // backgroundColor: Color.fromARGB(255, 253, 249, 249),
            // backgroundColor: Color.fromARGB(255, 17, 14, 43),
            toolbarHeight: kToolbarHeight * 1.5,
            bottom: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: kToolbarHeight * 0.8,
              title: StatefulBuilder(
                builder: (context, setState) => Container(
                  height: kToolbarHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.productList
                        .map((element) => element.category)
                        .toSet()
                        .length,
                    itemBuilder: (context, index) => InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        controller.setCategory(controller.productList
                            .map((element) => element.category)
                            .toSet()
                            .map((e) => e)
                            .toList()[index]);
                        setState(
                          () {},
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: h * 0.05,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.productList
                                    .map((element) => element.category)
                                    .toSet()
                                    .map((e) => e)
                                    .toList()[index],
                                style: TextStyle(
                                    color: controller.currentcat.value ==
                                            controller.productList
                                                .map((element) =>
                                                    element.category)
                                                .toSet()
                                                .map((e) => e)
                                                .toList()[index]
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: controller.currentcat.value ==
                                      controller.productList
                                          .map((element) => element.category)
                                          .toSet()
                                          .map((e) => e)
                                          .toList()[index]
                                  ? Colors.black
                                  : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyProfile(
                          controller: controller,
                          authController: widget.authController),
                    ));
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          FileImage(File(widget.authController.filepath.value)),
                    ),
                  ),
                ),
              )
            ],
          ),
          // backgroundColor:Colo
          //  Color.fromARGB(255, 17, 14, 43)
          //  ,

          // backgroundColor: Color.fromARGB(255, 253, 249, 249),
          body: Container(
            child: Center(
              child: controller.productList.length > 0
                  ? Stack(
                      children: List.generate(
                          controller.productList.length,
                          (index) =>
                              cardData(controller.productList[index], index)),
                    )
                  : CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
