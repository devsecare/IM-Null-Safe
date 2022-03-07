// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/carttestModel/cartbox.dart';
import 'package:incredibleman/providers/couponModel/coupon_model.dart';
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

  String? userEmail;

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
    getAddre(price: widget.price);
    // gstCal(price: widget.price.toString());
    userEmail = widget.user!.email;
    // userEmail = "meet.ecareinfoway@gmail.com";

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
  ///
  ///
  ///
  ///
  gstCal({price}) async {
    var ty = igst / 100;
    var hh = ty + 1;
    print(ty);
    print(hh);

    exitGST = (double.parse(price) / hh).roundToDouble();

    if (guj) {
      cgst = (exitGST * 9) / 100;
      print(cgst);
      sgst = (exitGST * 9) / 100;
      print(sgst);
      gstadd = (exitGST * igst) / 100;
      print(gstadd);
      gstvalue = (exitGST + gstadd).roundToDouble();
      print("aa jo to value $gstvalue");
      print("aa shiping value jo to $shipvalue");
      finalprice = gstvalue + shipvalue;
      print(
          " aa guju che and final price che gst and shipping sathe $finalprice");
    } else {
      gstadd = (exitGST * igst) / 100;
      print(gstadd);
      gstvalue = (exitGST + gstadd).roundToDouble();
      print(gstvalue);
      finalprice = gstvalue + shipvalue;
      print(
          " aa guju che and final price che gst and shipping sathe $finalprice");
    }
  }

  couponError() {
    setState(() {
      _loading = false;
    });
    Get.snackbar(
      "Invalid Coupon",
      "This Coupon is Invalid ",
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  getAddre({price}) async {
    print("aa first $price");
    var ty = igst / 100;
    var hh = ty + 1;
    print(ty);
    print(hh);

    exitGST = (double.parse(price) / hh).roundToDouble();
    // // exitGST = double.parse(widget.price);
    // print(exitGST);

    if (widget.user!.billing!.state == "GUJARAT" ||
        widget.user!.billing!.state == "GUJRAT" ||
        widget.user!.billing!.state == "Gujarat" ||
        widget.user!.billing!.state == "gujarat" ||
        widget.user!.billing!.state == "GJ" ||
        widget.user!.billing!.state == "gj") {
      cgst = (exitGST * 9) / 100;
      print(cgst);
      sgst = (exitGST * 9) / 100;
      print(sgst);
      gstadd = (exitGST * igst) / 100;
      print(gstadd);
      gstvalue = (exitGST + gstadd).roundToDouble();
      print(gstvalue);

      guj = true;
      getShipping(isgujju: guj);
      print("gujju che uper");
      return;
    }
    gstadd = (exitGST * igst) / 100;
    print(gstadd);
    gstvalue = (exitGST + gstadd).roundToDouble();
    print(gstvalue);
    getShipping(isgujju: guj);
    print("guuju nathi uper");
  }

  couponCheckFlat({
    required List<CouponModel> cop,
    int? usageLimit,
    int? usagecount,
    List<String>? emailcheck,
    List<String>? usedby,
  }) {
    if (cop[0].usageLimit != null &&
        emailcheck!.isNotEmpty &&
        cop[0].usageLimitPerUser != null) {
      print("badhu j che ");
      if (usagecount! < cop[0].usageLimit!) {
        print("flat exp nthi and vapri sakai che hji");
        if (emailcheck.contains(userEmail)) {
          print("flat exp nthi and email contain kre che");
          if (usedby!.isNotEmpty) {
            var i = 0;
            for (var item in cop[0].usedBy!) {
              if (item == userEmail.toString()) {
                i = i + 1;
              }
            }
            if (cop[0].usageLimitPerUser! > i) {
              print("vapri sake che");
              coupenFlat(cop: cop);
              return;
            } else {
              print("used kri lithu che ");

              couponError();
              return;
            }
          } else {
            print("used j nai thayu hji");
            coupenFlat(cop: cop);
            return;
          }
        } else {
          print("email contain krti nathi");
          couponError();
          return;
        }
      } else {
        print("count limit pati gai che na vaprai");
        couponError();
        return;
      }
    } else if (usageLimit != null) {
      print("aa limit check kre che flat");
      if (usagecount! < cop[0].usageLimit!) {
        print("hji vapri sake che flat");
        if (cop[0].emailRestrictions!.isNotEmpty &&
            emailcheck!.contains(userEmail)) {
          print("email contain kre che flat");
          if (usedby!.isNotEmpty) {
            var i = 0;
            for (var item in cop[0].usedBy!) {
              if (item == userEmail.toString()) {
                i = i + 1;
              }
            }
            if (cop[0].usageLimitPerUser! > i) {
              print("vapri sake che");
              coupenFlat(cop: cop);
              return;
            } else {
              print("used kri lithu che ");
              couponError();
              return;
            }
          } else {
            print("used j nai thayu hji");
            coupenFlat(cop: cop);
            return;
          }
        } else if (cop[0].emailRestrictions!.isNotEmpty &&
            !emailcheck!.contains(userEmail)) {
          print("email che j pn match nathi thati flat ");
          couponError();
          return;
        } else {
          print("email res  ema nathi flat");
          coupenFlat(cop: cop);
          return;
        }
      } else {
        print("na chale flat");
        couponError();
      }
    } else if (cop[0].emailRestrictions!.isNotEmpty &&
        emailcheck!.contains(userEmail)) {
      print("usagelimit nthi pn email res che flat");
      if (usedby!.isNotEmpty) {
        print("usedby che flat");
        var i = 0;
        for (var item in cop[0].usedBy!) {
          if (item == userEmail.toString()) {
            i = i + 1;
          }
        }
        if (cop[0].usageLimitPerUser! > i) {
          print("vapri sake che");
          coupenFlat(cop: cop);
          return;
        } else {
          print("used kri lithu che ");

          couponError();
          return;
        }
      } else {
        print("used j nai thayu hji");
        coupenFlat(cop: cop);
        return;
      }
    } else if (cop[0].usageLimitPerUser != null) {
      print("aama user pr used krvani limit api che flat");
      if (usedby!.isNotEmpty) {
        print("usedby che flat ");
        var i = 0;
        for (var item in cop[0].usedBy!) {
          if (item == userEmail.toString()) {
            i = i + 1;
          }
        }
        if (cop[0].usageLimitPerUser! > i) {
          print("vapri sake che");
          coupenFlat(cop: cop);
          return;
        } else {
          print("used kri lithu che ");

          couponError();
          return;
        }
      } else {
        print("used j nai thayu hji khli limit che used per user flat");
        coupenFlat(cop: cop);
        return;
      }
    } else if (emailcheck!.isNotEmpty) {
      print("khli aa emails mate j used thse flat");
      if (emailcheck.contains(userEmail)) {
        coupenFlat(cop: cop);
        return;
      } else {
        couponError();
        return;
      }
    } else {
      print("badhu j khli che");
      coupenFlat(cop: cop);
      return;
    }
  }

  couponCheckPer({
    required List<CouponModel> cop,
    int? usageLimit,
    int? usagecount,
    List<String>? emailcheck,
    List<String>? usedby,
  }) {
    if (cop[0].usageLimit != null &&
        emailcheck!.isNotEmpty &&
        cop[0].usageLimitPerUser != null) {
      print("badhu j che ");
      if (usagecount! < cop[0].usageLimit!) {
        print(" exp nthi and vapri sakai che hji");
        if (emailcheck.contains(userEmail)) {
          print(" exp nthi and email contain kre che");
          if (usedby!.isNotEmpty) {
            var i = 0;
            for (var item in cop[0].usedBy!) {
              if (item == userEmail.toString()) {
                i = i + 1;
              }
            }
            if (cop[0].usageLimitPerUser! > i) {
              print("vapri sake che");
              couponPer(cop: cop);
              return;
            } else {
              print("used kri lithu che ");

              couponError();
              return;
            }
          } else {
            print("used j nai thayu hji");
            couponPer(cop: cop);
            return;
          }
        } else {
          print("email contain krti nathi");
          couponError();
          return;
        }
      } else {
        print("count limit pati gai che na vaprai");
        couponError();
        return;
      }
    } else if (usageLimit != null) {
      print("aa limit check kre che ");
      if (usagecount! < cop[0].usageLimit!) {
        print("hji vapri sake che ");
        if (cop[0].emailRestrictions!.isNotEmpty &&
            emailcheck!.contains(userEmail)) {
          print("email contain kre che ");
          if (usedby!.isNotEmpty) {
            var i = 0;
            for (var item in cop[0].usedBy!) {
              if (item == userEmail.toString()) {
                i = i + 1;
              }
            }
            if (cop[0].usageLimitPerUser! > i) {
              print("vapri sake che");
              couponPer(cop: cop);
              return;
            } else {
              print("used kri lithu che ");
              couponError();
              return;
            }
          } else {
            print("used j nai thayu hji");
            couponPer(cop: cop);
            return;
          }
        } else if (cop[0].emailRestrictions!.isNotEmpty &&
            !emailcheck!.contains(userEmail)) {
          print("email che j pn match nathi thati flat ");
          couponError();
          return;
        } else {
          print("email res  ema nathi flat");
          couponPer(cop: cop);
          return;
        }
      } else {
        print("na chale flat");
        couponError();
      }
    } else if (cop[0].emailRestrictions!.isNotEmpty &&
        emailcheck!.contains(userEmail)) {
      print("usagelimit nthi pn email res che ");
      if (usedby!.isNotEmpty) {
        print("usedby che ");
        var i = 0;
        for (var item in cop[0].usedBy!) {
          if (item == userEmail.toString()) {
            i = i + 1;
            print(i);
          }
        }

        if (cop[0].usageLimitPerUser == null) {
          print("user per limit j nthi ");
          couponPer(cop: cop);
          return;
        } else if (cop[0].usageLimitPerUser! > i) {
          print("vapri sake che");
          couponPer(cop: cop);
          return;
        } else {
          print("used kri lithu che ");

          couponError();
          return;
        }
      } else {
        print("used j nai thayu hji");
        couponPer(cop: cop);
        return;
      }
    } else if (cop[0].usageLimitPerUser != null) {
      print("aama user pr used krvani limit api che ");
      if (usedby!.isNotEmpty) {
        print("usedby che  ");
        var i = 0;
        for (var item in cop[0].usedBy!) {
          if (item == userEmail.toString()) {
            i = i + 1;
          }
        }
        if (cop[0].usageLimitPerUser! > i) {
          print("vapri sake che");
          couponPer(cop: cop);
          return;
        } else {
          print("used kri lithu che ");

          couponError();
          return;
        }
      } else {
        print("used j nai thayu hji khli limit che used per user ");
        couponPer(cop: cop);
        return;
      }
    } else if (emailcheck!.isNotEmpty) {
      print("khli aa emails mate j used thse");
      if (emailcheck.contains(userEmail)) {
        couponPer(cop: cop);
        return;
      } else {
        couponError();
        return;
      }
    } else {
      print("badhu j khli che");
      couponPer(cop: cop);
    }
  }

  couponPer({required List<CouponModel> cop}) {
    setState(() {
      var couponvalue1 = double.parse(cop[0].amount!);
      var dd = couponvalue1 / 100;
      finalprice = finalprice - shipvalue;
      couponvalue = (finalprice * dd as double).roundToDouble();

      finalprice = (finalprice - couponvalue as double).roundToDouble();

      // finalprice = finalprice + shipvalue;

      if (finalprice < 0 || finalprice == 0) {
        print("aa to minius ma che");
        couponvalue = double.parse(widget.price);
        finalprice = shipvalue;
      } else {
        gstCal(price: finalprice.toString());
      }

      coupencode = cop[0].code;
      coupenid = cop[0].id;

      _loading = false;
    });
  }

  coupenFlat({required List<CouponModel> cop}) {
    setState(() {
      var couponvalue1 = double.parse(cop[0].amount!);
      couponvalue = couponvalue1;
      finalprice = finalprice - shipvalue;

      finalprice = finalprice - couponvalue1;
      print("aaa che final  vado price coupon pachi $finalprice");
      gstCal(price: finalprice.toString());

      if (finalprice < 0 || finalprice == 0) {
        print("aa to minius ma che flat");
        couponvalue = double.parse(widget.price);
        finalprice = shipvalue;
      }

      coupencode = cop[0].code;
      coupenid = cop[0].id;
      print("aaa che final  vado price $finalprice");

      _loading = false;
    });
  }

  getShipping({required bool isgujju}) async {
    if (isgujju) {
      try {
        var ch = await CartData.shippingDatat(id: 2);
        print("gujju che niche");

        setState(() {
          shipvalue = int.parse(ch[0].settings!.cost!.value!);
          shippingid = ch[0].methodId!;
          shippingTitle = ch[0].methodTitle!;
          print("aa che final price shipping ma $finalprice");

          finalprice = gstvalue + shipvalue;
          _loading = false;
        });
      } catch (e) {
        Get.defaultDialog(
            title: "Ooops...",
            content: const Text("Somthing went wrong please try again"));
      }
    } else {
      try {
        var ch = await CartData.shippingDatat(id: 1);
        print("guuju nathi niche ");
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

        // print("aa check thse $com");

      } catch (e) {
        Get.defaultDialog(
            title: "Ooops...",
            content: const Text("Somthing went wrong please try again"));
      }
    }
  }

  couponcheck({required String code}) async {
    setState(() {
      _loading = true;
    });
    try {
      var cop = await CartData.couponCheck(code: code);
      var disType = cop[0].discountType;

      var usageLimit = cop[0].usageLimit;
      var emailcheck = cop[0].emailRestrictions;

      // var limitperuser = cop[0].usageLimitPerUser;

      var usedby = cop[0].usedBy;
      // var usedby = [
      //   'jayveersinh.ecareinfoway@gmail.com',
      // ];
      var usagecount = cop[0].usageCount;

      print(disType);

      if (cop[0].dateExpires != null) {
        var now = DateTime.now();
        var check = now.isBefore(DateTime.parse(cop[0].dateExpires));

        if (cop.isEmpty || !check) {
          setState(() {
            _loading = false;
          });
          Get.snackbar(
            "Expired Coupon",
            "This coupon has expired. ",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        } else if (disType == "percent") {
          couponCheckPer(
            cop: cop,
            usageLimit: usageLimit,
            usagecount: usagecount,
            emailcheck: emailcheck,
            usedby: usedby,
          );
          ///////////////////
        } else {
          print("fixed cart");
          couponCheckFlat(
            cop: cop,
            usageLimit: usageLimit,
            usagecount: usagecount,
            emailcheck: emailcheck,
            usedby: usedby,
          );
        }
      } else {
        print("expired vagar nu che");
        if (disType == "percent") {
          print("percentage vadu che ");
          couponCheckPer(
            cop: cop,
            usageLimit: usageLimit,
            usagecount: usagecount,
            emailcheck: emailcheck,
            usedby: usedby,
          );
        } else {
          print("flat amount   che ");
          couponCheckFlat(
            cop: cop,
            usageLimit: usageLimit,
            usagecount: usagecount,
            emailcheck: emailcheck,
            usedby: usedby,
          );
        }
      }
    } catch (e) {
      print("aa error vado block che $e");

      // print("aa error che $e");
      couponError();
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
      shippingLines: [
        ShippingLines(
          methodId: shippingid,
          methodTitle: shippingTitle,
          total: shipvalue.toString(),
        ),
      ],
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
                                      "Shipping $shippingTitle",
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
