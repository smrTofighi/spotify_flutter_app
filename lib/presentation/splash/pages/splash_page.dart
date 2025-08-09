import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/gen/assets.gen.dart';
import 'package:spotify_app/presentation/home/pages/home_page.dart';
import 'package:spotify_app/presentation/intro/pages/get_started_page.dart';
import 'package:spotify_app/presentation/splash/cubit/check_login_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckLoginCubit()..checkLogin(),
      child: Scaffold(
        body: BlocListener<CheckLoginCubit, CheckLoginState>(
          listener: (context, state) {
            if (state is CheckLoginLogged) {
              redirect(HomePage());
            }
            if (state is CheckLoginNotLogged) {
              redirect(GetStartedPage());
            }
          },
          child: Center(child: SvgPicture.asset(Assets.vectors.spotifyLogo)),
        ),
      ),
    );
  }

  Future<void> redirect(Widget page) async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }
}
