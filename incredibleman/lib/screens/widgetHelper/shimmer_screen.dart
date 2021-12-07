import 'package:flutter/material.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Shimmer.fromColors(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                // color: bgcontainer,
                height: height / 7,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Hive.box(FavList).clear();
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: bgcontainer,
                                blurRadius: 1.0,
                                offset: Offset(
                                  1.5,
                                  1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height: height / 3.1,
                  width: width,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Text(
                      " Best Selling ",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        " See all",
                      ),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.48,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 350,
                    width: 450,
                    color: Colors.white,
                  );
                },
                itemCount: 16,
              ),
            ],
          ),
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
    );
  }
}
