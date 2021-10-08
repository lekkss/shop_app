import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              height: 300,
              width: double.infinity,
              child: loadedProduct.imageUrl.isNotEmpty
                  ? Image.network(
                      loadedProduct.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.purpleAccent,
                      height: 150,
                      width: 150,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
