import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/size.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'eyX3',
        style: GoogleFonts.rubik(fontSize: 29, color: Colors.white),
      ),
      backgroundColor: background,
      actions: [Image.asset('assets/icons/rewardIcon.png', height: 37, color: white,),
        const SizedBox(width: xsmall)],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}