import 'package:auto_sales/admin/adminservice/admin_service.dart';
import 'package:auto_sales/models/product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

List<Product> allProducts = [];

//Generate Providers for all the Products
@riverpod
Future<List<Product>> products(ref) async {
  if (allProducts.isEmpty) {
    final products = await AdminService.fetchProduct();
    for (var product in products.docs) {
      allProducts.add(product.data());
    }
  }
  return allProducts;
}
