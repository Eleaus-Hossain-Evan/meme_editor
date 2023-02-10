import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/text_theme_style_x.dart';

class KLoader extends StatelessWidget {
  const KLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: context.theme.primaryColorLight,
      size: 50.0,
    );
  }
}
