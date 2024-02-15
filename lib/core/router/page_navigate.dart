import 'package:flutter/Material.dart';
import 'package:get/get.dart';

void pushTo(String targetRoute) =>
    Navigator.pushNamed(Get.key.currentState!.context, targetRoute);

void pushAndRemoveUntil(String targetRoute) => Navigator.pushNamedAndRemoveUntil(
    Get.key.currentState!.context, targetRoute, (route) => false);

void popUntilOf(String targetRoute) => Navigator.popUntil(
    Get.key.currentState!.context,
    (route) => route.settings.name == targetRoute);

void popScreen() => Navigator.pop(Get.key.currentState!.context);
