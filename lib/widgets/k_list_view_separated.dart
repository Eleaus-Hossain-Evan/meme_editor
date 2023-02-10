import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KListViewSeparated extends StatelessWidget {
  const KListViewSeparated({
    Key? key,
    this.shrinkWrap = false,
    this.physics = const BouncingScrollPhysics(),
    required this.builder,
    this.separator,
    required this.count,
    this.scrollDirection = Axis.vertical,
    this.gap = 10,
    this.controller,
    this.edgePadding,
    this.padding,
  }) : super(key: key);

  final bool shrinkWrap;
  final ScrollPhysics physics;
  final Widget Function(BuildContext context, int index) builder;
  final Widget? separator;
  final int count;
  final Axis scrollDirection;
  final double gap;
  final ScrollController? controller;
  final double? edgePadding;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: padding ??
          (scrollDirection == Axis.vertical
              ? EdgeInsets.symmetric(
                  vertical: edgePadding ?? gap.h, horizontal: 10.w)
              : EdgeInsets.symmetric(
                  horizontal: edgePadding ?? gap.w, vertical: 10.h)),
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemBuilder: builder,
      controller: controller,
      separatorBuilder: (context, index) {
        return separator ??
            (scrollDirection == Axis.vertical
                ? SizedBox(
                    height: gap.h,
                  )
                : SizedBox(
                    width: gap.w,
                  ));
      },
      itemCount: count,
    );
  }
}
