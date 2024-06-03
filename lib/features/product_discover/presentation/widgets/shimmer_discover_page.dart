import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DicoverPageShimmer extends StatelessWidget {
  const DicoverPageShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: size.width * 0.8,
            height: 20.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 59),
        SizedBox(
          height: 0.7 * size.height,
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (size.width ~/ 180),
              mainAxisExtent: 150,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (_, index) {
              return SizedBox(
                height: 150,
                width: 150,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
