import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages
          .map((image) => Builder(
                builder: (context) => Image.network(
                  image,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ))
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
