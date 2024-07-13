import 'package:eyx3/pages/reward_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/size.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.rubik(fontSize: 29, color: white),
      ),
      backgroundColor: background,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RewardPage()));
          },
          child: Image.asset(
            'assets/icons/rewardIcon.png',
            height: 37,
            color: white,
          ),
        ),
        const SizedBox(width: xsmall),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
