import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../provider/product_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
                  children: <Widget>[
                    UserProductItem(
                      id: productsData.items[i].id,
                      title: productsData.items[i].title,
                      imageUrl: productsData.items[i].imageUrl,
                    ),
                    Divider(),
                  ],
                )),
      ),
    );
  }
}
