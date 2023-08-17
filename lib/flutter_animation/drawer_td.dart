import 'package:flutter/material.dart';

class DrawerThreeD extends StatefulWidget {
  const DrawerThreeD({super.key});

  @override
  State<DrawerThreeD> createState() => _DrawerThreeDState();
}

class _DrawerThreeDState extends State<DrawerThreeD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Drawer 3D'),
        ),
        body: Container());
  }
}

class MyDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  const MyDrawer({
    super.key,
    required this.child,
    required this.drawer,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
