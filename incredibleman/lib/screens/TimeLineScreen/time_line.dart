

/// this is for orderTimeline screen 

// class OrderTimelineScreen extends StatefulWidget {
//   const OrderTimelineScreen({Key? key}) : super(key: key);

//   @override
//   _OrderTimelineScreenState createState() => _OrderTimelineScreenState();
// }

// class _OrderTimelineScreenState extends State<OrderTimelineScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text("My Orders"),
//           toolbarHeight: 70.0,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(
//             top: 20.0,
//             bottom: 10.0,
//             left: 15.0,
//             right: 10.0,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   // color: Colors.green,
//                   width: width,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: height / 8.5,
//                         width: width / 4.5,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15.0),
//                           color: bgcontainer,
//                         ),
//                         child: Image.asset(
//                           notification2,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 15.0,
//                       ),
//                       SizedBox(
//                         // color: Colors.red,
//                         width: width / 2.6,
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(
//                               "Deliver by Jun 15",
//                               style: GoogleFonts.poppins(
//                                 color: tabColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               overflow: TextOverflow.clip,
//                               softWrap: false,
//                             ),
//                             const SizedBox(
//                               height: 10.0,
//                             ),
//                             Text(
//                               "Vetiver Face Wash",
//                               style: GoogleFonts.poppins(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Text(
//                               "Charcoal + Honey",
//                               style: GoogleFonts.poppins(
//                                 color: Colors.black54,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Spacer(),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 19.0,
//                           right: 15.0,
//                         ),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               border: Border.all(
//                                 color: Colors.green,
//                                 width: 0.5,
//                               )),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 5.0),
//                             child: Text(
//                               "On Time",
//                               style: GoogleFonts.poppins(
//                                 color: Colors.green,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15.0,
//                 ),
//                 const Divider(
//                   thickness: 1.5,
//                 ),
//                 TimelineTile(
//                   alignment: TimelineAlign.manual,
//                   lineXY: 0.05,
//                   isFirst: true,
//                   indicatorStyle: const IndicatorStyle(
//                     width: 20.0,
//                     color: Colors.green,
//                     padding: EdgeInsets.all(0),
//                   ),
//                   endChild: Padding(
//                     padding: const EdgeInsets.only(top: 35.0, left: 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               "Ordered",
//                               style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.bold, fontSize: 17.0),
//                             ),
//                             const SizedBox(
//                               width: 5.0,
//                             ),
//                             Text(
//                               "Thu, 10th Jun '21",
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black45,
//                                 fontSize: 12.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         const Text("Your order has been placed."),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         Text(
//                           "Thu, 10th June '21 - 8:39pm",
//                           style: GoogleFonts.poppins(
//                             color: Colors.black45,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   beforeLineStyle: const LineStyle(color: Colors.green),
//                   afterLineStyle: const LineStyle(color: Colors.green),
//                 ),
//                 TimelineTile(
//                   alignment: TimelineAlign.manual,
//                   lineXY: 0.05,
//                   indicatorStyle: const IndicatorStyle(
//                     width: 20.0,
//                     color: Colors.green,
//                     padding: EdgeInsets.all(0),
//                   ),
//                   endChild: Padding(
//                     padding: const EdgeInsets.only(top: 44.0, left: 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               "Packed",
//                               style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.bold, fontSize: 17.0),
//                             ),
//                             const SizedBox(
//                               width: 5.0,
//                             ),
//                             Text(
//                               "Thu, 10th Jun '21",
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black45,
//                                 fontSize: 12.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         const Text("Your order has been placed."),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         Text(
//                           "Thu, 10th June '21 - 8:39pm",
//                           style: GoogleFonts.poppins(
//                             color: Colors.black45,
//                             fontSize: 13,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         const Text(
//                             "Your item has been Picked up by courier partner."),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         Text(
//                           "Thu, 10th June '21 - 8:39pm",
//                           style: GoogleFonts.poppins(
//                             color: Colors.black45,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   beforeLineStyle: const LineStyle(color: Colors.green),
//                 ),
//                 TimelineTile(
//                   alignment: TimelineAlign.manual,
//                   lineXY: 0.05,
//                   // hasIndicator: false,
//                   indicatorStyle: const IndicatorStyle(
//                     width: 20.0,
//                     color: Colors.green,
//                     padding: EdgeInsets.all(0),
//                   ),
//                   endChild: Padding(
//                     padding: const EdgeInsets.only(top: 44.0, left: 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               "Shipped",
//                               style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.bold, fontSize: 17.0),
//                             ),
//                             const SizedBox(
//                               width: 5.0,
//                             ),
//                             Text(
//                               "Thu, 10th Jun '21",
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black45,
//                                 fontSize: 12.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         const Text("IMKart Logictics - LKEH17757635423"),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         Text(
//                           "Thu, 10th June '21 - 8:39pm",
//                           style: GoogleFonts.poppins(
//                             color: Colors.black45,
//                             fontSize: 13,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         const Text("Your order has been placed."),
//                         const SizedBox(
//                           height: 5.0,
//                         ),
//                         Text(
//                           "Thu, 10th June '21 - 8:39pm",
//                           style: GoogleFonts.poppins(
//                             color: Colors.black45,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   beforeLineStyle: const LineStyle(color: Colors.green),
//                   afterLineStyle: const LineStyle(
//                     color: Colors.black26,
//                     thickness: 2.5,
//                   ),
//                 ),
//                 TimelineTile(
//                   alignment: TimelineAlign.manual,
//                   lineXY: 0.05,
//                   isLast: true,
//                   indicatorStyle: const IndicatorStyle(
//                     width: 20.0,
//                     color: Colors.black26,
//                     padding: EdgeInsets.all(1),
//                   ),
//                   endChild: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Delivered",
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.bold, fontSize: 17.0),
//                         ),
//                         const SizedBox(
//                           width: 5.0,
//                         ),
//                         Text(
//                           "The, 15th Jun '21",
//                           style: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black45,
//                             fontSize: 12.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   beforeLineStyle: const LineStyle(
//                     color: Colors.black26,
//                     thickness: 2.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
