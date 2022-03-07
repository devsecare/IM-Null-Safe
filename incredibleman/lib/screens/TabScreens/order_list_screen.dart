import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';

import 'package:incredibleman/providers/woocommerceModels/woo_create_order.dart';

class OrderListScreen extends StatelessWidget {
  final bool? login;
  final int? userid;
  const OrderListScreen({
    Key? key,
    this.login,
    this.userid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: CartData.getAllOrder(userid: userid),
          builder: (context, AsyncSnapshot<List<WooOrder>> catData) {
            if (catData.data == null || catData.data!.isEmpty) {
              return const Center(
                child: Text("No Orders Yet"),
              );
            } else if (catData.data!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final ord = catData.data![index];
                    return SizedBox(
                      width: width,
                      child: ExpansionTile(
                        title: Text(
                          ord.number.toString(),
                          style: GoogleFonts.poppins(
                            color: mainColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ord.status.toString(),
                              style: GoogleFonts.poppins(
                                color: ord.status == "cancelled"
                                    ? Colors.red
                                    : ord.status == "processing" ||
                                            ord.status == "completed"
                                        ? Colors.green
                                        : Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        children: [
                          Column(
                            children: List.generate(
                              ord.lineItems!.length,
                              (index) => ListTile(
                                title: Text(
                                    "${ord.lineItems![index].name.toString()} ☓${ord.lineItems![index].quantity}"),
                                subtitle: Text(
                                    "$rupee ${double.parse(ord.lineItems![index].price!).roundToDouble().toString()}"),
                              ),
                            ),
                          ),
                          Column(
                            children: List.generate(
                              ord.shippingLines!.length,
                              (index) => ListTile(
                                title: Text(
                                  "Shipping " +
                                      ord.shippingLines![index].methodTitle
                                          .toString(),
                                ),
                                subtitle: Text(
                                    "$rupee ${ord.shippingLines![index].total.toString()}"),
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text("Total"),
                            subtitle: Text(
                              "$rupee ${ord.total} (includes CGST, SGST)",
                            ),
                          ),

                          ///              This Block will take to OrderTimeline Screen   /////////////////
                          // TextButton(
                          //   onPressed: () {
                          //     Get.to(() => const OrderTimelineScreen());
                          //   },
                          //   child: Text(
                          //     "Track Order",
                          //     style: GoogleFonts.poppins(
                          //       color: tabColor,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black45,
                  ),
                  itemCount: catData.data!.length,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
