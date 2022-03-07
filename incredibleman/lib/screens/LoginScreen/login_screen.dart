import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/screens/Home/home.dart';
import 'package:incredibleman/screens/SignUpScreen/signup_screen.dart';
import 'package:incredibleman/screens/widgetHelper/loading_screen.dart';
import 'package:url_launcher/url_launcher.dart';

// this is login screen where login and validations task will be performed
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  bool _hide = true;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: _loading
              ? LoadingScreen(
                  body: _body(width, height),
                )
              : _body(width, height)),
    );
  }

  Widget _body(width, height) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height / 2.15,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  loginbg,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 85.0,
                ),
                Image.asset(
                  loginlogo,
                  width: 150,
                ),
                const SizedBox(
                  height: 55.0,
                ),
                Text(
                  "Welcome",
                  style: GoogleFonts.poppins(
                    fontSize: 35.0,
                    color: const Color(0xFfF0B26C),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  "Sign in to continue",
                  style: GoogleFonts.poppins(
                    fontSize: 25.0,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
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
                  return "Please check email";
                }
                return null;
              },
              controller: _username,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter email',
                hintText: 'Enter username',
              ),
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
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter password";
                }
                return null;
              },
              controller: _password,
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
                hintText: 'Enter secure password',
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: tabColor,
                textStyle: GoogleFonts.poppins(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.all(8.0),
                minimumSize: Size(width / 1.18, 50),
              ),
              onPressed: () async {
                // here the post request will execute and reture user from api
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    _loading = true;
                  });

                  var user = await CartData.wooCommerce.loginCustomer(
                    username: _username.text,
                    password: _password.text,
                  );
                  // print("aaa user che $user");
                  if (user.runtimeType == String || user == null) {
                    setState(() {
                      _loading = false;
                    });
                    Get.defaultDialog(
                      title: "Alert!",
                      middleText:
                          "The username or Password You entered is incorrect please try again ",
                      onConfirm: () {
                        Navigator.pop(context);
                      },
                      textConfirm: "Ok",
                    );
                  } else {
                    setState(() {
                      _loading = false;
                    });
                    Get.offAll(() => const HomeScreen());
                  }
                }
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("LOGIN"),
            ),
          ),
          // _loading ? CircularProgressIndicator() : Container(),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 0, bottom: 10.0),
            child: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: tabColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SignUpScreen()));
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: tabColor,
                  ),
                  onPressed: () {
                    _launchURL(
                        "https://www.incredibleman.in/my-account/lost-password/");
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     Navigator.push(context,
          //         CupertinoPageRoute(builder: (context) => SignUpScreen()));
          //   },
          //   icon: const Icon(Icons.login),
          //   label: const Text("signUp"),
          // ),
        ],
      )),
    );
  }
}
