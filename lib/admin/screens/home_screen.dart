import 'package:auto_sales/admin/adminservice/admin_service.dart';
import 'package:auto_sales/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _formGlobalKey = GlobalKey<FormState>();
  String _productTitle = "";
  double _productPrice = 0;
  bool _isLoading = false;

  void _addToStore() async {
    if (_formGlobalKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      _formGlobalKey.currentState!.save();

      try {
        final id = uuid.v4();
        final imageUrl = "";
        //
        final newProduct = Product(
          id: id,
          title: _productTitle,
          price: _productPrice,
          imageUrl: imageUrl,
        );
        await AdminService.addToFirebaseStore(newProduct);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product Added Successfully!')),
          );
        }

        _formGlobalKey.currentState!.reset();

        setState(() {
          _isLoading = false;
        });

        //
      } catch (e) {
        throw Exception('Unable to add Product $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Product'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(label: Text('product name')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a product name";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _productTitle = newValue!;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(label: Text('price')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Price";
                      }
                      if (double.tryParse(value) == null) {
                        return "Enter a valid price";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _productPrice = double.parse(newValue!);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: _addToStore,
                    child: Text('add product'),
                  ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:auto_sales/admin/services/firestore_services.dart';
// import 'package:auto_sales/model/product.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';

// var uuid = const Uuid();

// class AdminHome extends StatefulWidget {
//   const AdminHome({super.key});

//   @override
//   State<AdminHome> createState() => _AdminHomeState();
// }

// class _AdminHomeState extends State<AdminHome> {
//   String _productTitle = "";
//   int _productPrice = 0;
//   final _picker = ImagePicker();
//   File? _pickedImage;
//   bool _isLoading = false;

//   final _globalKey = GlobalKey<FormState>();

//   //Picking the Image from the File to Screen Function
//   Future<void> _pickImage() async {
//     final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         _pickedImage = File(picked.path);
//       });
//     }
//   }

//   //Uploading the Image to Firbase Storage
//   Future<String> _uploadImageToFirebaseStore(
//     File imageFile,
//     String productId,
//   ) async {
//     final ref = FirebaseStorage.instance
//         .ref()
//         .child('product_images')
//         .child('$productId.jpg');
//     await ref.putFile(imageFile);

//     return await ref.getDownloadURL();
//   }

//   Future<void> addProduct() async {
//     if (!_globalKey.currentState!.validate() || _pickedImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Fill all Forms and pick an image')),
//       );
//       return;
//       // final newProducts = Product(id: uuid.v4(), title: _productTitle, price: _productPrice, image: image
//     }
//     _globalKey.currentState!.save();
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final id = uuid.v4();
//       print('Uploading image...');
//       final imageUrl = await _uploadImageToFirebaseStore(_pickedImage!, id);
//       print('Image uploaded: $imageUrl');
//       final newProduct = Product(
//         id: id,
//         title: _productTitle,
//         price: _productPrice,
//         imageUrl: imageUrl,
//       );

//       print('Saving to Firestore...');
//       await AdminService.addProductToStore(newProduct);
//       print('Saved successfully');
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Product Added')));
//       }
//       _globalKey.currentState!.reset();
//       setState(() {
//         _pickedImage = null;
//       });
//     } catch (e, st) {
//       debugPrint('Error adding product: $e\n$st');
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error: $e')));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Product'),
//         backgroundColor: Colors.grey,
//       ),

//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Form(
//               key: _globalKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(label: Text('Product Title')),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter a product title";
//                       }
//                       return null;
//                     },
//                     onSaved: (newValue) {
//                       _productTitle = newValue!;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   TextFormField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(label: Text('Price')),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter product price";
//                       }
//                       if (int.tryParse(value) == null) {
//                         return "Enter a valid price";
//                       }
//                       return null;
//                     },
//                     onSaved: (newValue) {
//                       _productPrice = int.parse(newValue!);
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   _pickedImage == null
//                       ? Text('Image not Selected')
//                       : Image.file(
//                           _pickedImage!,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         ),
//                   TextButton.icon(
//                     onPressed: _pickImage,
//                     label: Text('pick image'),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             _isLoading
//                 ? CircularProgressIndicator()
//                 : FilledButton(
//                     style: FilledButton.styleFrom(
//                       backgroundColor: Colors.grey[900],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     onPressed: addProduct,
//                     child: Text('addProduct'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
