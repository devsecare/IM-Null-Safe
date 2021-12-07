import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/carttestModel/cartbox.dart';
import 'package:incredibleman/providers/providerdata.dart';
// import 'package:incredibleman/providers/woocommerceModels/woo_create_order.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_order_payload.dart';
import 'package:incredibleman/screens/EditAddressScreen/edit_address_screen.dart';
import 'package:incredibleman/screens/SummaryScreen/summary_screen.dart';
import 'package:incredibleman/screens/ThankyouScreen/thankyou_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../main.dart';

class CheckAddress extends StatefulWidget {
  final WooCustomer? user;
  final String? price;
  final List<CartBox>? products;
  const CheckAddress({Key? key, this.user, this.price, this.products})
      : super(key: key);

  @override
  _CheckAddressState createState() => _CheckAddressState();
}

class _CheckAddressState extends State<CheckAddress> {
  late Razorpay _razorpay;
  List<LineItems>? lineItems;
  //////////
  ///
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    print(widget.user!.firstName);
    // lineItem();
  }

  void openCheckOut() async {
    var price = double.parse(widget.price.toString());

    var options = {
      'key': 'rzp_test_FgLj2GruP8JI09',
      'amount': price * 100, //in the smallest currency sub-unit.
      'name': 'Incredible Man.',
      // 'order_id': 'newtest', // Generate order_id using Orders API
      // 'description': ,
      // 'timeout': 60, // in seconds
      'prefill': {
        'contact': widget.user!.billing!.phone,
        'email': widget.user!.billing!.email
      },
      'external': {
        'wallets': ['paytm', 'gpay']
      }
    };
    try {
      _razorpay.open(options);
      // ignore: empty_catches
    } catch (e) {}
  }

  void orderDone(String id) async {
    WooOrderPayload orderPayload = WooOrderPayload(
      customerId: widget.user!.id,
      paymentMethod: "razorpay",
      setPaid: true,
      metaData: [
        WooOrderPayloadMetaData(
          key: "_transaction_id",
          value: id,
        ),
      ],
      lineItems: widget.products!
          .map(
            (e) => LineItems(
              productId: e.id,
              quantity: e.quntity,
              name: e.name,
            ),
          )
          .toList(),
      billing: WooOrderPayloadBilling(
        address1: widget.user!.billing!.address1,
        address2: widget.user!.billing!.address2,
        firstName: widget.user!.firstName,
        city: widget.user!.billing!.city,
        postcode: widget.user!.billing!.postcode,
        state: widget.user!.billing!.state,
        phone: widget.user!.billing!.phone,
        email: widget.user!.billing!.email,
      ),
      shipping: WooOrderPayloadShipping(
        address1: widget.user!.billing!.address1,
        address2: widget.user!.billing!.address2,
        firstName: widget.user!.firstName,
        city: widget.user!.billing!.city,
        postcode: widget.user!.billing!.postcode,
        state: widget.user!.billing!.state,
      ),
    );

    await CartData.wooCommerce.createOrder(orderPayload);
    Hive.box(TestBox).clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar(
      "Payment",
      "Payment Success: ${response.paymentId}",
      backgroundColor: Colors.green,
    );

    orderDone(response.paymentId!);

    Get.offAll(() => const ThankYouScreen());
    Get.snackbar(
      "Payment",
      "Payment Success: ${response.paymentId}",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      "Payment",
      "Payment Error: ${response.message}",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      "walletName",
      "Payment wallet: ${response.walletName}",
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
    // Fluttertoast.showToast(
    //   msg: "Payment Wallet : ${response.walletName}",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.CENTER,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    // );
  }

  ///

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Address"),
          toolbarHeight: 70.0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          onPressed: () {
            // openCheckOut();
            Get.to(() => SummaryScreen(
                  user: widget.user,
                  price: widget.price!,
                  products: widget.products,
                ));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: const BorderSide(
              width: 1.0,
              color: black,
            ),
            padding: const EdgeInsets.all(8.0),
            minimumSize: const Size(335, 50),
          ),
          child: const Text(
            "Proccess to Payment",
            style: TextStyle(
              color: black,
            ),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              selected: true,
              selectedTileColor: const Color(0xffF1F1F1),
              onTap: () {
                print("tile click");
              },
              leading: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 19.0,
                  ),
                  onPressed: () {},
                ),
              ),
              trailing: TextButton(
                onPressed: () {
                  Get.to(() => EditAddressScreen(
                        user: widget.user,
                      ));
                },
                child: Text(
                  "Edit",
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: tabColor,
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.user!.billing!.firstName!,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.user!.billing!.address1}, ${widget.user!.billing!.city}, ${widget.user!.billing!.address2}\n${widget.user!.billing!.postcode} ${widget.user!.billing!.state}",
                      style: GoogleFonts.poppins(
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Mobile: ${widget.user!.billing!.phone}",
                      style: GoogleFonts.poppins(
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 50.0,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // openCheckOut();
            //     Get.to(() => SummaryScreen(
            //          user: widget.user,
            //          price: widget.price,
            //          products: widget.products,
            //         ));
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.white,
            //     side: BorderSide(
            //       width: 1.0,
            //       color: black,
            //     ),
            //     padding: const EdgeInsets.all(8.0),
            //     minimumSize: Size(335, 50),
            //   ),
            //   child: Text(
            //     "Proccess to Payment",
            //     style: TextStyle(
            //       color: black,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
