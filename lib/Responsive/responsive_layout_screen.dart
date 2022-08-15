import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // Web Screen (if maxwidth greater than 600)
          return webScreenLayout;
        } else {
          // Mobile Screen (if maxwidth less than 600)
          return mobileScreenLayout;
        }
      },
    );
  }
}
