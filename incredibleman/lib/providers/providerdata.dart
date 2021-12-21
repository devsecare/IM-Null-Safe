// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/main.dart';
import 'package:incredibleman/providers/reviews/reviews_model.dart';
import 'package:incredibleman/providers/woocommerceModels/wooMain/woo_main.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_products.dart';

import 'BannerAdModel/banner_ad.dart';
import 'carttestModel/cartbox.dart';
import 'couponModel/coupon_model.dart';
import 'shippingmodel/shipping_model.dart';

class CartData extends GetxController {
  List<WooProduct> newProducts = List<WooProduct>.empty(growable: true).obs;
  var lodgin = true.obs;
  var mainloding = true.obs;
  var cr = true.obs;
  static late WooCommerce wooCommerce = WooCommerce(
      baseUrl: baseUrl, consumerKey: ck, consumerSecret: cs, isDebug: false);
  @override
  void onInit() {
    getxfetchData();
    super.onInit();
  }

  getxfetchData() async {
    try {
      mainloding(true);

      var gx = await wooCommerce.getProducts(
        perPage: 50,
        minPrice: "1",
      );

      newProducts.assignAll(gx);

      update();
      mainloding(false);
    } catch (e) {
      Get.defaultDialog(
          title: "Opps... ",
          content: const Text("something Went Wrong Please Try Again"));
    }
  }

  List<WooProduct> favlist1 = List<WooProduct>.empty(growable: true).obs;
  List<WooProduct> cartdata2 = List<WooProduct>.empty(growable: true).obs;

  static late bool loginornot;

  var favTotal = 0.obs;
  var cartitem = 0.obs;
  var favItme = 0.obs;
  var count = 1.obs;
  var testTotal = "0".obs;

  var isfav = false.obs;
//////////////////////////////////////////////////
  var total = 0.0.obs;
  var lodgin1 = true.obs;

  List<CartBox>? tcart = List<CartBox>.empty(growable: true).obs;

  fav() {
    var dd = Hive.box(FavList).length;
    favItme(dd);
  }

  Future<List<Reviews>> reviews({required String id}) async {
    try {
      var response = await http.get(Uri.parse(
          "https://www.incredibleman.in/wp-json/wc/v3/products/reviews?consumer_key=$ck&consumer_secret=$cs&product=$id"));

      final reviews = reviewsFromJson(response.body);

      return reviews;
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      rethrow;
    }
  }

  static Future<List<CouponModel>> couponCheck({required String code}) async {
    try {
      var response = await http.get(
        Uri.parse(
            "https://www.incredibleman.in/wp-json/wc/v3/coupons?consumer_secret=$cs&consumer_key=$ck&code=$code"),
      );

      final coup = couponModelFromJson(response.body);

      return coup;
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      rethrow;
    }
  }

  static Future<BannerAd> bannerAD() async {
    try {
      var response = await http.get(
          Uri.parse("https://www.incredibleman.in/wp-json/banner/v1/banner"));

      final bannerAd = bannerAdFromJson(response.body);

      return bannerAd;
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      rethrow;
    }
  }

  static Future<List<ShippingModel>> shippingDatat() async {
    try {
      var response = await http.get(Uri.parse(
          "https://www.incredibleman.in/wp-json/wc/v3/shipping/zones/1/methods?consumer_secret=cs_e0d2efcba59453a6883a91b0bbf241d699898151&consumer_key=ck_e9df4b7d747d2ccc30946837db4d3ef80b215535"));

      final shippingModel = shippingModelFromJson(response.body);
      return shippingModel;
    } on Exception {
      rethrow;
    }
  }

  favList(List<WooProduct> dd) {
    lodgin(true);
    mainloding(true);
    var favdata = Hive.box(FavList).values.toList().obs;

    favlist1 = dd.where((element) => favdata.contains(element.id)).toList().obs;

    favTotal(favlist1.length);
    fav();
    lodgin(false);
    mainloding(false);
  }

  void isSave(key) {
    lodgin(true);
    mainloding(true);
    if (Hive.box(FavList).containsKey(key).obs.value) {
      isfav(true).obs;
    } else {
      isfav(false).obs;
    }

    lodgin(false);
    mainloding(false);
  }

  void favRemove(product) {
    Hive.box(FavList).delete(product).obs;
    fav();
  }

  void addFav(key, value) {
    Hive.box(FavList).put(key, value).obs;
    fav();
  }

  void addTest(key, value) {
    Hive.box(TestBox).put(key, value);
    cartitme1();
  }

  static Future<bool> userlogin() async {
    loginornot = await wooCommerce.isCustomerLoggedIn();

    return loginornot;
  }

// /////////////////////////////////////////////////////////////////
//   ///

  cartitme1() {
    cr(true);
    var dd = Hive.box(TestBox).length;
    cartitem(dd);
    cr(false);
  }

  void testData() {
    lodgin1(true);
    tcart = Hive.box(TestBox).values.toList().cast<CartBox>().obs;
    var hehe = tcart!
        .map((element) => double.parse(element.price) * element.quntity)
        .fold(0, (p, element) => double.parse(p.toString()) + element);

    testTotal(hehe.toString());

    lodgin1(false);
  }

  void sampleDatacheck() {
    lodgin1(true);
    var del = tcart?.where((element) => element.sample == false).toList();

    if (del!.isNotEmpty) {
      if (double.parse(testTotal.value) <= 700.0 && del.length != null) {
        if (del != null) {
          for (var i = 0; i < del.length; i++) {
            remove(del[i].id);
            cartitme1();
          }
        }
      } else if (double.parse(testTotal.value) <= 1200.0 &&
          del.length >= 2 &&
          double.parse(testTotal.value) >= 700.0) {
        if (del != null) {
          remove(del[0].id);
          cartitme1();
        }
      }
    }

    lodgin1(false);
  }

  remove(product) {
    Hive.box(TestBox).delete(product).obs;
    cartitem(tcart?.length);
    cartitme1();
  }

  cartAdd(key, value) {
    Hive.box(TestBox).put(key, value).obs;
    cartitem(tcart?.length);
    cartitme1();
  }
}
