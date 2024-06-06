import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/common/widgets/shimmers/horizontal_buttons_shimmer.dart';
import '../../../../core/common/widgets/shimmers/horizontal_circular.dart';

class FilterPageShimmer extends StatelessWidget {
  const FilterPageShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 48,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 60,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const ShimmerCircularHorizontal(
            height: 100,
            width: 40,
            count: 5,
          ),
          const SizedBox(
            height: 48,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 100,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 10,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 100,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          const ShimmerButtonHorizontal(),
          const SizedBox(
            height: 36,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 100,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 5; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey,
                        ),
                        height: 40,
                        width: 100,
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 100,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 5; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey,
                        ),
                        height: 40,
                        width: 100,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
