import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), actions: [
      IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.home)),
    ]);
  }
}
