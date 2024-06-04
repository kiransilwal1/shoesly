import 'package:flutter/material.dart';
import '../../../../core/widgets/shimmers/horizontal_circular.dart';
import '../../../../core/widgets/shimmers/shimmer_container_hard.dart';
import '../../../../core/widgets/shimmers/shimmer_container_rounded.dart';

class ShimmerProductDetail extends StatelessWidget {
  const ShimmerProductDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 44, 30, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerContainerRounded(
                height: size.width * 0.8,
                width: size.width * 0.8,
              ),
              const SizedBox(
                height: 24,
              ),
              ShimmerContainerHardEdge(height: 20, width: size.width / 2),
              const SizedBox(
                height: 12,
              ),
              ShimmerContainerHardEdge(height: 10, width: size.width / 3),
              const SizedBox(
                height: 24,
              ),
              ShimmerContainerHardEdge(height: 20, width: size.width / 2),
              const SizedBox(
                height: 24,
              ),
              const ShimmerCircularHorizontal(height: 40, width: 40, count: 5),
              const SizedBox(
                height: 24,
              ),
              ShimmerContainerHardEdge(height: 20, width: size.width / 2),
              const SizedBox(
                height: 24,
              ),
              ShimmerContainerHardEdge(height: 60, width: size.width * 0.8),
              const SizedBox(
                height: 24,
              ),
              ShimmerContainerHardEdge(height: 20, width: size.width / 2),
              const SizedBox(
                height: 24,
              ),
              ShimmerContainerHardEdge(height: 60, width: size.width * 0.8),
              const SizedBox(
                height: 12,
              ),
              ShimmerContainerHardEdge(height: 60, width: size.width * 0.8),
              const SizedBox(
                height: 12,
              ),
              ShimmerContainerHardEdge(height: 60, width: size.width * 0.8),
              const SizedBox(
                height: 12,
              ),
            ]),
      ),
    );
  }
}
