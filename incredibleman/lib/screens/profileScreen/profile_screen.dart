import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/providers/providerdata.dart';
import 'package:incredibleman/providers/woocommerceModels/woo_customer.dart';

import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  final WooCustomer user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _dd = TextEditingController();
  final TextEditingController _mm = TextEditingController();
  final TextEditingController _yyyy = TextEditingController();
  bool editbirthday = false;
  late DateTime selectedDate;
  late List birthday;
  bool _loading = false;

  getBirthDay() {
    birthday = widget.user.metaData!
        .where((element) => element.key == "birthday_field")
        .toList();
  }

  @override
  void initState() {
    getBirthDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile Details"),
        toolbarHeight: 70.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 6,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: height / 15,
                    left: width / 3,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: bgcontainer,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        size: 70.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Form(
              key: _formkey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10.0, bottom: 1.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Username",
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
                          controller: _username..text = widget.user.username!,
                          // initialValue: widget.user.firstName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Username";
                            }
                            return null;
                          },

                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Username',
                              hintText: ''),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10.0, bottom: 1.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email address",
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
                          controller: _email..text = widget.user.email!,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
                            }
                            return null;
                          },
                          // controller: _username,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter email',
                            hintText: '',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10.0, bottom: 1.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Birthday ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              birthday.isBlank!
                                  ? Container()
                                  : Text(
                                      "${birthday[0].value ?? ""}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: tabColor,
                                      ),
                                    ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    editbirthday = true;
                                  });
                                },
                                child: Text("Edit",
                                    style: GoogleFonts.poppins(
                                      color: tabColor,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: editbirthday,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 10.0),
                          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.amber,
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(7.0)),
                            child: Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return "Day";
                                  //   }
                                  //   return null;
                                  // },
                                  maxLength: 2,
                                  controller: _dd,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 30,
                                    ),
                                    counterText: "",
                                    hintText: "DD",
                                    border: InputBorder.none,
                                  ),
                                )),
                                const SizedBox(
                                  height: 50,
                                  child: VerticalDivider(),
                                ),

                                Expanded(
                                    child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return "Month";
                                  //   }
                                  //   return null;
                                  // },
                                  controller: _mm,
                                  maxLength: 2,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 30,
                                    ),
                                    counterText: "",
                                    hintText: "MM",
                                    border: InputBorder.none,
                                  ),
                                )),
                                const SizedBox(
                                  height: 50,
                                  child: VerticalDivider(),
                                ),
                                Expanded(
                                    child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _yyyy,
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return "Year";
                                  //   }
                                  //   return null;
                                  // },
                                  maxLength: 4,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 30,
                                    ),
                                    hintText: "YYYY",
                                    counterText: "",
                                    border: InputBorder.none,
                                  ),
                                )),
                                // Container(child: TextField()),
                                // Container(child: TextField()),
                                // TextField(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10.0, bottom: 1.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Mobile number",
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
                          controller: _mobile
                            ..text = widget.user.billing!.phone!,
                          validator: (value) {
                            if (value!.isEmpty && value.isNumericOnly) {
                              return "Please enter mobile";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          maxLength: 10,

                          // controller: _username,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter mobile number',
                              counterText: "",
                              hintText: ''),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Get.to(() => ChangePassword(
                      user: widget.user,
                    ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(
                  width: 1.0,
                  color: tabColor,
                ),
                padding: const EdgeInsets.all(8.0),
                minimumSize: Size(width / 1.16, 50),
              ),
              child: const Text(
                "CHANGE PASSWORD",
                style: TextStyle(color: tabColor),
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
                minimumSize: Size(width / 1.16, 50),
              ),
              onPressed: () async {
                // this is request to update profile details of user on backend
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    _loading = true;
                  });

                  try {
                    WooCustomer updateCustomer = WooCustomer(
                      id: widget.user.id,
                      email: widget.user.email,
                      metaData: [
                        WooCustomerMetaData(widget.user.id, "birthday_field",
                            "${_yyyy.text} - ${_mm.text} -${_dd.text}")
                      ],
                      billing: Billing(phone: _mobile.text),
                    );
                    await CartData.wooCommerce.oldUpdateCustomer(
                      wooCustomer: updateCustomer,
                    );

                    Get.snackbar(
                      "Updated User Detail",
                      "Your Details has been updated ",
                      colorText: Colors.white,
                      backgroundColor: Colors.black,
                    );
                    setState(() {
                      _loading = false;
                    });
                  } catch (e) {
                    Get.defaultDialog(
                      title: "Ooops...",
                      content:
                          const Text("something Went Wrong Please Try Again"),
                    );
                    setState(() {
                      _loading = false;
                    });
                  }
                  setState(() {
                    _loading = false;
                  });
                }
              },
              icon: const Icon(Icons.arrow_forward),
              label: _loading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text("Save"),
            ),
            const SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    ));
  }
}
