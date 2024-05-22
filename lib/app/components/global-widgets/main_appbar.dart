import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.prefixAction,
    required this.suffixAction,
  });
  final VoidCallback prefixAction;
  final VoidCallback suffixAction;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('GetX Standard'),
      leading: IconButton(
        onPressed: prefixAction,
        icon: Icon(
          Get.isDarkMode ? Iconsax.moon5 : Iconsax.moon5,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: suffixAction,
          icon: const Icon(
            IconlyBold.graph,
            color: Colors.white,
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
