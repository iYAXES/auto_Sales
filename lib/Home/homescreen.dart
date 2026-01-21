
import 'package:auto_sales/provider/cart_products.dart';
import 'package:auto_sales/provider/product_list.dart';
import 'package:auto_sales/shared/admin_icon.dart';
import 'package:auto_sales/shared/cartIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homescreen extends ConsumerWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAllProducts = ref.watch(productsProvider);
    // OR final AsyncValue<List<Product>> asyncAllProducts = ref.watch(productsProvider); 
    final cartItems = ref.watch(cartProductsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text('Products'),
        actions: [AdminIcon(), CartIcon()],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: asyncAllProducts.when(
          data: (allProducts) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: .9,
              ),
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withValues(alpha: .14),
                  ),
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      allProducts[index].image.isEmpty
                          ? Icon(Icons.image_not_supported_outlined, size: 60)
                          : Image.asset(
                              allProducts[index].image,
                              width: 60,
                              height: 60,
                            ),
                      Text(allProducts[index].title),
                      Text(
                        '\$${allProducts[index].price}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      if (!cartItems.contains(allProducts[index]))
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            ref
                                .read(cartProductsProvider.notifier)
                                .addCartProduct(allProducts[index]);
                          },
                          child: Text(
                            'add to cart',
                            style: TextStyle(color: Colors.orange[800]),
                          ),
                        ),
                      if (cartItems.contains(allProducts[index]))
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            ref
                                .read(cartProductsProvider.notifier)
                                .removeItem(allProducts[index]);
                          },
                          child: Text(
                            'remove',
                            style: TextStyle(color: Colors.orange[800]),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text('Unable to get Data from Store')),
        ),
      ),
    );
  }
}
