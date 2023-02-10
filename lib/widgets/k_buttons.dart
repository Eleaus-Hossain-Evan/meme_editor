import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/utils.dart';
import 'widgets.dart';

class FlatButtonWithIcon extends TextButton {
  FlatButtonWithIcon({
    Key? key,
    required VoidCallback onPressed,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    Color? textColor,
    required Widget icon,
    required Widget label,
  }) : super(
          key: key,
          onPressed: onPressed,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          style: textColor != null
              ? ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: textColor),
                ))
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon,
              const SizedBox(height: 5.0),
              label,
            ],
          ),
        );
}

class KElevatedButton extends HookConsumerWidget {
  const KElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.loading,
  }) : super(key: key);

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  final bool? loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: paddingH20,
      child: ElevatedButton(
        style: ButtonStyle(
          // shape: MaterialStateProperty.all(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.r),
          //   ),
          // ),
          minimumSize: MaterialStateProperty.all(Size.fromHeight(48.h)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
        ),
        onPressed: onPressed,
        child: (loading != null && loading!)
            ? SizedBox(
                height: 30.h,
                width: 30.h,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    foregroundColor ?? context.color.secondary,
                  ),
                ),
              )
            : Text(
                text,
                style: context.button.copyWith(
                  color: foregroundColor ?? context.color.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
      ),
    );
  }
}

class KIconElevatedButton extends HookConsumerWidget {
  const KIconElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.loading = false,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final bool? loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        // shape: MaterialStateProperty.all(
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.r),
        //   ),
        // ),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(55.h)),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
      ),
      onPressed: onPressed,
      child: (loading != null && loading!)
          ? SizedBox(
              height: 30.h,
              width: 30.h,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          : Row(
              children: [
                Expanded(child: Center(child: Text(text))),
                Material(
                  elevation: 4,
                  color: backgroundColor ?? Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(100.r),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: icon,
                  ),
                ),
              ],
            ),
    );
  }
}

class KOutlinedButton extends HookConsumerWidget {
  const KOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.loading,
  }) : super(key: key);

  final String text;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final ValueNotifier<bool>? loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {},
      child: OutlinedButton(
        style: ButtonStyle(
          // shape: MaterialStateProperty.all(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.r),
          //   ),
          // ),
          minimumSize: MaterialStateProperty.all(Size.fromHeight(55.h)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
        ),
        onPressed: onPressed,
        child: (loading != null && loading!.value)
            ? SizedBox(
                height: 30.h,
                width: 30.h,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    foregroundColor ?? Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: foregroundColor ??
                          Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
              ),
      ),
    );
  }
}

class KTextButton extends StatelessWidget {
  const KTextButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.borderRadius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
    this.style,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(padding),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
        ),
        onPressed: () => onPressed,
        child: child);
  }
}
