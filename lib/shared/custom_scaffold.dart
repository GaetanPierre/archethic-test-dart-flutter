import 'package:flutter/material.dart';

import 'custom_app_bar.dart';
import 'custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const CustomScaffold({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title
      ),
      drawer: const CustomDrawer(),
      body: body,
    );
    }
}