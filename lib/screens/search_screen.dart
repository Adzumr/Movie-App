import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/providers/search_provider.dart';
import 'package:movie_app/screens/detailed_screen.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/input_borders.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void dispose() {
    searchEditingController.clear();
    super.dispose();
  }

  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchResult = Provider.of<SearchProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: searchResult.isSearching,
      child: Scaffold(
        backgroundColor: appColors.backgorundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.sp),
                  child: TextFormField(
                    onChanged: (value) {
                      searchEditingController.text = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? "Empty Object" : null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            searchResult.fetchResult(
                                keyWord: searchEditingController.text.trim());
                          });
                        },
                        icon: const Icon(
                          Ionicons.search_outline,
                        ),
                      ),
                      filled: true,
                      fillColor: appColors.shadowColor,
                      enabledBorder: enableInputBorder,
                      border: enableInputBorder,
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: appColors.backgorundColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResult.seachModel != null
                        ? searchResult.seachModel!.results!.length
                        : 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (searchResult.seachModel == null) {
                        return SizedBox(
                          height: 80.h,
                          child: Center(
                            child: Text(
                              "Search",
                              style: appFonts.headingFont,
                            ),
                          ),
                        );
                      } else if (searchResult.seachModel!.results!.isEmpty) {
                        return SizedBox(
                          height: 80.h,
                          child: Center(
                            child: Text(
                              "Not Found",
                              style: appFonts.headingFont,
                            ),
                          ),
                        );
                      } else if (searchResult.seachModel!.results!.isNotEmpty) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final movie = searchResult.seachModel!.results![index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
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
                                margin: EdgeInsets.symmetric(vertical: 5.sp),
                                padding: EdgeInsets.all(5.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: appColors.shadowColor),
                                child: CachedNetworkImage(
                                  imageUrl: imageBaseUrl + "${movie.logoPath}",
                                  height: 15.h,
                                  width: 15.h,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const Center(
                                    child: Text(
                                      "Loading...",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Text(
                                      "No\nImage",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            SizedBox(
                              width: 35.w,
                              child: Text("${movie.name}"),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Error",
                            style: appFonts.bodyFont,
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
