import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './products.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    //   Product(
    //       id: 'p1',
    //       title: 'Cookie choco',
    //       description:
    //           'A cookie chips blah, loeam imposumahwete erfgsdhasdtywwqe wdyjtdgfqwvdsachgvdctfasdt tgsadvasxtavc asdgtgfasvdsatdgfas stgdsdgasd',
    //       price: 30.0,
    //       imageUrl:
    //           'https://img2.pngio.com/dark-chocolate-cookies-transparent-png-stickpng-chocolate-cookies-png-375_300.png'),
    //   Product(
    //       id: 'p2',
    //       title: 'Chocolate cookies',
    //       description:
    //           'A cookie chips blah loeam imposumahwete erfgsdhasdtywwqe wdyjtdgfqwvdsachgvdctfasdt tgsadvasxtavc asdgtgfasvdsatdgfas stgdsdgasd',
    //       price: 10.0,
    //       imageUrl:
    //           'https://img2.pngio.com/double-belgian-chocolate-cookies-hd-png-download-transparent-chocolate-cookies-png-860_594.png'),
    //   Product(
    //       id: 'p3',
    //       title: 'Cookie cake',
    //       description:
    //           'A cookie chips blah loeam imposumahwete erfgsdhasdtywwqe wdyjtdgfqwvdsachgvdctfasdt tgsadvasxtavc asdgtgfasvdsatdgfas stgdsdgasd',
    //       price: 20.90,
    //       imageUrl:
    //           'https://img2.pngio.com/chocolate-cookies-png-image-png-play-chocolate-cookies-png-505_334.png'),
    //   Product(
    //       id: 'p4',
    //       title: 'Cookie chips',
    //       description:
    //           'A cookie chips blah loeam imposumahwete erfgsdhasdtywwqe wdyjtdgfqwvdsachgvdctfasdt tgsadvasxtavc asdgtgfasvdsatdgfas stgdsdgasd',
    //       price: 34.0,
    //       imageUrl:
    //           'https://img2.pngio.com/chocolate-chip-cookie-png-chocolate-chip-cookie-dough-ice-cream-chocolate-cookies-png-260_260.jpg'),
    //
  ];

  // var _showFavoriteOnly = false;

  // List<Product> get items {
  //   return [..._items];
  // }
  List<Product> get items => _items;

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts() async {
    try {
      const url = 'https://shop-app-97.firebaseio.com/products.json';
      final response = await http.get(url);
      // print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void deleteProduct(Product product) {
    _items.remove(product);
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://shop-app-97.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
