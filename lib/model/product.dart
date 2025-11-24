import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.image,
  });

  //Adding Product to Firebase
  Map<String, dynamic> toFirebaseStore() {
    return {'title': title, 'price': price, 'image': image};
  }

  //From the FirebaseStore
  factory Product.fromFirebaseStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    Product product = Product(
      id: snapshot.id,
      price: data['price'],
      title: data['title'],
      image: data['image'],
    );
    return product;
  }
}
