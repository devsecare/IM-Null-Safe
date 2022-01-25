// ignore_for_file: prefer_is_empty

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/carttestModel/cartbox.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_products.dart';
import 'package:incredibleman/screens/CheckAddressScreen/check_address.dart';
import 'package:incredibleman/screens/FirstTimeAddressScreen/first_time_address_screen.dart';
import 'package:incredibleman/screens/LoginScreen/login_screen.dart';
import 'package:incredibleman/screens/WishListScreen/wish_list_screen.dart';
import 'package:incredibleman/screens/widgetHelper/order_container.dart';
import 'package:incredibleman/screens/widgetHelper/sample_container.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../main.dart';

class CartScreen extends StatefulWidget {
  final List<WooProduct>? products;
  final WooCustomer? user;
  final bool? login;
  const CartScreen({Key? key, this.products, this.user, this.login})
      : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final contro = Get.find<CartData>();
  List<WooProduct>? category;

  var total = 0;
  var bb = 0.obs;

  @override
  void initState() {
    super.initState();
    getData();
    getPopup();
  }

  getData() {
    contro.testData();
    contro.fav();
  }

  getLike() {
    contro.favList(widget.products!);
    contro.testData();
    for (var i = 0; i < widget.products!.length; i++) {
      contro.isSave(widget.products![i].id);
    }
  }

