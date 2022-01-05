import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';

import 'package:incredibleman/providers/woocommerceModels/woo_create_order.dart';

class OrderListScreen extends StatelessWidget {
  final List<dynamic>? orders;
  const OrderListScreen({Key? key, this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // body: FutureBuilder(
      //     future: CartData.getAllOrder(userid: 43),
      //     builder: (context, AsyncSnapshot catData) {
      //       print(catData.error);
      //       if (catData.hasData) {
      //         return Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: ListView.separated(
      //             physics: const NeverScrollableScrollPhysics(),
      //             shrinkWrap: true,
      //             itemBuilder: (context, index) {
      //               final ord = catData.data![index];
      //               return GestureDetector(
      //                 onTap: () {},
      //                 child: SizedBox(
      //                   width: width,
      //                   child: Row(
      //                     children: [
      //                       Container(
      //                         height: height / 8,
      //                         width: width / 4,
      //                         decoration: BoxDecoration(
      //                           color: bgcontainer,
      //                           borderRadius: BorderRadius.circular(10.0),
      //                         ),
      //                         child: Image.asset(
      //                           logoloader,
      //                           fit: BoxFit.contain,
      //                         ),
      //                       ),
      //                       const SizedBox(
      //                         width: 9.0,
      //                       ),
      //                       SizedBox(
      //                         // color: Colors.red,
      //                         width: width / 1.99,
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Text(
      //                               ord['status'] ?? "something went wrong",
      //                               style: GoogleFonts.poppins(
      //                                 color: Colors.green,
      //                                 fontSize: 17,
      //                                 fontWeight: FontWeight.w700,
      //                               ),
      //                             ),
      //                             const SizedBox(
      //                               height: 10.0,
      //                             ),
      //                             Text(
      //                               ord['number'] ?? "000-000-000",
      //                               style: GoogleFonts.poppins(
      //                                 color: Colors.black,
      //                                 fontSize: 15,
      //                                 fontWeight: FontWeight.w600,
      //                               ),
      //                               overflow: TextOverflow.visible,
      //                               softWrap: false,
      //                             ),
      //                             Text(
      //                               rupee + ord['total'],
      //                               style: GoogleFonts.poppins(
      //                                 color: Colors.black38,
      //                                 fontSize: 13,
      //                                 fontWeight: FontWeight.w500,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       const Spacer(),
      //                     ],
      //                   ),
      //                 ),
      //               );

      //             },
      //             separatorBuilder: (context, index) => const Divider(
      //               color: Colors.black45,
      //             ),
      //             itemCount: catData.data!.length,
      //           ),
      //         );
      //
      //       }
      //       return const CircularProgressIndicator();
      //     }),
      body: orders!.isEmpty
          ? const Center(
              child: Text("No Orders Yet"),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "My Orders",
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final ord = orders![index];
                        // final name = ord.lineItems![0].name;
                        // print(orders[0]);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: width,
                              child: Row(
                                children: [
                                  Container(
                                    height: height / 8,
                                    width: width / 4,
                                    decoration: BoxDecoration(
                                      color: bgcontainer,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Image.asset(
                                      logoloader,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 9.0,
                                  ),
                                  SizedBox(
                                    // color: Colors.red,
                                    width: width / 1.99,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ord['status'],
                                          style: GoogleFonts.poppins(
                                            color: Colors.green,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          ord['number'],
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.visible,
                                          softWrap: false,
                                        ),
                                        Text(
                                          rupee + ord['total'],
                                          style: GoogleFonts.poppins(
                                            color: Colors.black38,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black45,
                      ),
                      itemCount: orders!.length,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // Widget _orderList(
  //   WooOrder order,
  //   String name,
  //   VoidCallback timeline,
  //   var height,
  //   var width,
  // ) {
  //   return GestureDetector(
  //     onTap: timeline,
  //     child: SizedBox(
  //       width: width,
  //       child: Row(
  //         children: [
  //           Container(
  //             height: height / 8,
  //             width: width / 4,
  //             decoration: BoxDecoration(
  //               color: bgcontainer,
  //               borderRadius: BorderRadius.circular(10.0),
  //             ),
  //             child: Image.asset(
  //               logoloader,
  //               fit: BoxFit.contain,
  //             ),
  //           ),
  //           const SizedBox(
  //             width: 9.0,
  //           ),
  //           SizedBox(
  //             // color: Colors.red,
  //             width: width / 1.99,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   order.status!,
  //                   style: GoogleFonts.poppins(
  //                     color: Colors.green,
  //                     fontSize: 17,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 10.0,
  //                 ),
  //                 Text(
  //                   name,
  //                   style: GoogleFonts.poppins(
  //                     color: Colors.black,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                   overflow: TextOverflow.clip,
  //                   softWrap: false,
  //                 ),
  //                 Text(
  //                   rupee + "5000",
  //                   style: GoogleFonts.poppins(
  //                     color: Colors.black38,
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const Spacer(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
