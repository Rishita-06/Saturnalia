import 'package:flutter/material.dart';

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 35);
    path.lineTo(size.width - 120, size.height - 35);
    path.lineTo(size.width - 150, size.height);
    path.lineTo(size.width - 50, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomPath2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(26, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height - 35);
    // path.lineTo(size.width - 120, size.height - 35);
    // path.lineTo(size.width - 150, size.height);
    // path.lineTo(size.width - 50, size.height);
    // path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
