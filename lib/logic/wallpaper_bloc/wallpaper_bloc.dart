
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/data/model/wallpaper_model.dart';
import 'package:test_app/data/repository/wallpaper_repository.dart';
import 'package:test_app/res/wallpaper_strings.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  late final WallPaperRepository _wallPaperRepository;


  WallpaperBloc(this._wallPaperRepository) : super(WallpaperLoadingState()) {

    WallpaperModel wallpaperModel = WallpaperModel();

    on<LoadWallpaperFromRepositoryEvent>((event, emit) async{
      emit(WallpaperLoadingState());
      try{
        wallpaperModel =await _wallPaperRepository.getWallpapers();
      }catch (e){
        emit(WallpaperLoadingFailedState());
      }finally {
        if(wallpaperModel.data.isNotEmpty) {
          emit(WallpaperLoadedState(wallpaperModel));
        }
      }
    });

    on<LoadMoreWallpaperEvent>((event, emit) async{
      WallpaperModel tempWallpaperModel = WallpaperModel();
      emit(MoreWallpaperLoadingState(wallpaperModel));
      try{
        WallpaperString.PAGE_PARAM = WallpaperString.PAGE_PARAM + 1 ;
        WallpaperString.ADD_PARAM ="&categories=${WallpaperString.CATEGORY_PARAM}&page=${WallpaperString.PAGE_PARAM}";
        tempWallpaperModel =await _wallPaperRepository.getWallpapers();
      }catch (e){
        emit(WallpaperLoadingFailedState());
      }finally {
        if(tempWallpaperModel.data.isNotEmpty) {
          wallpaperModel.data = List.from(wallpaperModel.data)..addAll(tempWallpaperModel.data);
          emit(WallpaperLoadedState(wallpaperModel));
        }
      }
    });
  }
}
