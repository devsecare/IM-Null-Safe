// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';

class SearchContainer extends StatelessWidget {
  final String? price, image;
  final String? dec, dec2;
  final VoidCallback? details;
  final Icon? icon;
  const SearchContainer(
      {Key? key,
      required this.price,
      required this.image,
      this.dec,
      this.dec2,
      this.details,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: bgcontainer,
          ),
          child: Stack(
            children: [
              GestureDetector(
                onTap: details,
                child: Image.network(
                  image!,
                  // fit: BoxFit.cover,
                  width: 200.0,
                  height: 250,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Image.asset(logoloader);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                dec ?? "product name",
                style: titletyle,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            dec2 == null
                ? const SizedBox()
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      dec2 ?? "product dec",
                      style:
                          GoogleFonts.poppins(color: const Color(0xfff0F0E0F)),
                      // style: pricestyle,
                    ),
                  ),
            const SizedBox(
              height: 5.0,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "₹$price",
                style: pricestyle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
