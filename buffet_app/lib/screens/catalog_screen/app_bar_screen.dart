import 'package:flutter/material.dart';

import '../debt_screen/debt_screen.dart';

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126.5,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/Rectangle1.png",
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 33,
              child: Image.asset(
                "assets/images/Rectangle2.png",
                width: 135,
              )),
          Positioned(
              left: 5,
              top: 42.5,
              child: Image.asset(
                "assets/images/itlogo.png",
                width: 120,
              )),
          Positioned(
              right: 20,
              top: 25,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Debt();
                    },
                  );
                },
                child: Image.asset(
                  "assets/images/money-bag1.png",
                  width: 30,
                ),
              )),
        ],
      ),
    );
  }
}
