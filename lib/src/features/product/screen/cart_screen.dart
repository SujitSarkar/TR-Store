import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/page_navigate.dart';
import '../controller/product_controller.dart';
import '../widget/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (productController) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => popScreen(),
                      icon: const Icon(CupertinoIcons.back, color: Colors.grey)),
                  const Text('Cart',style: TextStyle(fontSize: 18)),
                  const Spacer(),
                  IconButton(
                      onPressed: () => popUntilOf(AppRouter.product),
                      icon: const Icon(CupertinoIcons.home, color: Colors.grey))
                ],
              ),
            ),
            body: RefreshIndicator(
              onRefresh: ()async{await productController.getCart();},
              backgroundColor: Colors.white,
              child: Obx(() => ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                addAutomaticKeepAlives: false,
                itemCount: productController.cartList.length,
                separatorBuilder: (context, index)=> const SizedBox(height: 20,),
                itemBuilder: (context, index)=> CartTile(model: productController.cartList[index]),
              ),)
            ),
          ),
        );
      }
    );
  }
}
