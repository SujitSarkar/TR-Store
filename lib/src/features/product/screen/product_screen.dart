import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/page_navigate.dart';
import '../controller/product_controller.dart';
import '../widget/product_shimmer.dart';
import '../widget/product_tile.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
        init: ProductController(),
        builder: (productController) {
          return Obx(() => SafeArea(
                child: productController.initialLoading.value
                    ? const ProductShimmer()
                    : Scaffold(
                        appBar: PreferredSize(
                          preferredSize: const Size.fromHeight(70),
                          child: Container(
                            color: AppColor.appBodyBg,
                            padding: const EdgeInsets.only(
                                left: 16, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome to',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.textColor
                                              .withOpacity(0.6)),
                                    ),
                                    const Text(
                                      AppString.appName,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primaryColor),
                                    )
                                  ],
                                ),
                                InkWell(
                                    onTap: ()=> pushTo(AppRouter.cart),
                                    child: Badge(
                                      backgroundColor: AppColor.primaryColor,
                                      label: Text(
                                        '${productController.cartList.length}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      ),
                                      child: const Icon(CupertinoIcons.cart,
                                          color: Colors.grey, size: 32),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        body: RefreshIndicator(
                          onRefresh: () async => await productController.getProducts(),
                          backgroundColor: Colors.white,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(16),
                            addAutomaticKeepAlives: false,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: .8),
                            itemCount: productController.productList.length,
                            itemBuilder: (context, index) => ProductTile(
                                model: productController.productList[index]),
                          ),
                        ),
                      ),
              ));
        });
  }
}
