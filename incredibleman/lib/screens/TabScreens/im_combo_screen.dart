import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_products.dart';
import 'package:incredibleman/screens/ProductDetailScreen/product_detail_screen.dart';
import 'package:incredibleman/screens/widgetHelper/shimmer_screen.dart';
import 'package:incredibleman/screens/widgetHelper/shop_container.dart';

import '../../main.dart';

class ImcomboScreen extends StatefulWidget {
  final String? id, name;
  final List<WooProduct>? product;
  final WooCustomer? user;
  final bool? login;
  const ImcomboScreen(
      {Key? key, this.id, this.name, this.product, this.user, this.login})
      : super(key: key);

  @override
  _ImcomboScreenState createState() => _ImcomboScreenState();
}

class _ImcomboScreenState extends State<ImcomboScreen> {
  final cro = Get.find<CartData>();
  //////////////////////////////
  List<WooProduct> cat = [];
  bool _loading = true;
  @override
  void initState() {
    getByCategory();
    super.initState();
  }

  getByCategory() async {
    //neww check
    cat = await CartData.wooCommerce.getProducts(category: "73", minPrice: "1");

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _loading
          ? const Center(
              child: ShimmerLoading(),
            )
          // ignore: prefer_is_empty
          : cat.length <= 0
              ? const Center(child: Text("No Items "))
              : GetX<CartData>(
                  // init: CartData(),
                  builder: (data) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      // ignore: prefer_is_empty
                      child: cat.length <= 0
                          ? const Center(child: Text("No Items "))
                          : data.mainloding.value == true && data.lodgin.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    crossAxisCount: 2,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            1.05),
                                  ),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: cat.length,
                                  itemBuilder: (context, index) {
                                    final products = cat[index];
                                    return ShopContainer(
                                      sale: products.onSale!,
                                      tag: "tag-${products.name}",
                                      like: () {
                                        //newwww

                                        data.isSave(cat[index].id);
                                        bool dd = Hive.box(FavList)
                                            .containsKey(cat[index].id);

                                        if (dd == true) {
                                          data.favRemove(products.id);
                                        } else {
                                          data.addFav(
                                              cat[index].id, cat[index].id);
                                        }
                                        data.favList(widget.product!);
                                      },
                                      details: () {
                                        //newww
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                              data: products,
                                              user: widget.user,
                                              products: widget.product!,
                                              login: widget.login!,
                                            ),
                                          ),
                                        );
                                      },
                                      image: products.images![0].src!,
                                      dec: products.name,
                                      price: products.price!,
                                      dec2: products.name,
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 20.0,
                                        color: Hive.box(FavList)
                                                .containsKey(products.id)
                                            ? Colors.red
                                            : bgcontainer,
                                      ),
                                    );
                                  },
                                ),
                    );
                  },
                ),
    );
  }
}
