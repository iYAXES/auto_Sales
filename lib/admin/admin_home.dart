import 'package:auto_sales/admin/admin_service.dart';
import 'package:auto_sales/model/product.dart';
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
  String _productName = "";
  double _productPrice = 0;
  bool _isLoading = false;

  void onUpload() async {
    if (_formGlobalKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formGlobalKey.currentState!.save();

      Product newProduct = Product(
        id: uuid.v4(),
        price: _productPrice,
        title: _productName,
        image: "",
      );
      await AdminService.addToStore(newProduct);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            content: Text('Product added successfully!!'),
          ),
        );
      }

      _formGlobalKey.currentState!.reset();

      setState(() {
        _isLoading = false;
      });
    }
  }

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
                    onPressed: onUpload,
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
