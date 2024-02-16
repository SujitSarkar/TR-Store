import 'dart:convert';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import '../../../services/api/api_endpoint.dart';
import '../../../services/api/api_service.dart';
import '../../../services/app_toast.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController{
  RxBool initialLoading = true.obs;
  RxBool productDetailsLoading = true.obs;

  RxList<ProductModel> productList = <ProductModel>[].obs;
  Rx<ProductModel> productDetails = ProductModel().obs;

  ///Cart
  RxList<CartModel> cartList = <CartModel>[].obs;

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> initialize()async{
    initialLoading(true);
    await getProducts();
    initialLoading(false);
  }

  Future<void> getProducts()async{
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance.get(
          '${ApiEndpoint.baseUrl}${ApiEndpoint.products}');
    }, onSuccess: (response) async {
      productList(productModelFromJson(response.body));
      debugPrint('Success ${productList.length}');
    }, onError: (error) {
      showToast("${error.message}");
    });
  }

  Future<void> getProductDetails({required int productId})async{
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance.get(
          '${ApiEndpoint.baseUrl}${ApiEndpoint.products}/$productId');
    }, onSuccess: (response) async {
      productDetails(ProductModel.fromJson(jsonDecode(response.body)));
    }, onError: (error) {
      showToast("${error.message}");
    });
    productDetailsLoading(false);
  }
}