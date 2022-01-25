import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/BannerAdModel/banner_ad.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/reviews/reviews_model.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_create_order.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_error.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_product_category.dart';
import 'package:incredibleman/screens/CartScreen/cart_screen.dart';
import 'package:incredibleman/screens/CategoryScreen/category_screen.dart';
import 'package:incredibleman/screens/LoginScreen/login_screen.dart';
import 'package:incredibleman/screens/ProductDetailScreen/product_detail_screen.dart';
import 'package:incredibleman/screens/TabScreens/account_screen.dart';
import 'package:incredibleman/screens/TabScreens/im_combo_screen.dart';
import 'package:incredibleman/screens/TabScreens/order_list_screen.dart';
import 'package:incredibleman/screens/TabScreens/tab_main.dart';
import 'package:incredibleman/screens/WishListScreen/wish_list_screen.dart';
import 'package:incredibleman/screens/productListScreen/product_list_screen.dart';
import 'package:incredibleman/screens/widgetHelper/searchbar.dart';
import 'package:incredibleman/screens/widgetHelper/shimmer_screen.dart';
import 'package:incredibleman/screens/widgetHelper/shop_container.dart';
import 'package:incredibleman/screens/widgetHelper/tab_shimmer.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cro = Get.find<CartData>();
  bool _loading = true;
  int indexvalue = 0;

  bool login = false;

  int? userid;

  late List<WooProductCategory> category = [];
  WooCustomer? user;
  late List<WooOrder> orders = [];
  late List<Reviews> productReviews = [];

  void hmmm() {
    cro.favList(cro.newProducts);
  }

  @override
  void initState() {
    getProducts();
    cro.cartitme1();
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final data = message.data['id'];
        final name = message.data['name'];
        Get.to(() => CategoryScreen(
              id: data.toString(),
              name: name.toString(),
              product: cro.newProducts,
              user: user,
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final data = event.data['id'];
      final name = event.data['name'];
      // print("ontap pr che aaa ");

      Get.to(() => CategoryScreen(
            id: data.toString(),
            name: name.toString(),
            product: cro.newProducts,
            user: user,
            // login: login,
          ));
      // Get.to(() => NotificationTapScreen(
      //       data: data.toString(),
      //     ));
      // print(data);
    });
  }

  getProducts() async {
    try {
      var login1 = await CartData.wooCommerce.isCustomerLoggedIn();

      String token = CartData.wooCommerce.authToken;
      bool auth = true;

      if (token != '0') {
        auth = JwtDecoder.isExpired(token);
      }

      cro.testData();
      cro.favList(cro.newProducts);
      for (var i = 0; i < cro.newProducts.length; i++) {
        cro.isSave(cro.newProducts[i].id);
      }
      if (login1 == true && auth == false) {
        try {
          userid = await CartData.wooCommerce.fetchLoggedInUserId();

          user = await CartData.wooCommerce.getCustomerById(id: userid!);
          // print(user!.firstName);
          // print(userid);

          login = true;

          // orders = await CartData.getAllOrder(userid: userid);

          // ignore: empty_catches, unused_catch_clause
        } on WooCommerceError catch (e) {
          // print(e);
        }
      }
      setState(() {
        _loading = false;
      });
    } catch (e) {
      // print(e);
      Get.defaultDialog(
          title: "Opps... ",
          content: const Text("something Went Wrong Please Try Again"));
    }

    // CartData(products);
  }

  void tabIndex(int number) {
    setState(() {
      indexvalue = number;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,

          // iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: IconButton(
                icon: Image.asset(
                  search,
                  scale: 2,
                ),
                onPressed: () async {
                  showSearch(
                      context: context,
                      delegate: ItemSearch(
                        cro.newProducts,
                        user,
                        login,
                      ));
                },
              ),
            ),
            Obx(() => cro.cr.value
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Badge(
                      badgeColor: tabColor,
                      padding: const EdgeInsets.all(5.0),
                      position: const BadgePosition(
                        bottom: 35.0,
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
                                        products: cro.newProducts,
                                        login: login,
                                        user: user,
                                      )));
                        },
                      ),
                    ),
                  )),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                  drawer,
                  scale: 2.0,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.black,
          // backgroundColor: const Color(0xff0F0E0F),
          centerTitle: true,
          title: Image.asset(
            mainLogo,
            scale: 2.5,
            // width: 60,
          ),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    color: Colors.white,
                    child: ListView(
                      children: [
                        login
                            ? UserAccountsDrawerHeader(
                                margin: const EdgeInsets.only(
                                  bottom: 10.0,
                                ),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                    drawerbg,
                                  ),
                                  fit: BoxFit.cover,
                                )),
                                // arrowColor: Colors.black,
                                accountName: Text(
                                  user!.firstName!,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                accountEmail: Text(
                                  user!.email!,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                currentAccountPicture: ClipOval(
                                  child: Image.network(
                                    user!.avatarUrl!,
                                    scale: 1.0,
                                  ),
                                ),
                              )
                            : const UserAccountsDrawerHeader(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                    drawerbg,
                                  ),
                                  fit: BoxFit.cover,
                                )),
                                // arrowColor: Colors.black,
                                accountName: Text(" Hi Guest "),

                                currentAccountPicture: CircleAvatar(
                                  backgroundColor: tabColor,
                                  child: Icon(Icons.person),
                                ),
                                accountEmail: Text(""),
                              ),

                        Obx(() => GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen(
                                              products: cro.newProducts,
                                              login: login,
                                              user: user,
                                            )));
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                // color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 30.0,
                                    left: 20.0,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.shopping_cart,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(
                                        "My Cart",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 9.0,
                                          right: 9.0,
                                          top: 5.0,
                                          bottom: 5.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: tabColor,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Text(
                                          "${cro.cartitem.toString()} items",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 11.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WishListScreen(
                                            products: cro.newProducts,
                                            login: login,
                                            user: user,
                                            nav: false,
                                          )));
                            },
                            child: SizedBox(
                              width: double.infinity,
                              // color: Colors.red,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 30.0,
                                  left: 20.0,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      "Wishlist",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      cro.favItme.toString(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 0.0,
                            left: 20.0,
                            right: 20.0,
                            bottom: 0.0,
                          ),
                          child: Divider(
                            thickness: 1.8,
                          ),
                        ),

                        ///yeeeeeeeeeeeeeee
                        ///
                        GestureDetector(
                          onTap: () {
                            //73
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CategoryScreen(
                                  id: "73",
                                  name: "IM Combo",
                                  product: cro.newProducts,
                                  user: user,
                                  // login: login,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    imcat,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "IM Combo",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //37
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CategoryScreen(
                                  id: "37",
                                  name: "Beard",
                                  product: cro.newProducts,
                                  user: user,
                                  // login: login,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    breadcat,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Beard",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //63
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CategoryScreen(
                                  id: "63",
                                  name: "Hair",
                                  product: cro.newProducts,
                                  user: user,
                                  // login: login,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    haircat,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Hair",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //65

                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CategoryScreen(
                                  id: "65",
                                  name: "Face",
                                  product: cro.newProducts,
                                  user: user,
                                  // login: login,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    facecat,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Face",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //64

                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CategoryScreen(
                                  id: "64",
                                  name: "Body",
                                  product: cro.newProducts,
                                  user: user,
                                  // login: login,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    bodycat,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Body",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            //68
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CategoryScreen(
                                  id: "68",
                                  name: "Oral",
                                  product: cro.newProducts,
                                  user: user,
                                  // login: login,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    oralcat,
                                    scale: 3,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Oral",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 0.0,
                            left: 20.0,
                            right: 20.0,
                            bottom: 0.0,
                          ),
                          child: Divider(
                            thickness: 1.8,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL("https://www.incredibleman.in/faq/");
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "FAQs",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.incredibleman.in/contact-us/");
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.support_agent,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Contact Us",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.incredibleman.in/privacy-policy/");
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Privacy Policy",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        login
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Alert!"),
                                          content: const Text(
                                              " Are you sure you want to Logout?"),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                await CartData.wooCommerce
                                                    .logUserOut();
                                                // getProducts();
                                                // Get.back();

                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomeScreen(),
                                                        ),
                                                        (route) => false);
                                              },
                                              child: Text(
                                                "yes",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: tabColor,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.black,
                                              ),
                                              child: Text(
                                                "No",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  // color: Colors.red,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 30.0,
                                      left: 20.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.logout_sharp,
                                          color: Colors.black54,
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Text(
                                          "Log out",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  // color: Colors.red,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 30.0,
                                      left: 20.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.logout_sharp,
                                          color: Colors.black54,
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Text(
                                          "Login",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        // const SizedBox(
                        //   height: 250.0,
                        // ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "V1.0.4 ©Incredibleman.in",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: _loading
            ? const TabShimmer()
            : BottomNavigationBar(
                showSelectedLabels: true,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                selectedItemColor: tabColor,
                selectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
                unselectedItemColor: Colors.black45,
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
                onTap: (value) {
                  tabIndex(value);
                },
                currentIndex: indexvalue,
                items: <BottomNavigationBarItem>[
                  for (var tabItem in TabNavigationItem.items)
                    BottomNavigationBarItem(
                      icon: tabItem.icon,
                      label: tabItem.title.toString(),
                      activeIcon: tabItem.activeIcon,
                    )
                ],
              ),
        // body: Container(),
        body: IndexedStack(
          index: indexvalue,
          children: [
            _loading
                ? const Center(
                    child: ShimmerLoading(),
                  )
                : Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            FutureBuilder(
                                future:
                                    CartData.wooCommerce.getProductCategories(),
                                builder: (context,
                                    AsyncSnapshot<List<WooProductCategory>>
                                        catData) {
                                  if (catData.hasData) {
                                    category = catData.data!;
                                    return SizedBox(
                                      // color: Colors.black.withOpacity(0.1),
                                      height: height / 7.5,

                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: category.length - 1,
                                        itemBuilder: (context, index) {
                                          final cat = category[index];

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 8.0,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                //newww
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        CategoryScreen(
                                                      id: cat.id.toString(),
                                                      name: cat.name!,
                                                      product: cro.newProducts,
                                                      user: user,
                                                      // login: login,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 90,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.20),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: const Offset(
                                                        5,
                                                        5,
                                                      ), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: height / 15,
                                                      child: Image.asset(
                                                        cimage[index],
                                                        scale: 2,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      cat.name!,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return const TabShimmer();
                                }),
                            const SizedBox(
                              height: 5.0,
                            ),
                            FutureBuilder(
                              future: CartData.bannerAD(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  final BannerAd banner = snapshot.data;
                                  return GestureDetector(
                                    onTap: () {
                                      //newwwww
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => CategoryScreen(
                                            id: banner.post1!.offerCategory![0]
                                                .toString(),
                                            name: "offer",
                                            product: cro.newProducts,
                                            user: user,
                                            // login: login,
                                          ),
                                        ),
                                      );
                                    },
                                    child: FittedBox(
                                      child: SizedBox(
                                        height: height / 3.8,
                                        width: width,
                                        child: Image.network(
                                          banner.post1!.banner!,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Image.asset(
                                              logoloader,
                                              width: width / 2,
                                              height: height / 3.5,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return const ContainerShimmer();
                              },
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Best Selling ",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0.0),
                                    primary: Colors.transparent,
                                    elevation: 0.0,
                                    alignment: Alignment.centerRight,
                                  ),
                                  onPressed: () {
                                    ///newwww
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                ProductListScreen(
                                                  product: cro.newProducts,
                                                  user: user,
                                                  login: login,
                                                )));
                                  },
                                  child: Text(
                                    "See all",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black45,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Obx(
                                // init: CartData(),
                                () => cro.mainloding.value == true ||
                                        cro.lodgin.value ||
                                        // ignore: prefer_is_empty
                                        cro.newProducts.length <= 0
                                    ? const Center(
                                        child: ContainerShimmer(),
                                      )
                                    : GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        reverse: true,
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 12,
                                          crossAxisSpacing: 12,
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.05),
                                        ),
                                        itemCount: 2,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final p = cro.newProducts[index];
                                          // print(
                                          //     " aa double che ${double.parse(p.price).toStringAsFixed(0)}");
                                          return ShopContainer(
                                            tag: "tag-${p.name}",
                                            sale: p.onSale!,
                                            like: () async {
                                              //newwwww
                                              cro.isSave(
                                                  cro.newProducts[index].id);
                                              bool dd = Hive.box(FavList)
                                                  .containsKey(cro
                                                      .newProducts[index].id);

                                              if (dd == true) {
                                                // Hive.box(FavList).delete(products.id);
                                                cro.favRemove(p.id);
                                              } else {
                                                cro.addFav(
                                                    cro.newProducts[index].id,
                                                    cro.newProducts[index].id);
                                                // data.addTest(
                                                //     p.id, CartBox(5, p.id));

                                              }
                                              hmmm();
                                            },
                                            details: () {
                                              //newwww
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          ProductDetailScreen(
                                                            data: p,
                                                            user: user,
                                                            products:
                                                                cro.newProducts,
                                                            login: login,
                                                          )));
                                            },
                                            price: p.onSale!
                                                ? p.salePrice!
                                                : p.regularPrice!,
                                            dec: p.name,
                                            image: p.images![0].src!,
                                            dec2: p.name,
                                            icon: Icon(
                                              Icons.favorite,
                                              size: 20.0,
                                              color: Hive.box(FavList)
                                                      .containsKey(cro
                                                          .newProducts[index]
                                                          .id)
                                                  ? Colors.red
                                                  : bgcontainer,
                                            ),
                                          );
                                        },
                                      )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            FutureBuilder(
                              future: CartData.bannerAD(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  final BannerAd banner = snapshot.data;
                                  return GestureDetector(
                                    onTap: () {
                                      //newwww
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => CategoryScreen(
                                            id: banner.post2!.offerCategory![0]
                                                .toString(),
                                            name: "offer",
                                            product: cro.newProducts,
                                            user: user,
                                            // login: login,
                                          ),
                                        ),
                                      );
                                    },
                                    child: FittedBox(
                                      child: SizedBox(
                                        height: height / 3.8,
                                        width: width,
                                        child: Image.network(
                                          banner.post2!.banner!,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Image.asset(
                                              logoloader,
                                              width: width / 2,
                                              height: height / 3.5,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return const TabShimmer();
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recommended",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0.0),
                                    primary: Colors.transparent,
                                    elevation: 0.0,
                                    alignment: Alignment.centerRight,
                                  ),
                                  onPressed: () {
                                    ///newwww
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                ProductListScreen(
                                                  product: cro.newProducts,
                                                  user: user,
                                                  login: login,
                                                )));
                                  },
                                  child: Text(
                                    "See all",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black45,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 9.0,
                            ),
                            Obx(
                              // init: CartData(),
                              () => cro.mainloding.value == true ||
                                      cro.lodgin.value ||
                                      // ignore: prefer_is_empty
                                      cro.newProducts.length <= 0
                                  ? const Center(
                                      child: ContainerShimmer(),
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      // reverse: true,
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final p = cro.newProducts[index];
                                        return ShopContainer(
                                          tag: "tag-${p.name}",
                                          sale: p.onSale!,
                                          like: () async {
                                            cro.isSave(
                                                cro.newProducts[index].id);
                                            bool dd = Hive.box(FavList)
                                                .containsKey(
                                                    cro.newProducts[index].id);

                                            if (dd == true) {
                                              cro.favRemove(p.id);
                                            } else {
                                              cro.addFav(
                                                  cro.newProducts[index].id,
                                                  cro.newProducts[index].id);
                                            }
                                            hmmm();
                                          },
                                          details: () {
                                            ///newwwwww
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProductDetailScreen(
                                                          data: p,
                                                          user: user,
                                                          products:
                                                              cro.newProducts,
                                                          login: login,
                                                        )));
                                          },
                                          price: p.onSale!
                                              ? p.salePrice!
                                              : p.regularPrice!,
                                          dec: p.name,
                                          dec2: p.name,
                                          image: p.images![0].src!,
                                          icon: Icon(
                                            Icons.favorite,
                                            size: 20.0,
                                            color: Hive.box(FavList)
                                                    .containsKey(cro
                                                        .newProducts[index].id)
                                                ? Colors.red
                                                : bgcontainer,
                                          ),
                                        );
                                      },
                                      itemCount: cro.newProducts.length - 22,
                                    ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text("© 2021 Incredible Man"),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            // DevScreen(),
            _loading
                ? Container()
                : ImcomboScreen(
                    id: "73",
                    login: login,
                    name: "Im Combo",
                    user: user,
                    product: cro.newProducts,
                  ),
            OrderListScreen(
              login: login,
              userid: userid,
            ),
            _loading
                ? Container()
                : Account(
                    products: cro.newProducts,
                    login: login,
                    user: user,
                  ),
          ],
        ),
      ),
    );
  }
}
