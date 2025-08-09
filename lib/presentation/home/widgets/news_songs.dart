import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/helper/is_dark_mode.dart';
import 'package:spotify_app/common/widgets/loading.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_app/presentation/song_player/pages/song_player_page.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
        builder: (context, state) {
          if (state is NewsSongsLoading) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Loading(color: AppColors.primary, size: 42),
            );
          }
          if (state is NewsSongsLoaded) {
            return ListView.separated(
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
                child: Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 12 : 0,
                    right: index == state.songs.length - 1 ? 12 : 0,
                  ),
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: state.songs[index].imageUrl,
                          placeholder:(context, url) =>  SizedBox(
                            width: 175,
                            height: 160,
                            child: Loading(color: AppColors.primary, size: 32),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  state.songs[index].imageUrl,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: 175,
                            height: 160,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 40,
                                height: 40,
                                transform: Matrix4.translationValues(10, 10, 0),
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
                            ),
                          ),
                        ),
                      ),
                      Gap(10),
                      Text(
                        state.songs[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Gap(5),
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
              ),
              separatorBuilder: (context, index) => Gap(14),
              itemCount: state.songs.length,
              scrollDirection: Axis.horizontal,
            );
          }
          return Container();
        },
      ),
    );
  }
}
