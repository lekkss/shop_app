import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_card_item.dart';
import '../provider/orders.dart';

class OrderScreen extends StatelessWidget {
  static const routName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderCardItem(
          order: orderData.orders[i],
        ),
      ),
    );
  }
}
