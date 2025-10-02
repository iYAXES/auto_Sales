import 'package:auto_sales/admin/screens/home_screen.dart';
import 'package:auto_sales/providers/cart_provider.dart';
import 'package:auto_sales/providers/product_provider.dart';
import 'package:auto_sales/shared/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAllProducts = ref.watch(productsProvider);
    final cartProducts = ref.watch(cartProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Garage Sales'),
        backgroundColor: Colors.grey[300],
        actions: [
          CartIcon(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminHome()),
              );
            },
            icon: Icon(Icons.admin_panel_settings_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: asyncAllProducts.when(
          data: (allProducts) {
            return GridView.builder(
              itemCount: allProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.blueGrey.withValues(alpha: .07),
                  child: Column(
                    children: [
                      allProducts[index].imageUrl.isNotEmpty
                          ? Image.asset(
                              allProducts[index].imageUrl,
                              height: 60,
                              width: 60,
                            )
                          : Icon(Icons.image_not_supported, size: 60),

                      Text(
                        allProducts[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\$${allProducts[index].price}'),

                      if (cartProducts.contains(allProducts[index]))
                        TextButton(
                          onPressed: () {
                            ref
                                .read(cartProductsProvider.notifier)
                                .removeFromCart(allProducts[index]);
                          },
                          child: Text('remove'),
                        ),
                      if (!cartProducts.contains(allProducts[index]))
                        TextButton(
                          onPressed: () {
                            ref
                                .read(cartProductsProvider.notifier)
                                .addToCart(allProducts[index]);
                          },
                          child: Text('add to cart'),
                        ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text('Unable to Load data from Store $error')),
        ),
      ),
    );
  }
}
