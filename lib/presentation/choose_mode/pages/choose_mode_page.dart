import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/widgets/button/basic_button.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/gen/assets.gen.dart';
import 'package:spotify_app/presentation/auth/pages/auth_page.dart';
import 'package:spotify_app/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify_app/presentation/choose_mode/widgets/dark_mode_toggle_mode.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

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
                  image: AssetImage(Assets.images.chooseModeBg.path),
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
                    "Choose Mode",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      DarkModeToggleMode(title: 'Dark Mode', icon: Assets.vectors.moon,onTap: (){
                        context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                      },),
                      DarkModeToggleMode(title: 'Light Mode', icon: Assets.vectors.sun, onTap: () {
                        context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                      },),
                      
                    ],
                  ),
                  Gap(50),
                  BasicButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthPage(),
                      ),
                    );
                    },
                    title: 'Continue',
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
