import 'dart:io';

import 'package:auto_sales/admin/admin_service.dart';
import 'package:auto_sales/model/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _formGlobalKey = GlobalKey<FormState>();
  String _productName = "";
  double _productPrice = 0;
  bool _isLoading = false;


File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final supabase = Supabase.instance.client;
  //
  Future<void> pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  //Upload Image to the Firebase Cloud Store
  Future<String> uploadImage(String productId) async {
    final fileName = 'images/$productId.jpg';
    //
    await supabase.storage
        .from('products')
        .upload(
          fileName,
          _selectedImage!,
          fileOptions: FileOptions(upsert: true, contentType: 'image/jpeg'),
        );

    //The Public URL
    return supabase.storage.from('products').getPublicUrl(fileName);
  }
  //

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text('Upload Product'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: _selectedImage == null
                            ? Text('Tap to select image')
                            : Image.file(_selectedImage!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Product name'),
                      filled: true,
                      fillColor: Colors.white54,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a product name";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      setState(() {
                        _productName = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Price'),
                      filled: true,
                      fillColor: Colors.white54,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a price";
                      }
                      if (double.tryParse(value) == null) {
                        return "Enter a valid price";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      setState(() {
                        _productPrice = double.parse(newValue!);
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator(color: Colors.green)
                : TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(5),
                      ),
                      backgroundColor: Colors.blue.shade400,
                    ),

                    //
                    onPressed: () async {
                      if (_formGlobalKey.currentState!.validate()) {
                        if (_selectedImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select an image')),
                          );
                          return;
                        }
                        //
                        setState(() {
                          _isLoading = true;
                        });
                        _formGlobalKey.currentState!.save();

                        final productId = uuid.v4();

                        //Get the upload image URL here
                        final imageUrl = await uploadImage(productId);

                        //Saving all the Products
                        Product newProduct = Product(
                          id: productId,
                          price: _productPrice,
                          title: _productName,
                          image: imageUrl,
                        );
                        await AdminService.addToStore(newProduct);

                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            content: Text('Product added successfully!!'),
                          ),
                        );

                        _formGlobalKey.currentState!.reset();

                        setState(() {
                          _selectedImage = null;
                          _isLoading = false;
                        });
                      }
                    },
                    child: Text(
                      'Upload item',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
