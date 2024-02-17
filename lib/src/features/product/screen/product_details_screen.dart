import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/page_navigate.dart';
import '../controller/product_controller.dart';
import '../model/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.cardColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => popScreen(),
                    icon: const Icon(CupertinoIcons.back, color: Colors.grey)),
                IconButton(
                    onPressed: () => pushTo(AppRouter.cart),
                    icon: Badge(
                      backgroundColor: AppColor.primaryColor,
                      label: Obx(() => Text(
                        '${productController.cartList.length}',
                        style:
                        const TextStyle(color: Colors.white, fontSize: 11),
                      )),
                      child:
                          const Icon(CupertinoIcons.cart, color: Colors.grey,size: 28),
                    ))
              ],
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            children: [
              ///Product Image
              Hero(
                tag: 'productToDetails${productModel.id}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: productModel.image ?? '',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Icon(
                        CupertinoIcons.photo,
                        color: Colors.grey,
                        size: 200),
                    errorWidget: (context, url, error) => const Icon(
                        CupertinoIcons.exclamationmark_circle,
                        color: Colors.grey,
                        size: 200),
                  ),
                ),
              ),
              const SizedBox(height: 36),

              Text(
                '\$ ${productModel.userId}',
                maxLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColor.primaryColor,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                productModel.title ?? 'N/A',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'By ${productModel.category}',
                style: TextStyle(
                    color: AppColor.textColor.withOpacity(0.8), fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                productModel.content ?? 'N/A',
                style: TextStyle(
                    color: AppColor.textColor.withOpacity(0.8), fontSize: 14),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
            child: ElevatedButton(
              onPressed: () async{
                await productController.addToCartButtonOnTap(model: productModel);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))))
                  .copyWith(
                  overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.5))),
              child: const Text('Add To Cart',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      );
    });
  }
}
