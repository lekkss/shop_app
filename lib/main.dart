import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './provider/orders.dart';
import './screens/cart_screen.dart';
import './provider/cart.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop',
        theme: ThemeData(
          primaryTextTheme: TextTheme(
              headline6: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 35,
                    fontFamily: 'jacklin',
                    color: Colors.white,
                  )),
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routName: (ctx) => ProductDetailScreen(),
          CartScreen.routName: (ctx) => CartScreen(),
          OrderScreen.routName: (ctx) => OrderScreen(),
          UserProductsScreen.routName: (ctx) => UserProductsScreen(),
          EditProductScreen.routName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
