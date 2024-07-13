import 'package:eyx3/constants/size.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.all(xsmall),
        child: Text('eyX3'),
      ),
      actions: [Image.asset('assets/icons/rewardIcon.png', height: 37),
      const SizedBox(width: xsmall)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
