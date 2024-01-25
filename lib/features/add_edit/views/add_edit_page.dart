import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    super.key,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  void addProduct({
    required String title,
    required String description,
    required String price,
  }) async {
    try {
      if (_formKey.currentState!.validate()) {
        final response =
            await Dio().post("https://fakestoreapi.com/products/", data: {
          "title": title,
          "description": description,
          "price": price,
        });
        print(response.data);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: "title",
                  hintText: "title",
                )),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: "description",
                  hintText: "description",
                )),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _priceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: "price",
                  hintText: "price",
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                addProduct(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    price: _priceController.text);
              },
              child: Text("Add Product"),
            )
          ],
        ),
      )),
    ));
  }
}
