import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/model/wallpaper_model.dart';
import 'package:test_app/logic/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:test_app/presentation/pages/wallpepar_detail_page.dart';
import 'package:test_app/presentation/widgets/category_list.dart';
import 'package:test_app/presentation/widgets/wallpaper_list_item.dart';
import 'package:test_app/res/wallpaper_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WallpaperBloc>(context)
        .add(LoadWallpaperFromRepositoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                child: Text(
                  "My Wallpapers",
                  style: TextStyle(
                      color: WallpaperColors.secondaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              )),
          const CategoryList(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshMethod,
              child: BlocBuilder<WallpaperBloc, WallpaperState>(
                builder: (context, state) {
                  if (state is WallpaperLoadingState) {
                    return _buildLoadingWidget();
                  } else if (state is WallpaperLoadedState) {
                    return _buildWallpapersListWidget(state.wallpaperModel);
                  } else if (state is MoreWallpaperLoadingState) {
                    return _buildWallpapersListWidget(state.wallpaperModel);
                  } else {
                    return _buildFailedWidget();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedWidget() {
    return const Center(
        child: Text(
      "Failed.",
      style: TextStyle(color: Colors.white),
    ));
  }

  Widget _buildWallpapersListWidget(WallpaperModel wallpaperModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        WallpaperDetailPage(wallpaperModel.data[index]),
                  ));
                },
                child: WallpaperListItem(wallpaperModel.data[index])),
            physics: const BouncingScrollPhysics(),
            itemCount: wallpaperModel.data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildLoadMoreButton()
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return BlocBuilder<WallpaperBloc, WallpaperState>(
      builder: (context, state) {
        if (state is MoreWallpaperLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return TextButton(
              onPressed: _loadMoreWallpaper,
              child: const Text(
                "Load more wallpaper ...",
                style: TextStyle(color: Colors.white),
              ));
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Future<void> _refreshMethod() async {
    BlocProvider.of<WallpaperBloc>(context)
        .add(LoadWallpaperFromRepositoryEvent());
  }

  void _loadMoreWallpaper() {
    BlocProvider.of<WallpaperBloc>(context).add(LoadMoreWallpaperEvent());
  }
}
