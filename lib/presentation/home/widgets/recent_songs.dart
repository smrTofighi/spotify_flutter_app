import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/helper/is_dark_mode.dart';
import 'package:spotify_app/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify_app/common/widgets/loading.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/presentation/home/bloc/recent_songs_cubit.dart';
import 'package:spotify_app/presentation/home/bloc/recent_songs_state.dart';
import 'package:spotify_app/presentation/song_player/pages/song_player_page.dart';

class RecentSongs extends StatelessWidget {
  const RecentSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       BlocBuilder<RecentSongsCubit, RecentSongsState>(
        builder: (context, state) {
          if (state is RecentSongsLoading) {
            return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Loading(color: AppColors.primary, size: 42),
                    );
          }
          if (state is RecentSongsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Songs',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'See More',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  ListView.separated(
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SongPlayerPage(song: state.songs[index]),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.isDarkMode
                                      ? AppColors.darkGrey
                                      : Color(0xFFE6E6E6),
                                ),
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: context.isDarkMode
                                      ? Color(0xFF959595)
                                      : Color(0xFF555555),
                                ),
                              ),
                              Gap(20),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width *0.34,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 5,
                                  children: [
                                    Text(
                                      state.songs[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      state.songs[index].artist,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 20,
                            children: [
                              Text(state.songs[index].duration),
                              FavoriteButton(song: state.songs[index]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => Gap(20),
                    shrinkWrap: true,
                    itemCount: state.songs.length,
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      
    );
  }
}
