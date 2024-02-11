import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model.dart/productmodel.dart';

class UserController extends GetxController {
  var productList = <ProductData>[].obs;
  var baseUrl = 'https://fakestoreapi.com';
  var currentcat = ''.obs;
  void setCategory(catname) {
    if (currentcat.value == catname)
      currentcat.value = '';
    else
      currentcat.value = catname;
    currentcat.refresh();

    print(currentcat);
  }

  var savedItems = <ProductData>[].obs;
  loadSavedData() {
    savedItems.value =
        productList.value.where((element) => element.fav).toList();
  }

  void fetchProducts() async {
    var dio = Dio();
    var url = 'https://fakestoreapi.com/products';
    await dio.get(url).then((value) {
      List<dynamic> data = value.data;
      print(data);
      productList.value = data.map((e) => ProductData.fromJson(e)).toList();
    });

    print("data=${productList}");
  }

  void removeFav(index) {
    int i;
    for (i = 0; i < productList.value.length; i++) {
      if (productList[index].id == savedItems[index].id) {
        productList[index].fav = false;
        productList.refresh();
      }
    }
    savedItems.removeAt(index);
  }

  void addToFavById(id) {
    for (int i = 0; i < productList.length; i++) {
      if (id == productList[i].id) {
        productList[i].fav = !productList[i].fav;
        if (productList[i].fav) {
          savedItems.add(productList[i]);
        } else {
          savedItems.removeWhere((element) => element.id == id);
        }
        productList.refresh();
        savedItems.refresh();
        break;
      }
    }
  }

  void addToFav(index) {
    productList[index].fav = !productList[index].fav;
    productList.refresh();
    if (productList[index].fav) {
      savedItems.addIf(
          !savedItems.contains(productList[index]), savedItems[index]);
    } else {
      savedItems.removeWhere((element) => element.id == productList[index].id);
    }
  }

  @override
  void onInit() {
    fetchProducts();
  }
}
