import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_app_bar.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('UCO Token price'),
              onTap: () {
                // Update the state of the app
                context.go('/uco-price');
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
     );
    }
}