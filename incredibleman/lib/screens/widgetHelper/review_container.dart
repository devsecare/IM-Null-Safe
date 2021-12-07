import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibleman/constants/constants.dart';

class ReviewContainer extends StatelessWidget {
  final String? img;
  final String? name;
  final String? reviews;
  final int? rate;
  final String? date;
  const ReviewContainer(
      {Key? key, this.img, this.name, this.reviews, this.rate, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      // height: 160,
      width: width,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  img!,
                  scale: 0.5,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RatingBar(
                      itemCount: 5,
                      itemSize: 18.0,
                      initialRating: rate!.toDouble(),
                      allowHalfRating: false,
                      unratedColor: Colors.black,
                      ignoreGestures: true,
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: tabColor,
                        ),
                        half: const Icon(
                          Icons.star,
                          color: tabColor,
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: Colors.black45,
                        ),
                      ),
                      onRatingUpdate: (r) {})
                ],
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 23.0,
          ),
          Text(
            reviews!,
            style: GoogleFonts.poppins(
              fontSize: 13.0,
            ),
            overflow: TextOverflow.clip,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                date!,
                style: GoogleFonts.poppins(
                  fontSize: 13.0,
                  color: Colors.black45,
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 6.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
