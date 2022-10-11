import 'package:flutter/material.dart';
import 'package:one_for_all/common_components/navigation_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('One For All'),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: listOfScreens,
        // ),
        child: GridView.builder(
          itemCount: listOfScreens.length,
          shrinkWrap: true,
          gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: listOfScreens[index],
          ),
        ),
      ),
    );
  }
}
