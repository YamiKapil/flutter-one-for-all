import 'package:flutter/material.dart';
import 'package:one_for_all/common_components/animated_list_item.dart';

class InitialAnimatedListView extends StatelessWidget {
  final int index;
  const InitialAnimatedListView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        children: List.generate(
          index,
          (index) => AnimatedListItem(index,key:ValueKey<int>(index)),
        ),
      ),
    );
  }
}
