import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:product_app/common/helpers.dart';
import 'package:product_app/features/add_edit/views/add_edit_page.dart';
import 'package:product_app/common/models/product.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Product> productList = [];
  bool _isLoading = false;

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  void getProduct() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await Dio().get("https://fakestoreapi.com/products/");
      for (final prdct in response.data) {
        productList.add(Product.fromJson(prdct));
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(context, AddPage());
        },
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final prodct in productList)
                        ProductCard(product: prodct)
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({
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
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              style: applyGoogleFontToText(15),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("\$${product.price}", style: applyGoogleFontToText(15)),
            const SizedBox(
              height: 10,
            ),
            Text(product.description, style: applyGoogleFontToText(12)),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Rating: " + product.rating.rate.toString(),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 6,
                ),
                const Icon(Icons.star_rate_outlined, color: Colors.amber),
                const Icon(Icons.star_rate_outlined, color: Colors.amber),
                const Icon(Icons.star_rate_outlined, color: Colors.amber),
                const Spacer(),
                Text(
                  "Count: " + product.rating.count.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
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
