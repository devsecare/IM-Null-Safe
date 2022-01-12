// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/carttestModel/cartbox.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_order_payload.dart';
import 'package:incredibleman/screens/ThankyouScreen/thankyou_screen.dart';
import 'package:incredibleman/screens/widgetHelper/price_loading.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../main.dart';

class SummaryScreen extends StatefulWidget {
  final WooCustomer? user;
  final String price;
  final List<CartBox>? products;
  const SummaryScreen({Key? key, this.user, required this.price, this.products})
      : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final cro = Get.find<CartData>();
  late Razorpay _razorpay;
  late List<LineItems> lineItems;
  late bool _loading;
  final TextEditingController _coupon = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var shipping = "FREE";
  var shipvalue = 0;
  var finalprice;
  var gstvalue;
  var couponvalue = 0.0;
  var gstadd;
  var cgst;
  var sgst;
  var igst = 18;
  bool guj = false;
  var exitGST;
  var coupencode;
  var coupenid;

  late String shippingTitle;
  late String shippingid;
  @override
  void initState() {
    _loading = true;
    super.initState();
    // print("aa id product in ${widget.products![0].id}");
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getAddre();

    // lineItem();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
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
      "Payment Faild: Please try agian",
      backgroundColor: Colors.redAccent,
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
  }

  ///

  getAddre() async {
    var ty = igst / 100;
    var hh = ty + 1;

    exitGST = (double.parse(widget.price) / hh).roundToDouble();
    // print("aa first ${widget.price}");
    if (widget.user!.billing!.state == "GUJARAT" ||
        widget.user!.billing!.state == "GUJRAT" ||
        widget.user!.billing!.state == "Gujarat" ||
        widget.user!.billing!.state == "gujarat" ||
        widget.user!.billing!.state == "GJ" ||
        widget.user!.billing!.state == "gj") {
      // print('aaa value che gst vagr in $exitGST');
      cgst = (exitGST * 9) / 100;
      sgst = (exitGST * 9) / 100;
      // print(cgst);
      // print(sgst);
      // var jj = cgst + sgst;
      // print("aa to peli pde $jj");
      // exitGST = double.parse(widget.price) - jj;
      // print("aa to jovi pde $exitGST");
      guj = true;
      // print("AA Gujarat Vado Che");
    }
    gstadd = (exitGST * igst) / 100;
    gstvalue = (exitGST + gstadd).roundToDouble();
    // print("aa gst value che $gstadd");

    //  var addre = await CartData.woocommerce
    //         .getAllShippingZoneMethods(shippingZoneId: 1);
    // print(addre);

    try {
      var ch = await CartData.shippingDatat();

      var com = double.parse(ch[1].settings!.minAmount!.value!);
      // print("aa check thse $com");
      if (double.parse(widget.price) < com) {
        // print("aa biju ${widget.price}");

        // print(ch[0].settings!.cost!.value);
        setState(() {
          shipvalue = int.parse(ch[0].settings!.cost!.value!);
          shippingid = ch[0].methodId!;
          shippingTitle = ch[0].methodTitle!;

          finalprice = gstvalue + shipvalue;
          // print("aa final gstvalue che $gstvalue");
          // print("aa final shipvalue che $shipvalue");
          // print("aa final value che $finalprice");
          _loading = false;
        });
      } else {
        // print("aa triju ${widget.price}");
        setState(() {
          shippingid = ch[1].methodId!;
          shippingTitle = ch[1].methodTitle!;
          finalprice = gstvalue;
          _loading = false;
        });
      }
    } catch (e) {
      Get.defaultDialog(
          title: "Ooops...",
          content: const Text("Somthing went wrong please try again"));
    }
  }

