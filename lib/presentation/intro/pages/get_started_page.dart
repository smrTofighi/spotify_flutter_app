import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/widgets/button/basic_button.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/gen/assets.gen.dart';
import 'package:spotify_app/presentation/choose_mode/pages/choose_mode_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(Assets.images.introBg.path),
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(Assets.vectors.spotifyLogo),
                  ),
                  Spacer(),
                  Text(
                    "Enjoy Listening to Music",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Gap(21),
                  Text(
                    "Listen to your favorite artists and albums. Enjoy listening to music anywhere, anytime.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,

                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  Gap(20),
                  BasicButton(
                    onPressed: () {
                      log('Click');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseModePage(),
                        ),
                      );
                    },
                    title: 'Get Started',
                  ).animate().moveY(duration: 500.ms, begin: 100),
                ],
              ),
            ),

            IgnorePointer(
              ignoring: true,
              child: Container(color: Colors.black.withAlpha(35)),
            ),
          ],
        ),
      ),
    );
  }
}
