import 'package:flutter/material.dart';
import 'package:test_app/data/model/wallpaper_model.dart';

class WallpaperListItem extends StatelessWidget {
  final Datum modelData;

  const WallpaperListItem(this.modelData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
            placeholder: const AssetImage("assets/placeholder.gif"),
            image: NetworkImage(modelData.thumbs.original),
            fit: BoxFit.cover));
  }
}
