import 'package:flutter/material.dart';

class SpaceSizedWidthBox extends StatelessWidget {
  const SpaceSizedWidthBox({Key? key, required this.width})
      : assert(width > 0 && width <= 1),
        super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.width * width);
}
