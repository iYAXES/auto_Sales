import 'package:auto_sales/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  static final ref = FirebaseFirestore.instance
      .collection('products')
      .withConverter(
        fromFirestore: Product.fromFirebaseStore,
        toFirestore: (Product product, _) => product.toFirebaseStore(),
      );

  //Saved Data to FirebaseStore
  static Future<void> addToStore(Product product) async {
    await ref.doc().set(product);
  }

  //Fetch Data from Store
  static Future<QuerySnapshot<Product>> fetchFromStore() {
    return ref.get();
  }
}
