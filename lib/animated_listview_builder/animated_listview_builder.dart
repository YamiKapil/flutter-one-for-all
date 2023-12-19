import "package:flutter/material.dart";

class AnimatedListViewBuilder extends StatefulWidget {
  const AnimatedListViewBuilder({super.key});

  @override
  State<AnimatedListViewBuilder> createState() =>
      _AnimatedListViewBuilderState();
}

class _AnimatedListViewBuilderState extends State<AnimatedListViewBuilder> {
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items
  List<int> _items = [];

  /// This holds the item count
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated ListView'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AnimatedList(
              key: listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return slideIt(context, index, animation);
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.greenAccent),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      listKey.currentState?.insertItem(0,
                          duration: const Duration(milliseconds: 500));
                      _items = [counter++, ..._items];
                    });
                  },
                  child: const Text(
                    "Add item to first",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_items.length <= 1) return;
                    listKey.currentState?.removeItem(
                        0, (_, animation) => slideIt(context, 0, animation),
                        duration: const Duration(milliseconds: 500));
                    setState(() {
                      _items.removeAt(0);
                    });
                  },
                  child: const Text(
                    "Remove first item",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget slideIt(BuildContext context, int index, animation) {
    int item = _items[index];
    TextStyle? textStyle = Theme.of(context).textTheme.headlineMedium;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: SizedBox(
        // Actual widget to display
        height: 100.0,
        child: Card(
          color: Colors.primaries[item % Colors.primaries.length],
          child: Center(
            child: Text('Item $item', style: textStyle),
          ),
        ),
      ),
    );
  }
}
