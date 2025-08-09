import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/helper/is_dark_mode.dart';
import 'package:spotify_app/common/widgets/app_bar/app_bar.dart';
import 'package:spotify_app/common/widgets/loading.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/presentation/home/bloc/recent_songs_cubit.dart';
import 'package:spotify_app/presentation/home/pages/home_page.dart';
import 'package:spotify_app/presentation/profile/cubit/profile_info_cubit.dart';
import 'package:spotify_app/presentation/profile/widgets/favorite_songs.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(
          title: Text('Profile'),
          backGroundColor: Color(0xFF2C2B2B),
          onBackPress: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            ).then((_) async{
              
            });
            
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocProvider(
              create: (context) => ProfileInfoCubit()..getUser(),
              child: Container(
                height: MediaQuery.sizeOf(context).height / 3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.isDarkMode ? Color(0xFF2C2B2B) : Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),

                child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  builder: (context, state) {
                    if (state is ProfileInfoLoading) {
                      return 
                    
                       Loading(color: AppColors.primary, size: 42)
                    ;
                    }
                    if (state is ProfileInfoLoaded) {
                      return Column(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(state.userEntity.imageURL!),
                              ),
                            ),
                          ),
                          Gap(15),
                          Text(state.userEntity.email!),
                          Gap(10),
                          Text(
                            state.userEntity.fullName!,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is ProfileInfoError) {
                      return Center(child: Text('Error'));
                    }
                    return Container();
                  },
                ),
              ),
            ),
            Gap(30),
            FavoriteSongs(),
          ],
        ),
      ),
    );
  }
}
