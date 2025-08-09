import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/widgets/app_bar/app_bar.dart';
import 'package:spotify_app/common/widgets/basic_textfield.dart';
import 'package:spotify_app/common/widgets/button/basic_button.dart';
import 'package:spotify_app/common/widgets/loading.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/gen/assets.gen.dart';
import 'package:spotify_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:spotify_app/presentation/auth/pages/signup_page.dart';
import 'package:spotify_app/presentation/auth/widgets/auth_prompt.dart';
import 'package:spotify_app/presentation/home/pages/home_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(
          title: SvgPicture.asset(
            Assets.vectors.spotifyLogo,
            height: 40,
            width: 40,
          ),
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Gap(50),

              BasicTextfield(
                hintText: 'Enter Email Or Username',
                controller: emailController,
              ),
              Gap(20),
              BasicTextfield(
                hintText: 'Password',
                controller: passwordController,
              ),
              Gap(20),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    var snackbar = SnackBar(content: Text(state.message));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                  if (state is AuthSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if(state is AuthLoading){
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Loading(color: AppColors.primary, size: 42),
                    );
                  }
                  return BasicButton(
                    onPressed: () async {
                      context.read<AuthCubit>().login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },
                    title: 'Sign In',
                  );
                },
              ),
              Spacer(),
              AuthPrompt(
                text: 'Not A Member?',
                buttonText: 'Register Now',
                page: SignUpPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
