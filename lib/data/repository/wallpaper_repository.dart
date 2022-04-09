
import 'package:test_app/data/data_provider/wallpaper_data_provider.dart';
import 'package:test_app/data/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class WallPaperRepository{

  Future<WallpaperModel> getWallpapers() async{
    final http.Response rawWallpaperData = await WallPaperDataProvider().wallPaperApi();
    final wallpaperModel = wallpaperModelFromJson(rawWallpaperData.body);
    return wallpaperModel;
  }
}