import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';

class OrderContainer extends StatelessWidget {
  final String url, name, shortname, price, qun;
  final VoidCallback minus;
  final VoidCallback inc;
  final VoidCallback remove;
  final VoidCallback wishList;
  final Widget ic;
  final bool sample;
  const OrderContainer(
      {Key? key,
      required this.url,
      required this.name,
      required this.shortname,
      required this.price,
      required this.qun,
      required this.minus,
      required this.inc,
      required this.remove,
      required this.wishList,
      required this.ic,
      required this.sample})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height / 3.35,
      width: width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: height / 7.2,
                width: width / 3.5,
                decoration: BoxDecoration(
                  color: bgcontainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(
                  url,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              SizedBox(
                width: width / 1.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      shortname,
                      style: GoogleFonts.poppins(
                        color: Colors.black38,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Visibility(
                      visible: sample,
                      child: Container(
                        width: width / 2.70,
                        height: height / 19,
                        decoration: BoxDecoration(
                          color: bgcontainer,
                          borderRadius: BorderRadius.circular(55.0),
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: minus,
                              child: const Text(
                                "−",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Text(qun),
                            TextButton(
                              onPressed: inc,
                              child: const Text(
                                "+",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      rupee + price,
                      style: GoogleFonts.poppins(
                        color: tabColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Divider(
            thickness: 1,
            color: Colors.black12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                  onPressed: remove,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.black38,
                  ),
                  label: Text(
                    "REMOVE",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Visibility(
                visible: sample,
                child: const SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    color: Colors.black38,
                    // width: 1.0,
                    thickness: 1,
                  ),
                ),
              ),
              Visibility(
                visible: sample,
                child: TextButton.icon(
                    onPressed: wishList,
                    icon: ic,
                    label: Text(
                      "ADD TO WISHLIST",
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
