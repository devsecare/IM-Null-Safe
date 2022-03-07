import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';
import 'package:incredibleman/screens/Home/home.dart';
import 'package:incredibleman/screens/widgetHelper/loading_screen.dart';

// this is screen for signup to user
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _loading = false;
  bool _hide = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _firstname = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(),
        body: _loading
            ? LoadingScreen(body: _body(height, width))
            : _body(height, width),
      ),
    );
  }

  Widget _body(height, width) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: height / 3.5,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  signupbg,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height / 16.50,
                ),
                Image.asset(
                  loginlogo,
                  scale: 4.5,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Register",
                  style: GoogleFonts.poppins(
                    fontSize: 30.0,
                    color: const Color(0xFfF0B26C),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10.0, bottom: 1.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "FirstName",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 0, bottom: 10.0),
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter firstname';
                }
                return null;
              },
              controller: _firstname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Firstname',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10.0, bottom: 1.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "LastName",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 0, bottom: 10.0),
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Lastname';
                }
                return null;
              },
              controller: _lastname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Lastname',
                hintText: '',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10.0, bottom: 1.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Email",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 0, bottom: 10.0),
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
              controller: _email,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter email',
                  hintText: ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10.0, bottom: 1.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Password",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            // padding: const EdgeInsets.only(
            //     left: 15.0, right: 15.0, top: 15, bottom: 0),
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 0, bottom: 10.0),
            child: TextFormField(
              controller: _password,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              obscureText: _hide,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hide = !_hide;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                      )),
                  border: const OutlineInputBorder(),
                  labelText: 'Enter Password',
                  hintText: 'Enter secure password'),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: tabColor,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  minimumSize: Size(width / 1.18, 50)),
              onPressed: () async {
                // here is the request  to sign up will happend

                if (_formkey.currentState!.validate()) {
                  setState(() {
                    _loading = true;
                  });
                  WooCustomer customer = WooCustomer(
                    firstName: _firstname.text,
                    lastName: _lastname.text,
                    username: _firstname.text,
                    email: _email.text,
                    password: _password.text,
                  );
                  try {
                    await CartData.wooCommerce
                        .createCustomer(customer)
                        .then((value) async {
                      if (value == true) {
                        await CartData.wooCommerce.loginCustomer(
                          username: _firstname.text,
                          password: _password.text,
                        );
                        setState(() {
                          _loading = false;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false,
                          );
                        });
                      }
                    });
                    // ignore: unused_catch_clause
                  } on Exception catch (e) {
                    /// here error is check
                    setState(() {
                      _loading = false;
                    });
                    Get.defaultDialog(
                        title: "Alert!", middleText: " User already exists");
                  }
                }
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("REGISTER"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: tabColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
