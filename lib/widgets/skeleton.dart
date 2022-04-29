import 'package:flutter/material.dart';

class MovieSkelton extends StatelessWidget {
  const MovieSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Skeleton(height: 200, width: 200),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Skeleton(height: 5),
                  SizedBox(height: 10),
                  Skeleton(height: 5),
                  SizedBox(height: 10),
                  Skeleton(height: 5),
                  SizedBox(height: 10),
                  Skeleton(height: 5),
                  SizedBox(height: 10),
                  Skeleton(height: 100),
                ],
              ),
            ),
          )
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
