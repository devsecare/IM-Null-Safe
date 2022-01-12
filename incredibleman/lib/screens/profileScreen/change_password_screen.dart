import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/screens/widgetHelper/loading_screen.dart';

class ChangePassword extends StatefulWidget {
  final WooCustomer user;
  const ChangePassword({Key? key, required this.user}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Change Your Password"),
        ),
        body: _loading
            ? LoadingScreen(
                body: _body(),
              )
            : _body(),
      ),
    );
  }

  Widget _body() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const SizedBox(
            height: 35.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10.0, bottom: 1.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                " Enter New Password",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 5, bottom: 10.0),
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextFormField(
              controller: _newPassword,
              // initialValue: widget.user.firstName,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter new password";
                }
                return null;
              },
              // controller: _username,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter new password',
                hintText: '',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10.0, bottom: 1.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Confirm password",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 5, bottom: 10.0),
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextFormField(
              controller: _confirm,

              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Confirm password";
                }
                return null;
              },
              // controller: _username,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Confirm password',
                hintText: '',
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: tabColor,
              textStyle: GoogleFonts.poppins(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.all(8.0),
              minimumSize: const Size(335, 50),
            ),
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                setState(() {
                  _loading = true;
                });
                WooCustomer customer = WooCustomer(
                  id: widget.user.id,
                  email: widget.user.email,
                  lastName: widget.user.lastName,
                  password: _confirm.text,
                );

                await CartData.wooCommerce.oldUpdateCustomer(
                  wooCustomer: customer,
                );
                setState(() {
                  _loading = false;
                });
                Get.snackbar(
                  "password changed",
                  "Your Password has been updated ",
                  colorText: Colors.white,
                  backgroundColor: Colors.black,
                );
              }
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
