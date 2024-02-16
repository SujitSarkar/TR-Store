import 'package:flutter/Material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_app/core/constant/app_color.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: AppColor.cardColor,
        highlightColor: Colors.grey.shade200,
        enabled: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16,bottom: 12),
                height: 20,
                width: screenWidth*.4,
                color: AppColor.cardColor,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 20,
                width: screenWidth*.7,
                color: AppColor.cardColor,
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: .8),
                itemCount: 8,
                itemBuilder: (context, index) => Container(color: AppColor.cardColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
