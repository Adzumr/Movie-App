import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/utils/input_borders.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> movieCategory = [
    "Now playing",
    "Upcoming",
    "Top rated",
    "Popular"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgorundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "What do you want to watch?",
                style: appFonts.titleFont,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.sp),
                child: TextFormField(
                  validator: (value) => value!.isEmpty ? "Empty Object" : null,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Ionicons.search_outline,
                      ),
                    ),
                    filled: true,
                    fillColor: appColors.shadowColor,
                    enabledBorder: enableInputBorder,
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: appColors.backgorundColor,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.sp),
                height: 25.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 20.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image(
                        image: AssetImage(appImages.movie),
                        height: 23.h,
                        fit: BoxFit.fill,
                      ),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.sp),
                height: 5.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieCategory.length,
                  itemBuilder: (BuildContext context, int index) {
                    final category = movieCategory[index];
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: Text(category),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(5.sp),
                      child: Image(
                        image: AssetImage(
                          appImages.movie,
                        ),
                        fit: BoxFit.fill,
                      ),
                    );
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
