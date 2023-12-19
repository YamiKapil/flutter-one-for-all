import 'package:flutter/material.dart';

class ShopingCartButton extends StatefulWidget {
  const ShopingCartButton({super.key});

  @override
  State<ShopingCartButton> createState() => _ShopingCartButtonState();
}

class _ShopingCartButtonState extends State<ShopingCartButton> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart Button'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 650),
            width: !isExpanded ? 80 : 180,
            height: 60,
            decoration: BoxDecoration(
              color: !isExpanded ? Colors.blue : Colors.green,
              borderRadius: BorderRadius.circular(!isExpanded ? 10 : 30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  !isExpanded ? Icons.shopping_cart : Icons.check,
                  color: Colors.white,
                ),
                if (isExpanded)
                  const Flexible(
                    child: Text(
                      'Added to Cart',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
