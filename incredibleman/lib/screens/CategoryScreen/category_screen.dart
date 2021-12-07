import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_products.dart';
import 'package:incredibleman/screens/CartScreen/cart_screen.dart';
import 'package:incredibleman/screens/ProductDetailScreen/product_detail_screen.dart';
import 'package:incredibleman/screens/widgetHelper/searchbar.dart';
import 'package:incredibleman/screens/widgetHelper/shimmer_screen.dart';
import 'package:incredibleman/screens/widgetHelper/shop_container.dart';

import '../../main.dart';

class CategoryScreen extends StatefulWidget {
  final String id, name;
  final List<WooProduct>? product;
  final WooCustomer? user;
  final bool login;

  const CategoryScreen(
      {Key? key,
      required this.id,
      required this.name,
      this.product,
      this.user,
      required this.login})
      : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final cro = Get.find<CartData>();
  //////////////////////////////
  List<WooProduct> cat = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getByCategory();
  }

  getByCategory() async {
    cat = await CartData.wooCommerce
        .getProducts(category: widget.id, minPrice: "1");

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.name} products"),
              const SizedBox(
                height: 5,
              ),
              _loading
                  ? const SizedBox()
                  : Text(
                      "${cat.length.toString()} Items",
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.white38,
                      ),
                    ),
            ],
          ),
          // title: Text(
          //   widget.name,
          //   // style: TextStyle(color: Colors.black),
          // ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: IconButton(
                icon: Image.asset(
                  search,
                  scale: 2,
                ),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: ItemSearch(
                        widget.product,
                        widget.user,
                        widget.login,
                      ));
                  // Navigator.push(context,
                  //     CupertinoPageRoute(builder: (context) => CartScreen()));
                },
              ),
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Badge(
                    badgeColor: tabColor,
                    padding: const EdgeInsets.all(5.0),
                    position: const BadgePosition(
                      bottom: 30.0,
                      start: 25.0,
                    ),
                    badgeContent: Center(
                      child: Text(
                        cro.cartitem.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => CartScreen(
                                      products: widget.product,
                                      login: widget.login,
                                      user: widget.user,
                                    )));
                      },
                    ),
                  ),
                )),
            PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 0:
                    cat.sort(
                      (a, b) => double.parse(a.price!).compareTo(
                        double.parse(b.price!),
                      ),
                    );
                    setState(() {});

                    break;
                  case 1:
                    cat.sort(
                      (a, b) => double.parse(b.price!).compareTo(
                        double.parse(a.price!),
                      ),
                    );
                    setState(() {});

                    break;
                  default:
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.align_vertical_top,
                        color: Colors.black,
                      ),
                      Text(" Low - High "),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.align_vertical_bottom,
                        color: Colors.black,
                      ),
                      Text(" High - Low "),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Container(
          child: _loading
              ? const Center(
                  child: ShimmerLoading(),
                )
              : cat.isEmpty
                  ? const Center(child: Text("No Items "))
                  : GetX<CartData>(
                      // init: CartData(),
                      builder: (data) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: cat.isEmpty
                              ? const Center(child: Text("No Items "))
                              : data.mainloding.value == true &&
                                      data.lodgin.value
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
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
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
                                            data.isSave(cat[index].id);
                                            bool dd = Hive.box(FavList)
                                                .containsKey(cat[index].id);

                                            if (dd == true) {
                                              // Hive.box(FavList).delete(products.id);
                                              data.favRemove(products.id);
                                            } else {
                                              data.addFav(
                                                  cat[index].id, cat[index].id);
                                            }
                                            data.favList(widget.product!);
                                          },
                                          details: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(
                                                  data: products,
                                                  user: widget.user,
                                                  products: widget.product!,
                                                  login: widget.login,
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
        ),
      ),
    );
  }
}
