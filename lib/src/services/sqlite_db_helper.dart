import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_app/src/features/product/model/cart_model.dart';

class SQLiteDBHelper {
  static SQLiteDBHelper? _databaseController; // singleton DatabaseHelper
  static Database? _database;
  final String cartTable = 'cart';

  ///Cart Table Column
  final String id = 'id';
  final String productId = 'productId';
  final String userId = 'userId';
  final String quantity = 'quantity';
  final String slug = 'slug';
  final String url = 'url';
  final String title = 'title';
  final String content = 'content';
  final String image = 'image';
  final String thumbnail = 'thumbnail';
  final String status = 'status';
  final String category = 'category';

  SQLiteDBHelper._createInstance(); //Named constructor to create instance of DatabaseHelper

  factory SQLiteDBHelper() {
    _databaseController ??= SQLiteDBHelper._createInstance();
    return _databaseController!;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $cartTable($id INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$productId INTEGER, $userId INTEGER, $quantity INTEGER, $slug TEXT, $url TEXT, $title TEXT, $content TEXT, $image TEXT, $thumbnail TEXT, $status TEXT, $category TEXT)');
  }

  Future<Database> initializeDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}trstore.db';
    var trStoreDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return trStoreDatabase;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  ///Fetch Cart Map list from DB
  Future<List<Map<String, dynamic>>> getCartMapList() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result =
        await db.query(cartTable, orderBy: '$id ASC');
    return result;
  }

  ///Get Cart List
  Future<List<CartModel>> getCartList() async {
    List<CartModel> cartList = [];
    try {
      final List<Map<String, dynamic>> cartMapList = await getCartMapList();
      for (int i = 0; i < cartMapList.length; i++) {
        cartList.add(CartModel.fromMapObject(cartMapList[i]));
      }
      debugPrint('Cart items length: ${cartList.length}');
    } catch (e) {
      debugPrint(e.toString());
    }
    return cartList;
  }

  ///Insert Cart
  Future<bool> insertCartItem({required CartModel cartModel}) async {
    try {
      final Database db = await database;
      await db.insert(cartTable, cartModel.toMap());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
  ///update Cart
  Future<int> updateCart({required CartModel cartModel}) async {
    int result = 0;
    try {
      Database db = await database;
      result = await db.update(cartTable, cartModel.toMap(),
          where: '$productId = ?', whereArgs: [cartModel.productId]);
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint('Result: $result');
    return result; // 0=error; 1=success
  }

  ///Delete Cart
  Future<int> deleteCartItem({required int cartItemId}) async {
    int result = 0;
    try {
      final Database db = await database;
      result = await db.rawDelete('DELETE FROM $cartTable WHERE $id = $cartItemId');
    } catch (e) {
      debugPrint(e.toString());
    }
    return result; // 0=error; 1=success
  }
}
