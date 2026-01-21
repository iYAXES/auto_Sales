import 'package:auto_sales/model/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_products.g.dart';

@riverpod
class CartProducts extends _$CartProducts {
  //adding default products in the Cart
  @override
  Set<Product> build() {
    return {};
  }


  //Adding Product to Cart
  void addCartProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  //Removing Products from Cart
  void removeItem(Product product) {
    if (state.contains(product)) {
      state = {...state}..remove(product);
    }
  }
}

//Total Price of Items in the Cart
@riverpod
double totalCartPrice(ref) {
  double total = 0;
  final cartPrices = ref.watch(cartProductsProvider);
  for (Product product in cartPrices) {
    total += product.price;
  }
  return total;
}
