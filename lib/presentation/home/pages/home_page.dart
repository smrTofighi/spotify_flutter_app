import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:spotify_app/common/helper/is_dark_mode.dart';
import 'package:spotify_app/common/widgets/app_bar/app_bar.dart';
import 'package:spotify_app/core/themes/app_colors.dart';
import 'package:spotify_app/gen/assets.gen.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_app/presentation/home/bloc/recent_songs_cubit.dart';
import 'package:spotify_app/presentation/home/widgets/news_songs.dart';
import 'package:spotify_app/presentation/home/widgets/recent_songs.dart';
import 'package:spotify_app/presentation/profile/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<RecentSongsCubit>().getNewsSongs();
      await context.read<NewsSongsCubit>().getNewsSongs();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          Assets.vectors.spotifyLogo,
          height: 40,
          width: 40,
        ),
        action: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          icon: Icon(Icons.person_2_rounded),
        ),
        hideBack: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset(Assets.vectors.homeTopCard),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 60.0),
                        child: Image.asset(Assets.images.homeArtist.path),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            TabBar(
              controller: tabController,
              labelColor: context.isDarkMode ? Colors.white : Colors.black,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              indicatorColor: AppColors.primary,
              tabs: [
                Text(
                  'News',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  'Videos',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  'Artists',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  'Podcasts',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: tabController,
                children: [
                  NewsSongs(),
                  Center(child: Text('Coming Soon!')),
                  Center(child: Text('Coming Soon!')),
                  Center(child: Text('Coming Soon!')),
                ],
              ),
            ),

            RecentSongs(),
          ],
        ),
      ),
    );
  }
}
