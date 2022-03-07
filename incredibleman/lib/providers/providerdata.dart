// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/main.dart';
import 'package:incredibleman/providers/reviews/reviews_model.dart';
import 'package:incredibleman/providers/woocommerceModels/wooMain/woo_main.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_create_order.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_products.dart';

import 'BannerAdModel/banner_ad.dart';
import 'carttestModel/cartbox.dart';
import 'couponModel/coupon_model.dart';
import 'shippingmodel/shipping_model.dart';

class CartData extends GetxController {
  //This are observer variable using GetX state Management
  List<WooProduct> newProducts = List<WooProduct>.empty(growable: true).obs;
  var lodgin = true.obs;
  var mainloding = true.obs;
  var cr = true.obs;

  //This is configation for wooCommerce baseUrl and keys
  static late WooCommerce wooCommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: ck,
    consumerSecret: cs,
    isDebug: true,
  );
  @override
  void onInit() {
    getxfetchData();
    super.onInit();
  }

// this function used for fatching product from api for first time when app open
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

  var loginornot = false.obs;

  var reviewloading = false.obs;

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

//this function is used for to save into favlist
  fav() {
    var dd = Hive.box(FavList).length;
    favItme(dd);
  }

// this function is used for fatching reviews for products
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

// this function is used for fatching coupons from woocommmerce api
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

// this function is  used for fatching banner image and id from custome api
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

// this function is used for fatching shippingmathod from wooCommerce api
  static Future<List<ShippingModel>> shippingDatat({required int id}) async {
    try {
      var response = await http.get(Uri.parse(
          "https://www.incredibleman.in/wp-json/wc/v3/shipping/zones/$id/methods?consumer_secret=cs_e0d2efcba59453a6883a91b0bbf241d699898151&consumer_key=ck_e9df4b7d747d2ccc30946837db4d3ef80b215535"));

      final shippingModel = shippingModelFromJson(response.body);
      return shippingModel;
    } on Exception {
      rethrow;
    }
  }

// this function is used to post review using api
  void createReview({
    int? id,
    String? review,
    String? reviewer,
    String? reviewerEmail,
    int? rating,
  }) async {
    var data = {
      'product_id': id,
      'review': review,
      'reviewer': reviewer,
      'reviewer_email': reviewerEmail,
      'rating': rating,
    };
    var jsone = json.encode(data);
    reviewloading(true);

    await http.post(
        Uri.parse(
            "https://www.incredibleman.in/wp-json/wc/v3/products/reviews?consumer_key=ck_e9df4b7d747d2ccc30946837db4d3ef80b215535&consumer_secret=cs_e0d2efcba59453a6883a91b0bbf241d699898151"),
        body: jsone,
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));

    reviewloading(false);
  }

// this function is used for fatching orders list by userid from woocommmerce api
  static Future<List<WooOrder>> getAllOrder({int? userid}) async {
    late List<WooOrder> order = [];

    if (userid == null) {
      return order;
    } else {
      try {
        var response = await http.get(Uri.parse(
            'https://www.incredibleman.in/wp-json/wc/v3/orders?consumer_key=$ck&consumer_secret=$cs&customer=$userid'));

        List<dynamic> data = json.decode(response.body);

        for (var o in data) {
          order.add(
            WooOrder(
              id: o['id'],
              status: o['status'],
              parentId: o['parentId'],
              number: o['number'],
              total: o['total'],
              lineItems: List<LineItems>.from(
                  o["line_items"].map((x) => LineItems.fromJson(x))).toList(),
              totalTax: o['total_tax'],
              customerId: o['customer_id'],
              cartTax: o['cart_tax'],
              shippingTotal: o['shipping_total'],
              transactionId: o['transaction_id'],
              taxLines: List<TaxLines>.from(
                  o['tax_lines'].map((x) => TaxLines.fromJson(x))).toList(),
              shippingLines: List<ShippingLines>.from(
                      o['shipping_lines'].map((x) => ShippingLines.fromJson(x)))
                  .toList(),
              // couponLines: o['coupon_lines'],
            ),
          );
        }
        // print(order[0].lineItems!.length);

        return order;
      } on Exception {
        rethrow;
      }
    }
  }

// this function is used for fatching list of favlist from database (Hive Database(Nosql))
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

// this function will check issave on favlist or not
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

// this function will remove a product  from fav list from database
  void favRemove(product) {
    Hive.box(FavList).delete(product).obs;
    fav();
  }

// this function will add product to fav list to the Database
  void addFav(key, value) {
    Hive.box(FavList).put(key, value).obs;
    fav();
  }

  void addTest(key, value) {
    Hive.box(TestBox).put(key, value);
    cartitme1();
  }

// this function will check user is login or not from woocommerce api
  Future<bool> userlogin() async {
    var loginornot1 = await wooCommerce.isCustomerLoggedIn();
    loginornot(loginornot1);
    return loginornot1;
  }

// /////////////////////////////////////////////////////////////////
//   ///

// this function will count the cart products
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

  /// this function will check for sample product and all condictions
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

// this function will remove the products from sample list
  remove(product) {
    Hive.box(TestBox).delete(product).obs;
    cartitem(tcart?.length);
    cartitme1();
  }

// this function will add products into cart database
  cartAdd(key, value) {
    Hive.box(TestBox).put(key, value).obs;
    cartitem(tcart?.length);
    cartitme1();
  }
}
