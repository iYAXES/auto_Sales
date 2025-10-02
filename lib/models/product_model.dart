import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  //Adding Products to Firestore
  Map<String, dynamic> toFirebaseStore() {
    return {"title": title, "price": price, "imageUrl": imageUrl};
  }

  //Process data from FirebaseStore

  factory Product.fromFirebaseStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    Product product = Product(
      id: snapshot.id,
      title: data['title'],
      price: data['price'],
      imageUrl: data['imageUrl'],
    );

    return product;
  }
}
