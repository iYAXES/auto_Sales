import 'package:auto_sales/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartProductsProvider);
    final cartTotal = ref.watch(totalCartPriceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Products'),
        backgroundColor: Colors.grey[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: cartProducts.map((cartPro) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        cartPro.imageUrl.isEmpty
                            ? Icon(Icons.image_not_supported, size: 60)
                            : Image.asset(
                                cartPro.imageUrl,
                                width: 60,
                                height: 60,
                              ),
                        SizedBox(width: 20),
                        Text(cartPro.title),
                        Expanded(child: SizedBox()),
                        Text('\$${cartPro.price}'),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRODUCT SUMMARY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal'),
                      Text(
                        '\$$cartTotal',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
