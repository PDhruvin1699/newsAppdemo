import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerLoader extends StatelessWidget {
  const AppShimmerLoader({
    key,
    this.width,
    this.height,
    this.shape,
    this.baseColor,
    this.highlightColor,
    this.borderRadius,
    this.child,
    this.shimmerDuration = const Duration(seconds: 2),
  });

  final double? width;
  final double? height;
  final BoxShape? shape;
  final Color? baseColor;
  final Color? highlightColor;
  final BorderRadius? borderRadius;
  final Widget? child;
  final Duration shimmerDuration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Theme.of(context).scaffoldBackgroundColor.withOpacity(.3),
        highlightColor: highlightColor != null ? highlightColor! : Colors.grey[200]!,
        period: shimmerDuration,
        child: child ??
            Container(
              decoration: BoxDecoration(
                shape: shape ?? BoxShape.rectangle,
                color: Colors.grey[300]!,
              ),
            ),
      ),
    );
  }
}
