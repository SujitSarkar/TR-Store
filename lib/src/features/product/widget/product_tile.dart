import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_app/core/router/app_router.dart';
import 'package:user_app/core/router/page_navigate.dart';
import 'package:user_app/src/features/product/screen/product_details_screen.dart';
import '../../../../core/constant/app_color.dart';
import '../model/product_model.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.model});

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> pushTo(AppRouter.productDetails,
        arguments: ProductDetailsScreen(productModel: model)),
      child: Ink(
        decoration: const BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ///Thumbnail
                Hero(
                  tag: 'productToDetails${model.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    child: CachedNetworkImage(
                      imageUrl: model.thumbnail ?? '',
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Icon(
                          CupertinoIcons.photo,
                          color: Colors.grey,
                          size: 60),
                      errorWidget: (context, url, error) => const Icon(
                          CupertinoIcons.exclamationmark_circle,
                          color: Colors.grey,
                          size: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title ?? 'N/A',
                        maxLines: 2,
                        style: TextStyle(
                            color: AppColor.textColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$ ${model.userId}',
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColor.primaryColor,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                )
              ],
            ),

            ///Add Cart Button
            Positioned(
              right: 8,
              bottom: 8,
              child: InkWell(
                onTap: (){},
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColor.primaryColor.withOpacity(0.65),
                  child: const Icon(CupertinoIcons.add,
                      color: Colors.white, size: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
