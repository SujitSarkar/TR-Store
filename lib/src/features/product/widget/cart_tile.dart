import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/router/page_navigate.dart';
import '../controller/product_controller.dart';
import '../model/cart_model.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.model});
  final CartModel model;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    return InkWell(
      onTap: (){
        productController.navigateCartToProductDetails(cartModel: model);
      },
      child: Ink(
        
        padding: const EdgeInsets.only(right: 8),
        decoration: const BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Image Container
                Hero(
                  tag: 'productToDetails${model.productId}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)
                    ),
                    child: CachedNetworkImage(
                      imageUrl: model.image ?? '',
                      height: 80,
                      width: 100,
                      placeholder: (context, url) =>
                          const Icon(CupertinoIcons.photo, color: Colors.grey,size: 50,),
                      errorWidget: (context, url, error) =>
                          const Icon(CupertinoIcons.exclamationmark_circle, color: Colors.grey,size: 40,),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///Title
                      Text(
                        model.title ?? 'N/A',
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      ///Price
                      Text(
                        '\$ ${model.userId! * int.parse('${model.quantity}')}',
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ///Button Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              int quantity = model.quantity!;
                              if (quantity > 1) {
                                quantity--;
                                await productController.updateCartWithProductQuantity(cartModel: model, quantity: quantity);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.remove_circle_outline,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${model.quantity}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () async {
                              int quantity = model.quantity!;
                              quantity++;
                              await productController.updateCartWithProductQuantity(cartModel: model, quantity: quantity);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                          const Spacer(),
                          ///Delete Button
                          InkWell(
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.grey),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Delete this product from cart?',style: TextStyle(fontSize: 16),),
                                      actions: [
                                        TextButton(onPressed: ()async{
                                          await productController.deleteCartItemOnTap(cartModel: model);
                                          popScreen();
                                        }, child: const Text('Yes')),
                                        TextButton(onPressed: ()=>popScreen(), child: const Text('No',style: TextStyle(color: Colors.green),)),
                                      ],
                                    );
                                  },
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
