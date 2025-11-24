import 'package:auto_sales/Home/cart/cartscreen.dart';
import 'package:auto_sales/provider/cart_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsInCart = ref.watch(cartProductsProvider).length;
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cartscreen()),
            );
          },
          icon: Icon(Icons.shopping_cart_rounded),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: Colors.orange[800],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$itemsInCart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
