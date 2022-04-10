part of 'wallpaper_bloc.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();
}

class WallpaperLoadingState extends WallpaperState {
  @override
  List<Object> get props => [];
}


class MoreWallpaperLoadingState extends WallpaperState {
  final WallpaperModel wallpaperModel;

  const MoreWallpaperLoadingState(this.wallpaperModel);

  @override
  List<Object> get props => [wallpaperModel];
}

class WallpaperLoadedState extends WallpaperState {
  final WallpaperModel wallpaperModel;

  const WallpaperLoadedState(this.wallpaperModel);

  @override

  List<Object?> get props => [wallpaperModel];

}

class WallpaperLoadingFailedState extends WallpaperState {
  @override

  List<Object?> get props => [];
}
