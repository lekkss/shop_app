import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';

import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Function deleteHandler;

  const UserProductItem({
    Key key,
    this.id,
    this.title,
    this.imageUrl,
    this.deleteHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: imageUrl.isNotEmpty
          ? CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            )
          : CircleAvatar(
              backgroundColor: Colors.purpleAccent,
            ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routName, arguments: id);
                }),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .deleProduct(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
