import 'package:flutter/material.dart';

class MovieListSkelton extends StatelessWidget {
  const MovieListSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Skeleton(height: 30, width: 220),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Skeleton(height: 200, width: 180),
                    SizedBox(height: 15),
                    Skeleton(height: 5, width: 180),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: const [
                    Skeleton(height: 200, width: 180),
                    SizedBox(height: 15),
                    Skeleton(height: 5, width: 180),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.08),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