  couponcheck({required String code}) async {
    setState(() {
      _loading = true;
    });
    try {
      var cop = await CartData.couponCheck(code: code);
      // print(cop[0].dateExpires);

      var now = DateTime.now();
      var check = now.isBefore(DateTime.parse(cop[0].dateExpires));
      // print(check);
      if (cop.isEmpty || !check) {
        // print("naaa paade che coupon");
        setState(() {
          _loading = false;
        });
        Get.snackbar(
          "Invalid Coupon",
          "This Coupon is Invalid ",
          backgroundColor: Colors.white,
        );
      } else {
        setState(() {
          // print(finalprice);
          var couponvalue1 = double.parse(cop[0].amount!);
          var dd = couponvalue1 / 100;
          // print("aa devider che $dd");
          couponvalue = (finalprice * dd as double).roundToDouble();
          // print("aaa che multi  vado price $couponvalue");
          finalprice = (finalprice - couponvalue as double).roundToDouble();

          coupencode = cop[0].code;
          coupenid = cop[0].id;
          // print("aaa che final  vado price $finalprice");

          // finalprice = finalprice - couponvalue;
          // var dd = finalprice % couponvalue;

          _loading = false;
          // print(finalprice);
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });

      // print("aa error che $e");
      Get.snackbar(
        "Invalid Coupon",
        "This Coupon is Invalid ",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void openCheckOut() async {
    var price = double.parse(finalprice.toString());

    var options = {
      'key': "rzp_live_gGSvf9bRFy4JYi",
      'amount': price * 100, //in the smallest currency sub-unit.
      'name': 'Incredible Man',
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
    } catch (e) {
      // print("aa razor ni error che $e");
    }
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
      couponLines: couponvalue == 0.0
          ? []
          : [
              WooOrderPayloadCouponLines(
                code: coupencode,
              )
            ],
      // shippingLines: [
      //   ShippingLines(
      //     methodId: shippingid,
      //     methodTitle: shippingTitle,
      //   ),
      // ],
    );

    await CartData.wooCommerce.createOrder(orderPayload);
    Hive.box(TestBox).clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping details"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 80.0,
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 0.8,
                  color: Colors.black54,
                ),
              )),
          width: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Total:",
                      style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        color: tabColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _loading
                        ? const PriceLoading()
                        : finalprice == 0
                            ? Text(
                                "$rupee ${widget.price}",
                                style: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "$rupee $finalprice",
                                style: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  ],
                ),
                _loading
                    ? const PriceLoading()
                    : ElevatedButton(
                        onPressed: () {
                          openCheckOut();
                          // orderDone("hdshsdhcbsj");
                        },
                        child: Text(
                          "PAY NOW",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 17.0,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            minimumSize: Size(width / 1.8, 60)),
                      ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Text(
                      "PRICE DETAILS",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // PriceLoading(),
                    Text(
                      "(${widget.products!.length}  ITEMS)",
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 35,
                  thickness: 0.8,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total MRP",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        _loading
                            ? const PriceLoading()
                            : Text(
                                "$rupee $exitGST",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    guj
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "CGST",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  _loading
                                      ? const PriceLoading()
                                      : Text(
                                          "+ $rupee$cgst",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "SGST",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  _loading
                                      ? const PriceLoading()
                                      : Text(
                                          "+ $rupee$sgst",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _loading
                                      ? const PriceLoading()
                                      : Text(
                                          "IGST",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  _loading
                                      ? const PriceLoading()
                                      : Text(
                                          "+ $rupee$gstadd",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    _loading
                        ? const PriceLoading()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              shipvalue == 0
                                  ? Text(
                                      "Shipping FEE",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Text(
                                      "Shipping Rate",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              shipvalue == 0
                                  ? Text(
                                      "FREE",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                      ),
                                    )
                                  : Text(
                                      "+ $rupee ${shipvalue.toString()}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ],
                          ),
                    const SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
                couponvalue == 0.0
                    ? Form(
                        key: _formkey,
                        child: TextFormField(
                          controller: _coupon,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "No Coupon";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: TextButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  couponcheck(code: _coupon.text);
                                }
                              },
                              child: Text("Check",
                                  style: GoogleFonts.poppins(
                                    color: tabColor,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Coupon Code',
                            hintText: 'Enter secure password',
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Coupon Discount",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "- $rupee ${couponvalue.toString()}",
                            style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 15.0,
                ),
                const Divider(
                  height: 35,
                  thickness: 0.8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    _loading
                        ? const PriceLoading()
                        : finalprice == 0
                            ? Text(
                                "$rupee ${widget.price}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              )
                            : Text(
                                "$rupee $finalprice",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, bottom: 5.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // height: 90,
                        width: 80,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Image.asset(
                                noContact,
                                scale: 2.5,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "No Contact",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Delivery",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        // height: 90,
                        width: 80,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Image.asset(
                                deliverd,
                                scale: 2.5,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Timely",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Delivered",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        // height: 90,
                        width: 80,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Image.asset(
                                reture,
                                scale: 2.5,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Easy",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Return",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        // height: 90,
                        width: 80,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Image.asset(
                                pay,
                                scale: 2.5,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Secure",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Payment",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
