import 'package:auto_sales/providers/cart_provider.dart';
import 'package:auto_sales/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfItems = ref.watch(numberCartItemsProvider);
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
          icon: Icon(Icons.shopping_bag_outlined),
        ),

        Positioned(
          top: 4,
          left: 4,
          child: Container(
            width: 18,
            height: 18,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange[900],
            ),
            child: Center(
              child: Text(
                '$numberOfItems',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
