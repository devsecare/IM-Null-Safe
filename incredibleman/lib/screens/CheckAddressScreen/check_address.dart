import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/carttestModel/cartbox.dart';
// import 'package:incredibleman/providers/woocommerceModels/woo_create_order.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/screens/EditAddressScreen/edit_address_screen.dart';
import 'package:incredibleman/screens/SummaryScreen/summary_screen.dart';

// this screen will check the address
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
            "Proceed to Payment",
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
                // print("tile click");
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
          ],
        ),
      ),
    );
  }
}
