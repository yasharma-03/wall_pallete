import 'package:flutter/material.dart';

class CostumAppBar extends StatelessWidget {
  const CostumAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
  textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: "WALL",
              style: TextStyle(color: Colors.orangeAccent,
              fontSize: 23,
                fontWeight: FontWeight.w600,
              )),

              TextSpan(text: "Pallete",
              style: TextStyle(color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ))
            ]
          )

      ),
    );
  }
}

