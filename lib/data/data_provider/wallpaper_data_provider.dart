import 'package:http/http.dart' as http;
import 'package:test_app/res/wallpaper_strings.dart';

class WallPaperDataProvider {
  Future<http.Response> wallPaperApi() async {
    final rawWallpaperData = await http.get(
        Uri.parse("${WallpaperString.API_BASE_URL}${WallpaperString.API_KEY}${WallpaperString.ADD_PARAM}"));
    return rawWallpaperData;
  }
}
