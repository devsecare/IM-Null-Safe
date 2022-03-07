import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_products.dart';
import 'package:incredibleman/screens/CartScreen/cart_screen.dart';
import 'package:incredibleman/screens/ProductDetailScreen/product_detail_screen.dart';
import 'package:incredibleman/screens/widgetHelper/wish_list_container.dart';

class WishListScreen extends StatefulWidget {
  final List<WooProduct>? products;
  final bool? login;
  final WooCustomer? user;
  final bool? nav;
  const WishListScreen(
      {Key? key, this.products, this.login, this.user, this.nav})
      : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final fav = Get.put(CartData());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Wishlist"),
              const SizedBox(
                height: 5.0,
              ),
              GetX<CartData>(
                builder: (data) {
                  return Text(
                    "${data.favTotal.toString()} Items",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white38,
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            // obx used to manage state of this block
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
                        fav.cartitem.toString(),
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
                        if (widget.nav == false) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => CartScreen(
                                        products: widget.products,
                                        login: widget.login,
                                        user: widget.user,
                                      )));
                          // Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                )),
          ],
        ),
        body: GetX<CartData>(
          init: CartData(),
          builder: (data) {
            return data.mainloding.value == true && data.lodgin.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.05),
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.favlist1.length,
                      itemBuilder: (context, index) {
                        final products = data.favlist1[index];
                        return WishListContainer(
                          like: () {
                            data.favRemove(products.id);
                            data.favList(widget.products!);
                          },
                          details: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailScreen(
                                          data: products,
                                          user: widget.user,
                                          products: widget.products!,
                                          login: widget.login!,
                                        )));
                          },
                          dec: products.name,
                          dec2: products.name,
                          price: products.price,
                          image: products.images![0].src,
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
