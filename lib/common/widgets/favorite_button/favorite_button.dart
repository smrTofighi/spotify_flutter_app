import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/domain/song/entity/song_entity.dart';

import '../../bloc/favorite_button/favorite_button_state.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.song, this.onDelete});
  final Function ? onDelete;
  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(song.songId);
              },
              icon: Icon(
                song.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                size: 25,
                color: song.isFavorite ? AppColors.primary : AppColors.darkGrey
              ),
            );
          }
          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
               context.read<FavoriteButtonCubit>().favoriteButtonUpdated(song.songId);
                if(onDelete!=null){
                  onDelete!();
                }
              },
              icon: Icon(
                  state.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  size: 25,
                  color: song.isFavorite ? AppColors.primary : AppColors.darkGrey
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
