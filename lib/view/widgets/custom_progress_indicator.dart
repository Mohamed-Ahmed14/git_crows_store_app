import 'package:flutter/material.dart';

import '../../view_model/utilities/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomProgressIndicator({this.color,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color?? Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}
