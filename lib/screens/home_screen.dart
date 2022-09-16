import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/providers/now_playing_provider.dart';
import 'package:movie_app/providers/popular_provider.dart';
import 'package:movie_app/providers/top_rated_provider.dart';
import 'package:movie_app/providers/upcoming_provider.dart';
import 'package:movie_app/screens/popular_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/constants.dart';
import '../utils/input_borders.dart';
import 'detailed_screen.dart';
import 'now_playing_list_screen.dart';
import 'search_screen.dart';
import 'top_rated_list_screen.dart';
import 'up_coming_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future loadData() async {
    final data = Provider.of<TopRatedProvider>(context, listen: false);
    getTopRated = data.fetchTopRated();
    await Future.delayed(Duration.zero);
    final popularData = Provider.of<PopularProvider>(context, listen: false);
    getPopular = popularData.fetchPopular();
    await Future.delayed(Duration.zero);
    final upComingdata = Provider.of<UpComingProvider>(context, listen: false);
    getUpcoming = upComingdata.fetchUpcoming();
    await Future.delayed(Duration.zero);
    final nowPlaying = Provider.of<NowPlayProvider>(context, listen: false);
    getNowPlaying = nowPlaying.fetchNowPlaying();
    await Future.delayed(Duration.zero);
  }

  Future? getTopRated;
  Future? getPopular;
  Future? getUpcoming;
  Future? getNowPlaying;
  @override
  Widget build(BuildContext context) {
    final topRatedMovies = Provider.of<TopRatedProvider>(context);
    final popularData = Provider.of<PopularProvider>(context);
    final upComingdata = Provider.of<UpComingProvider>(context);
    final nowPlaying = Provider.of<NowPlayProvider>(context);

    return Scaffold(
      backgroundColor: appColors.backgorundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                child: Container( 
                  margin: EdgeInsets.symmetric(vertical: 10.sp),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Empty Object" : null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Ionicons.search_outline),
                      ),
                      filled: true,
                      enabled: false,
                      fillColor: appColors.shadowColor,
                      enabledBorder: enableInputBorder,
                      disabledBorder: enableInputBorder,
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: appColors.backgorundColor,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "What do you want to watch?",
                style: appFonts.titleFont,
              ),
              Expanded(
                child: FutureBuilder(
                  future: getNowPlaying,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return const HomeShimmerWidget();
                        },
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        nowPlaying.nowPlayingModel != null &&
                        topRatedMovies.topRatedModel != null &&
                        popularData.popularModel != null &&
                        upComingdata.upComingModel != null) {
                      return ListView(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Now playing category
                          NowPlayingWidget(nowPlayingdata: nowPlaying),
                          // Popular category
                          PopularWidget(popularData: popularData),

                          // Top rated category
                          TopRated(topRatedMovies: topRatedMovies),

                          // Upcoming category
                          UpcomingWidget(upComingdata: upComingdata),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return const HomeShimmerWidget();
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({
    Key? key,
    required this.upComingdata,
  }) : super(key: key);

  final UpComingProvider upComingdata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Upcoming movies"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpComingListScreen(
                        models: upComingdata.upComingModel,
                      ),
                    ),
                  );
                },
                child: const Text("View All"),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5.sp),
          height: 23.h,
          constraints: const BoxConstraints(),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: ((context, index) {
              final movie = upComingdata.upComingModel!.results![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedScreen(
                        movieId: "${movie.id}",
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: imageBaseUrl + "${movie.backdropPath}",
                      width: 25.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Text(
                          "No\nImage",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class TopRated extends StatelessWidget {
  const TopRated({
    Key? key,
    required this.topRatedMovies,
  }) : super(key: key);

  final TopRatedProvider topRatedMovies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Top rated movies"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopRatedListScreen(
                        models: topRatedMovies.topRatedModel,
                      ),
                    ),
                  );
                },
                child: const Text("View All"),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5.sp),
          height: 23.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: ((context, index) {
              final movie = topRatedMovies.topRatedModel!.results![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedScreen(
                        movieId: "${movie.id}",
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: imageBaseUrl + "${movie.backdropPath}",
                      width: 25.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Text(
                          "No\nImage",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class PopularWidget extends StatelessWidget {
  const PopularWidget({
    Key? key,
    required this.popularData,
  }) : super(key: key);

  final PopularProvider popularData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Popular movies"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PopularListScreen(
                        models: popularData.popularModel,
                      ),
                    ),
                  );
                },
                child: const Text("View All"),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5.sp),
          height: 23.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: ((context, index) {
              final movie = popularData.popularModel!.results![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedScreen(
                        movieId: "${movie.id}",
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: imageBaseUrl + "${movie.backdropPath}",
                      width: 25.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Text(
                          "No\nImage",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({
    Key? key,
    required this.nowPlayingdata,
  }) : super(key: key);

  final NowPlayProvider nowPlayingdata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Now Playing"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NowPlayingListScreen(
                        models: nowPlayingdata.nowPlayingModel,
                      ),
                    ),
                  );
                },
                child: const Text("View All"),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5.sp),
          height: 23.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: ((context, index) {
              final movie = nowPlayingdata.nowPlayingModel!.results![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedScreen(
                        movieId: "${movie.id}",
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: imageBaseUrl + "${movie.backdropPath}",
                      width: 25.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Text(
                          "No\nImage",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      height: 30.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GFShimmer(
                mainColor: appColors.shadowColor,
                secondaryColor: appColors.shadowColor.withOpacity(.5),
                direction: GFShimmerDirection.leftToRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 2.h,
                    width: 18.h,
                    color: appColors.backgorundColor,
                  ),
                ),
              ),
              GFShimmer(
                mainColor: appColors.shadowColor,
                secondaryColor: appColors.shadowColor.withOpacity(.5),
                direction: GFShimmerDirection.leftToRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 2.h,
                    width: 13.h,
                    color: appColors.backgorundColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 26.h,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    GFShimmer(
                      mainColor: appColors.shadowColor,
                      secondaryColor: appColors.shadowColor.withOpacity(.5),
                      direction: GFShimmerDirection.leftToRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 25.h,
                          width: 25.h,
                          color: appColors.backgorundColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w)
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
