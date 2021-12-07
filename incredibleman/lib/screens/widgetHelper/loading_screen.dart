import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Widget body;
  const LoadingScreen({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        body,
        Container(
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(
            color: Colors.white70,
          ),
          child: Container(
            // decoration: new BoxDecoration(
            //     color: Colors.white70,
            //     borderRadius: new BorderRadius.circular(10.0)),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: const Center(
                    child: Text(
                      "loading.. wait...",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
