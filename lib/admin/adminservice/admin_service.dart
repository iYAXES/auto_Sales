import 'package:auto_sales/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  static final ref = FirebaseFirestore.instance
      .collection('products')
      .withConverter(
        fromFirestore: Product.fromFirebaseStore,
        toFirestore: (Product product, _) => product.toFirebaseStore(),
      );

  static Future<void> addToFirebaseStore(Product product) async {
    await ref.doc(product.id).set(product);
  }

  static Future<QuerySnapshot<Product>> fetchProduct() {
    return ref.get();
  }
}
