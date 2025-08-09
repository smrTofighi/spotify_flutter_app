import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify_app/common/widgets/loading.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/presentation/profile/cubit/favorite_songs_cubit.dart';

class FavoriteSongs extends StatelessWidget {
  const FavoriteSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Favorite Songs'.toUpperCase()),
            Gap(20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return Loading(color: AppColors.primary, size: 42);
                }
                if (state is FavoriteSongsLoaded) {
                  if (state.songList.isEmpty) {
                    return Center(child: Text('No Favorite Songs'));
                  } else {
                    return ListView.separated(
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.songList[index].imageUrl,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Gap(10),
                              Column(
                                spacing: 5,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.songList[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    state.songList[index].artist,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            spacing: 20,
                            children: [
                              Text(state.songList[index].duration),
                              FavoriteButton(
                                song: state.songList[index],
                                key: UniqueKey(),
                                onDelete: () {
                                  context
                                      .read<FavoriteSongsCubit>()
                                      .removeSongFromFavorite(index);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => Gap(20),
                      itemCount: state.songList.length,
                      shrinkWrap: true,
                    );
                  }
                }
                if (state is FavoriteSongsError) {
                  return Center(child: Text('Something went wrong'));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
