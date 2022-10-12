import 'package:flutter/material.dart';
import 'package:one_for_all/responsive_row/child_size_notifier.dart';

class ResponsiveRow extends StatefulWidget {
  const ResponsiveRow({super.key});

  @override
  State<ResponsiveRow> createState() => _ResponsiveRowState();
}

class _ResponsiveRowState extends State<ResponsiveRow> {
  double? height;
  double? width;

  // getSize() {
  //   setState(() {
  //     height = _key1.currentContext?.size?.height;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // log(height.toString(), name: 'first height');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Row'),
      ),
      body: Container(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  // getSize();
                },
                child: ChildSizeNotifier(
                  builder: (context, size, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // Add Your Code here.
                      setState(() {
                        height = size.height;
                        width = size.width;
                      });
                    });
                    return Container(
                      // height: double.infinity,
                      // constraints: BoxConstraints.expand(),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.ramen_dining),
                          Text(
                              'Hello t there is lsdjflsd flsd  or is it?'),
                        ],
                      ),
                    );
                  },
                  // child: SizedBox.shrink(),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // height: double.infinity,
                  height: height,
                  width: width,
                  // constraints: BoxConstraints.expand(),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ramen_dining),
                      const Text('Hello there'),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                // height: double.infinity,
                height: height,
                width: width,
                // constraints: BoxConstraints.expand(),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.ramen_dining),
                    const Text('Hello there'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
