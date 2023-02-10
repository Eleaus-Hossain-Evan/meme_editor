
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final scaffoldKeyProvider = Provider<GlobalKey<ScaffoldMessengerState>>((ref) {
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  return snackbarKey;
});

final snackBarProvider = Provider.family<
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason>,
    String>((ref, String text) {
  final snackbar = ref.watch(scaffoldKeyProvider).currentState!.showSnackBar(
        SnackBar(content: Text(text)),
      );
  return snackbar;
});
