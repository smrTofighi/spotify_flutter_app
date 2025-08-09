import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/helper/is_dark_mode.dart';
import 'package:spotify_app/common/widgets/app_bar/app_bar.dart';
import 'package:spotify_app/common/widgets/button/basic_button.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/gen/assets.gen.dart';
import 'package:spotify_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:spotify_app/presentation/auth/pages/login_page.dart';
import 'package:spotify_app/presentation/auth/pages/signup_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            BasicAppBar(),
            Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(Assets.vectors.topPattern),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(Assets.vectors.bottomPattern),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(Assets.images.authBg.path, height: 300),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.vectors.spotifyLogo),
                    Gap(55),
                    Text(
                      'Enjoy Listening To Music',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Gap(21),
                    Text(
                      'Spotify is one of the world\'s most popular music platforms. Stream millions of songs, podcasts, and playlists anytime, anywhere.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColors.grey,
                      ),
                    ),
                    Gap(30),
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          flex: 1,
                          child: BasicButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            title: 'Register',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogInPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}
