import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/logic/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:test_app/res/wallpaper_strings.dart';

import '../../res/wallpaper_colors.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            _buildCategoryItem(context,"ALL", "assets/all_category.jpg","000"),
            _buildCategoryItem(context,"GENERAL", "assets/general_category.jpg","100"),
            _buildCategoryItem(context,"ANIME", "assets/anime_category.jpg","101"),
            _buildCategoryItem(context,"PEOPLE", "assets/people_category.png","111"),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context,String title, String imageAddress,String categoryCode) {
    return InkWell(
      onTap: () => _loadCategoryWallpapersFromApi(context,categoryCode),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(width: 1, color: WallpaperColors.secondaryColor)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imageAddress,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: WallpaperColors.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const SizedBox(),
                  )),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loadCategoryWallpapersFromApi(BuildContext context,String categoryCode) {
    WallpaperString.CATEGORY_PARAM = categoryCode;
    WallpaperString.ADD_PARAM ="&categories=${WallpaperString.CATEGORY_PARAM}&page=${WallpaperString.PAGE_PARAM}";
    BlocProvider.of<WallpaperBloc>(context).add(LoadWallpaperFromRepositoryEvent());
  }
}
