import 'package:flutter/material.dart';
import '../provider/cart.dart';
import '../provider/products.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routName,
              arguments: product.id,
            );
          },
          child: product.imageUrl.isNotEmpty
              ? Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 50,
                  color: Colors.purpleAccent,
                ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.grey[300],
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                  size: 15,
                ),
                onPressed: () {
                  product.toggleFavoriteStatus();
                }),
          ),
          title: Text(
            product.title,
            style: TextStyle(fontSize: 10, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
                size: 15,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added item to cart',
                    ),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
