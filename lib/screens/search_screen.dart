import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/services/search_service.dart';
import 'package:sizer/sizer.dart';

import '../utils/input_borders.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.sp),
                child: TextFormField(
                  autofocus: true,
                  validator: (value) => value!.isEmpty ? "Empty Object" : null,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchMovie(keyword: "Spider");
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
              const Expanded(
                child: Center(
                  child: Text("No Result found"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
