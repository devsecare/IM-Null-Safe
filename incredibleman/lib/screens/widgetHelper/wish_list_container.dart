import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';

class WishListContainer extends StatelessWidget {
  final VoidCallback? details;
  final VoidCallback? like;
  final String? image;
  final String? dec;
  final String? dec2;
  final String? price;
  final String? tag;
  const WishListContainer(
      {Key? key,
      this.details,
      this.like,
      this.image,
      this.dec,
      this.dec2,
      this.price,
      this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                  width: width / 2,
                  height: height / 3.5,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Image.asset(logoloader);
                  },
                ),
              ),
              Positioned(
                left: width / 3,
                top: 8.0,
                child: InkWell(
                  onTap: like,
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 20.5,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 20.0,
                    ),
                  ),
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
                dec ?? "₹6000",
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
                      dec2 ?? "",
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff898989),
                      ),
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