  getPopup() {
    if (double.parse(contro.testTotal.value) >= 700.0) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.defaultDialog(
          title: "Congratulations",
          content: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              LottieBuilder.asset(
                samplecong,
                repeat: false,
                height: 150,
                width: 600,
              ),
              const Center(
                child: Text("Now you can Add Sample products"),
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: const Text(
            "Shopping cart",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Obx(() => Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Badge(
                    badgeColor: tabColor,
                    padding: const EdgeInsets.all(5.0),
                    position: const BadgePosition(
                      bottom: 29.0,
                      start: 29.0,
                    ),
                    badgeContent: Center(
                      child: Text(
                        contro.favItme.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WishListScreen(
                                      products: widget.products,
                                      login: widget.login,
                                      user: widget.user,
                                      nav: true,
                                    )));
                      },
                    ),
                  ),
                )),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                double.parse(contro.testTotal.value) >= 700.0
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          // var check = await CartData.wooCommerce
                          //     .getProducts(category: "15");
                          // print(check.length);

                          showCupertinoModalBottomSheet(
                              context: context,
                              expand: true,
                              builder: (context) => Material(
                                    child: FutureBuilder(
                                        future:
                                            CartData.wooCommerce.getProducts(
                                          category: "15",
                                          status: "publish",
                                        ),
                                        builder: (context,
                                            AsyncSnapshot<List<WooProduct>>
                                                sample) {
                                          category = sample.data;
                                          if (sample.connectionState ==
                                              ConnectionState.waiting) {
                                            print("aaa thai che error ");
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                            // return const Center(
                                            //   child: Text("No Sample"),
                                            // );
                                          } else if (sample.data!.isNotEmpty) {
                                            // category = sample.data;

                                            return SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Text(
                                                    "Add Sample Prodcuts",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  ListView.builder(
                                                      itemCount:
                                                          category?.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        final cat =
                                                            category![index];
                                                        //  CartBox dd = contro.tcart[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              SampleContainer(
                                                            name: cat.name!,
                                                            url: cat.images![0]
                                                                    .src ??
                                                                "https://incredibleman-174dc.kxcdn.com/wp-content/uploads/2021/09/pomade.png",
                                                            add: () {
                                                              var x = contro
                                                                  .tcart
                                                                  ?.where((element) =>
                                                                      element
                                                                          .sample ==
                                                                      false)
                                                                  .toList();
                                                              if (double.parse(contro
                                                                          .testTotal
                                                                          .value) >=
                                                                      1200.0 &&
                                                                  x!.length <
                                                                      2) {
                                                                Hive.box(
                                                                        TestBox)
                                                                    .put(
                                                                        cat.id,
                                                                        CartBox(
                                                                          1,
                                                                          cat.id!,
                                                                          cat.name!,
                                                                          cat.price!,
                                                                          cat.images![0]
                                                                              .src!,
                                                                          false,
                                                                        ));
                                                                contro
                                                                    .testData();
                                                                getData();
                                                                print(
                                                                    "aa kyu che 1200");
                                                                // Get.snackbar(
                                                                //   "Sample Added",
                                                                //   "one Sample Added",
                                                                //   backgroundColor:
                                                                //       Colors
                                                                //           .black54,
                                                                //   colorText:
                                                                //       Colors
                                                                //           .white,
                                                                // );
                                                              } else if (double.parse(contro
                                                                          .testTotal
                                                                          .value) >=
                                                                      700.0 &&
                                                                  double.parse(contro
                                                                          .testTotal
                                                                          .value) <
                                                                      1200.0 &&
                                                                  x!.length ==
                                                                      0) {
                                                                Hive.box(
                                                                        TestBox)
                                                                    .put(
                                                                        cat.id,
                                                                        CartBox(
                                                                          1,
                                                                          cat.id!,
                                                                          cat.name!,
                                                                          cat.price!,
                                                                          cat.images![0]
                                                                              .src!,
                                                                          false,
                                                                        ));
                                                                contro
                                                                    .testData();
                                                                getData();
                                                                Get.snackbar(
                                                                  "Sample Added",
                                                                  "one Sample Added",
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black54,
                                                                  colorText:
                                                                      Colors
                                                                          .white,
                                                                );
                                                              } else {
                                                                Get.snackbar(
                                                                  "Sample Already Added",
                                                                  "No More Sample ",
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black54,
                                                                  colorText:
                                                                      Colors
                                                                          .white,
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                                child: Text("No Sample"));
                                          }
                                        }),
                                  ));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 17.0,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            minimumSize: Size(width / 1.1, 60)),
                        icon:
                            const Icon(CupertinoIcons.arrow_right_circle_fill),
                        label: const Text("Add Sample"),
                      )
                    : Container(),
                const SizedBox(
                  height: 5.0,
                ),
                contro.testTotal.value == "0"
                    ? ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 17.0,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            minimumSize: Size(width / 1.1, 60)),
                        icon:
                            const Icon(CupertinoIcons.arrow_right_circle_fill),
                        label: const Text("Add Product to cart"),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          widget.login! && widget.user!.billing!.address1 == ""
                              ? Get.to(() => FirstTimeAddress(
                                    user: widget.user,
                                  ))
                              : widget.login!
                                  // ? Get.to(() => SummaryScreen())
                                  ? Get.to(() => CheckAddress(
                                        products: contro.tcart,
                                        user: widget.user,
                                        price: contro.testTotal.toString(),
                                      ))
                                  : Get.to(() => const LoginScreen());
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 17.0,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            minimumSize: Size(width / 1.1, 60)),
                        icon:
                            const Icon(CupertinoIcons.arrow_right_circle_fill),
                        label: const Text("PLACE ORDER"),
                      ),
              ],
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetX<CartData>(
                  init: contro,
                  // initState: contro.fetchdata(widget.products),
                  builder: (data) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "${data.tcart!.length}  Items",
                            style: GoogleFonts.poppins(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Total: ${rupee + data.testTotal.string}",
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Obx(
                  () {
                    return contro.mainloding.value == true &&
                                contro.lodgin.value ||
                            contro.lodgin1.value
                        ? const SizedBox(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(
                            child: contro.tcart!.length <= 0
                                ? const Center(
                                    child: Text("No items Added Yet"),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      CartBox dd = contro.tcart![index];
                                      var ff = Hive.box(FavList)
                                          .containsKey(contro.tcart![index].id);

                                      return OrderContainer(
                                        sample: contro.tcart![index].sample,
                                        qun: dd.quntity.toString(),
                                        url: dd.urlImage,
                                        name: dd.name,
                                        price: dd.price,
                                        shortname: dd.name,
                                        wishList: () {
                                          contro
                                              .isSave(contro.tcart![index].id);
                                          bool bb = Hive.box(FavList)
                                              .containsKey(
                                                  contro.tcart![index].id);

                                          if (bb == true) {
                                            contro.favRemove(
                                                contro.tcart![index].id);
                                            getLike();

                                            contro.cartitme1();
                                          } else {
                                            contro.addFav(
                                                contro.tcart![index].id,
                                                contro.tcart![index].id);

                                            getLike();
                                            contro.cartitme1();
                                          }
                                        },
                                        minus: () {
                                          var vv = dd.quntity--;
                                          if (vv != 1) {
                                            vv--;
                                          }

                                          Hive.box(TestBox).put(
                                              dd.id,
                                              CartBox(
                                                vv,
                                                dd.id,
                                                dd.name,
                                                dd.price,
                                                dd.urlImage,
                                                true,
                                              ));
                                          contro.testData();
                                          contro.sampleDatacheck();
                                          getData();
                                          // getPopup();
                                        },
                                        inc: () {
                                          var vv = dd.quntity++;
                                          if (vv != 5) {
                                            vv++;
                                          }

                                          Hive.box(TestBox).put(
                                              dd.id,
                                              CartBox(
                                                vv,
                                                dd.id,
                                                dd.name,
                                                dd.price,
                                                dd.urlImage,
                                                true,
                                              ));

                                          contro.testData();
                                          // contro.sampleDatacheck();
                                          getData();
                                          // getPopup();
                                        },
                                        remove: () {
                                          contro
                                              .remove(contro.tcart![index].id);

                                          contro.testData();

                                          contro.cartitme1();
                                          contro.sampleDatacheck();
                                          getData();
                                        },
                                        ic: Icon(
                                          ff == true
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: ff == true
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      );
                                    },
                                    itemCount: contro.tcart!.length,
                                  ),
                          );
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
