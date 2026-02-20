import 'package:auto_sales/provider/cart_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cartscreen extends ConsumerStatefulWidget {
  const Cartscreen({super.key});

  @override
  ConsumerState<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends ConsumerState<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartProductsProvider);
    final totalPrice = ref.watch(totalCartPriceProvider);
    final itemsInCart = ref.watch(cartProductsProvider).length;
    return Scaffold(
      backgroundColor: Colors.white70.withValues(alpha: .85),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Cart($itemsInCart)'),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: cartProducts.map((cartPro) {
                    return Row(
                      children: [
                        cartPro.image.isEmpty
                            ? Icon(Icons.image_not_supported_outlined, size: 80)
                            : Image.asset(cartPro.image, width: 80, height: 80),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartPro.title),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8,
                                ),
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                ref
                                    .read(cartProductsProvider.notifier)
                                    .removeItem(cartPro);
                              },
                              child: Text(
                                'remove',
                                style: TextStyle(color: Colors.orange[800]),
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          '\$${cartPro.price}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              Text('CART SUMMARY'),

              Divider(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal'),
                  Text(
                    '\$$totalPrice',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
