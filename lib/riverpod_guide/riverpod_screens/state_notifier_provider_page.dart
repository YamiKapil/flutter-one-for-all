import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_for_all/riverpod_guide/riverpod_data/cart_state_notifier.dart';
import 'package:one_for_all/riverpod_guide/riverpod_model/product_model.dart';

class StateNotifierProviderPage extends ConsumerWidget {
  const StateNotifierProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartStateNotifier = ref.watch(cartStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    // show a dialog with the cart contents
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Cart'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // show the cart contents
                              ...cartStateNotifier.map((e) => Text(e.title)),
                              const SizedBox(height: 16),
                              // sum the total price of the cart
                              Text(
                                'Total: \$${cartStateNotifier.fold<double>(0, (previousValue, element) => previousValue + element.price)}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                //clear the cart
                                ref
                                    .read(cartStateNotifierProvider.notifier)
                                    .clearCart();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Clear'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                //badge
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cartStateNotifier.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    onPressed: () {
                      // add the product to the cart
                      ref
                          .read(cartStateNotifierProvider.notifier)
                          .addProduct(product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
