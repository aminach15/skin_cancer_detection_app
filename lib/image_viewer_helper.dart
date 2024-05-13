import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_skin_cancer_app/utils/constants/colors.dart';

class ImageViewerHelper{
  ImageViewerHelper._();

  static show({
    required BuildContext context,
    required String url,
    BoxFit? fit,
    double? radius
}){
    return CachedNetworkImage(
      imageUrl :url,
      fit: fit ?? BoxFit.cover,
      imageBuilder: (context,imageProvider){
        return Container(
          decoration: BoxDecoration(
            color: DColors.primary,
            borderRadius: BorderRadius.circular(radius ?? 8),
            image: DecorationImage(
              image: imageProvider,fit: fit ?? BoxFit.cover
            )
          ),
        );

      },
      placeholder: (context,url) => Container(),
      errorWidget: (context,url,error) =>const Icon(Icons.error_outline_outlined),

    );

}
}