import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_products.dart';
import 'package:incredibleman/screens/EditAddressScreen/edit_address_screen.dart';
import 'package:incredibleman/screens/Home/home.dart';
import 'package:incredibleman/screens/LoginScreen/login_screen.dart';
import 'package:incredibleman/screens/WishListScreen/wish_list_screen.dart';
import 'package:incredibleman/screens/profileScreen/profile_screen.dart';

class Account extends StatelessWidget {
  final List<WooProduct>? products;
  final bool? login;
  final WooCustomer? user;
  const Account({Key? key, this.products, this.login, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 6,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: height / 15,
                    left: width / 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 90.0,
                            width: 90.0,
                            decoration: BoxDecoration(
                                color: bgcontainer,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: const Icon(
                              Icons.person_outline_outlined,
                              size: 50.0,
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              login!
                                  ? Text(
                                      user?.firstName! ?? "",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Text(
                                      "Hello Guest",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),
                              login!
                                  ? Text(
                                      user?.email! ?? "",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white38,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            // ListTile(
            //   onTap: () {
            //     //newwww
            //     // Get.to(() => CartScreen(
            //     //       user: user,
            //     //       products: products,
            //     //       login: login,
            //     //     ));
            //   },
            //   // tileColor: Colors.white,
            //   title: Text(
            //     "Notifications",
            //     style: GoogleFonts.poppins(
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            //   leading: Image.asset(
            //     notifi,
            //     scale: 2,
            //   ),
            //   // leading: Icon(
            //   //   Icons.notifications_none,
            //   //   size: 35.0,
            //   // ),
            //   subtitle: const Text("Stay on top of all products updates"),
            //   trailing: const Icon(
            //     Icons.arrow_forward_ios,
            //     color: Colors.black,
            //   ),
            // ),
            // const Divider(),
            ListTile(
              onTap: () {
                //newwwwww
                Get.to(
                  () => WishListScreen(
                    products: products,
                    login: login,
                    user: user,
                    nav: false,
                  ),
                );
              },
              title: Text(
                "Wishlist",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Image.asset(
                wishList,
                scale: 2,
              ),
              subtitle: const Text("your most loved products"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            login! ? const Divider() : Container(),
            login!
                ? ListTile(
                    onTap: () {
                      //newwww
                      Get.to(() => EditAddressScreen(
                            user: user,
                          ));
                    },
                    title: Text(
                      "Address",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    leading: Image.asset(
                      address,
                      scale: 2,
                    ),
                    subtitle: const Text("save address for checkout"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  )
                : Container(),
            login! ? const Divider() : Container(),
            login!
                ? ListTile(
                    onTap: () {
                      //newssss
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ProfileScreen(
                                user: user!,
                              )));
                    },
                    title: Text(
                      "Profile Details",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    leading: Image.asset(
                      profile,
                      scale: 2,
                    ),
                    subtitle: const Text("Change profile information"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  )
                : Container(),
            const Divider(),
            login!
                ? Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                          side: const BorderSide(
                            width: 1.0,
                            color: tabColor,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          minimumSize: Size(width / 1.12, 50),
                        ),
                        onPressed: () {
                          //newsss check this
                          CartData.wooCommerce.logUserOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: tabColor,
                        ),
                        label: const Text(
                          "LOG OUT",
                          style: TextStyle(
                            color: tabColor,
                          ),
                        )),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                          side: const BorderSide(
                            width: 1.0,
                            color: tabColor,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          minimumSize: Size(width / 1.12, 50),
                        ),
                        onPressed: () {
                          //new
                          Get.to(
                            () => const LoginScreen(),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: tabColor,
                        ),
                        label: const Text(
                          "Login",
                          style: TextStyle(
                            color: tabColor,
                          ),
                        )),
                  ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
