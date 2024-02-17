import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/page_navigate.dart';
import '../../../services/api/api_endpoint.dart';
import '../../../services/api/api_service.dart';
import '../../../services/app_toast.dart';
import '../../../services/sqlite_db_helper.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';
import '../screen/product_details_screen.dart';

class ProductController extends GetxController {
  final SQLiteDBHelper _sqLiteDBHelper = SQLiteDBHelper();
  RxBool initialLoading = true.obs;

  RxList<ProductModel> productList = <ProductModel>[].obs;
  Rxn<ProductModel> productDetails = Rxn();

  ///Cart
  RxList<CartModel> cartList = <CartModel>[].obs;

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    initialLoading(true);
    await Future.wait([
    getProducts(),
    getCart(),
    ]);
    initialLoading(false);
  }

  Future<void> getProducts() async {
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance
          .get('${ApiEndpoint.baseUrl}${ApiEndpoint.products}');
    }, onSuccess: (response) async {
      productList(productModelFromJson(response.body));
      debugPrint('Success ${productList.length}');
    }, onError: (error) {
      showToast("${error.message}");
    });
  }

  Future<void> getCart() async {
    await _sqLiteDBHelper.getCartList().then((cartDataList) => cartList(cartDataList));
  }

  Future<void> addToCartButtonOnTap({required ProductModel model}) async {
    for(CartModel element in cartList){
      if(element.productId == model.id){
        showToast('Already added to cart');
        return;
      }
    }
    final CartModel cartModel = CartModel(
        model.id,
        model.userId,
        1,
        model.slug,
        model.url,
        model.title,
        model.content,
        model.image,
        model.thumbnail,
        model.status,
        model.category);
    await _sqLiteDBHelper.insertCartItem(cartModel: cartModel).then((result)async{
      if(result){
        showToast('product added to cart');
        await getCart();
      }
    });
  }

  Future<void> updateCartWithProductQuantity({required CartModel cartModel, required int quantity}) async {
    final CartModel model = CartModel(
        cartModel.productId,
        cartModel.userId,
        quantity,
        cartModel.slug,
        cartModel.url,
        cartModel.title,
        cartModel.content,
        cartModel.image,
        cartModel.thumbnail,
        cartModel.status,
        cartModel.category);
    await _sqLiteDBHelper.updateCart(cartModel: model).then((result) async{
      if(result==1){
        await getCart();
      }else{
        showToast('Error updating quantity');
      }
    });
  }

  Future<void> deleteCartItemOnTap({required CartModel cartModel}) async {
    await _sqLiteDBHelper.deleteCartItem(cartItemId: cartModel.id!).then((result)async{
      if(result==1){
        await getCart();
        showToast('Product deleted');
      }else{
        showToast('Error deleting product');
      }
    });
    await getCart();
  }

  void navigateCartToProductDetails({required CartModel cartModel}){
    ProductModel productModel = ProductModel(
      id: cartModel.productId,
      slug:cartModel.slug,
      url:cartModel.url,
      title:cartModel.title,
      content:cartModel.content,
      image:cartModel.image,
      thumbnail:cartModel.thumbnail,
      status:cartModel.status,
      category:cartModel.category,
      userId:cartModel.userId,
    );
    pushTo(AppRouter.productDetails,arguments: ProductDetailsScreen(productModel: productModel));
  }
}
