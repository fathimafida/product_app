import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:product_app/common/helpers.dart';
import 'package:product_app/features/add_edit/views/add_edit_page.dart';
import 'package:product_app/features/home/models/product.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(context, AddPage());
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // for (final prodct in productList) ProductCard(product: prodct)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              fit: BoxFit.cover,
            ),
            Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              style: applyGoogleFontToText(15),
            ),
            SizedBox(
              height: 10,
            ),
            Text("\$${product.price}", style: applyGoogleFontToText(15)),
            const SizedBox(
              height: 10,
            ),
            Text(product.description, style: applyGoogleFontToText(12)),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Rating: " + product.rating.rate.toString(),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 6,
                ),
                Icon(Icons.star_rate_outlined, color: Colors.amber),
                Spacer(),
                Text(
                  "Count: " + product.rating.count.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Text(
              "Category: " + product.category,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}