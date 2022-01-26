import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/user_provider.dart';
import '../utils/global_variables_util.dart';

class ResponsiveScreenLayout extends StatefulWidget {
  const ResponsiveScreenLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  State<ResponsiveScreenLayout> createState() => _ResponsiveScreenLayoutState();
}

class _ResponsiveScreenLayoutState extends State<ResponsiveScreenLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  Future<void> addData() async {
    final _userProvider = Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUsername();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive Layout
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // Web Screen
          return widget.webScreenLayout;
        }
        // Mobile Screen
        return widget.mobileScreenLayout;
      },
    );
  }
}
