import 'dart:math';

import 'package:flutter/material.dart';

import 'customClipper.dart';

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({Key key, this.func}) : super(key: key);

  final Function func;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: -pi / 1,
      child: ClipPath(
          clipper: ClipPainter(),
          child: InkWell(
            splashColor: Colors.transparent,
            enableFeedback: true,
            highlightColor: Colors.transparent,
            onTap: () {
              func();
            },
            child: Container(
              color: Colors.amber[800],
              height: 120,
              width: MediaQuery.of(context).size.width,
            ),
          )),
    ));
  }
}
