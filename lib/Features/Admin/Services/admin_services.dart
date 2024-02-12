import 'dart:io';

import 'package:amazon_clone_with_nodejs/Constants/utilities.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

class AdminServices {
  sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinery = CloudinaryPublic('dottlfwim', 'oy2tywma');

      List<String> imageUrls = [];

      for (var image in images) {
        CloudinaryResponse res = await cloudinery.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: name),
        );

        imageUrls.add(res.secureUrl);
      }

      final product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
