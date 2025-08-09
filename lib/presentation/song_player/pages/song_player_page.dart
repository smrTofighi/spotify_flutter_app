import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/widgets/app_bar/app_bar.dart';
import 'package:spotify_app/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify_app/common/widgets/loading.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/domain/song/entity/song_entity.dart';
import 'package:spotify_app/presentation/song_player/cubit/song_player_cubit.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key, required this.song});
  final SongEntity song;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(
          title: Text('Now Playing', style: TextStyle(fontSize: 18)),
          action: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_rounded),
          ),
        ),
        body: BlocProvider(
          create: (context) => SongPlayerCubit()..loadSong(song.songUrl),
          child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
            builder: (context, state) {
              if (state is SongPlayerLoading) {
                return Loading(color: AppColors.primary, size: 50);
              }
              if (state is SongPlayerLoaded) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height / 2.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(song.imageUrl),
                              ),
                            ),
                          ),
                          Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                spacing: 5,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song.title,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    song.artist,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              FavoriteButton(song: song),
                            ],
                          ),
                          Gap(30),
                          BlocBuilder<SongPlayerCubit, SongPlayerState>(
                            builder: (context, state) {
                              if (state is SongPlayerLoading) {
                                return CircularProgressIndicator();
                              }
                              if (state is SongPlayerLoaded) {
                                return Column(
                                  spacing: 20,
                                  children: [
                                    Slider(
                                      value: context
                                          .read<SongPlayerCubit>()
                                          .songPosition
                                          .inSeconds
                                          .toDouble(),
                                      min: 0.0,
                                      max: context
                                          .read<SongPlayerCubit>()
                                          .songDuration
                                          .inSeconds
                                          .toDouble(),
                                      onChanged: (value) {
                                        final position = Duration(
                                          seconds: value.toInt(),
                                        );
                                        context
                                            .read<SongPlayerCubit>()
                                            .updateDurationSong(position);
                                      },
                                      activeColor: AppColors.primary,
                                      inactiveColor: AppColors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formatDuration(
                                            context
                                                .read<SongPlayerCubit>()
                                                .songPosition,
                                          ),
                                        ),
                                        Text(
                                          formatDuration(
                                            context
                                                .read<SongPlayerCubit>()
                                                .songDuration,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(20),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<SongPlayerCubit>()
                                            .playOrPauseSong();
                                      },
                                      child: Container(
                                        width: 85,
                                        height: 85,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primary,
                                        ),
                                        child: Icon(
                                          context
                                                  .read<SongPlayerCubit>()
                                                  .audioPlayer
                                                  .playing
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          size: 36,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
