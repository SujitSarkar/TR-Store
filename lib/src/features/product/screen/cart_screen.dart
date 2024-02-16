import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/page_navigate.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: const Center(
          child: Text('Cart Screen'),
        ),
      ),
    );
  }
}
