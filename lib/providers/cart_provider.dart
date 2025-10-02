import 'package:auto_sales/models/product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class CartProducts extends _$CartProducts {
  @override
  Set<Product> build() {
    return {};
  }

  //Adding Product to Cart
  void addToCart(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  //Remove Product From Cart
  void removeFromCart(Product product) {
    if (state.contains(product)) {
      state = {...state}..remove(product);
    }
  }
}

//Generate total Price of Cart Product
@riverpod
double totalCartPrice(ref) {
  final cartTotal = ref.watch(cartProductsProvider);
  double total = 0;
  for (Product product in cartTotal) {
    total += product.price;
  }
  return total;
}

//Generate number of item in the Cart
@riverpod
int numberCartItems(ref) {
  final cartItems = ref.watch(cartProductsProvider);

  return cartItems.length;
}
