
import 'dart:convert';

WallpaperModel wallpaperModelFromJson(String str) => WallpaperModel.fromJson(json.decode(str));

String wallpaperModelToJson(WallpaperModel data) => json.encode(data.toJson());

class WallpaperModel {
  WallpaperModel({
    this.data =const [],
  });

  List<Datum> data;

  factory WallpaperModel.fromJson(Map<String, dynamic> json) => WallpaperModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required  this.id,
    required  this.url,
    required  this.shortUrl,
    required  this.views,
    required  this.favorites,
    required  this.source,
    required  this.purity,
    required  this.category,
    required  this.dimensionX,
    required  this.dimensionY,
    required  this.resolution,
    required  this.ratio,
    required  this.fileSize,
    required  this.createdAt,
    required  this.colors,
    required  this.path,
    required  this.thumbs,
  });

  String id;
  String url;
  String shortUrl;
  int views;
  int favorites;
  String source;
  Purity purity;
  Category category;
  int dimensionX;
  int dimensionY;
  String resolution;
  String ratio;
  int fileSize;
  DateTime createdAt;
  List<String> colors;
  String path;
  Thumbs thumbs;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    url: json["url"],
    shortUrl: json["short_url"],
    views: json["views"],
    favorites: json["favorites"],
    source: json["source"],
    purity: purityValues.map[json["purity"]] as Purity,
    category: categoryValues.map[json["category"]] as Category,
    dimensionX: json["dimension_x"],
    dimensionY: json["dimension_y"],
    resolution: json["resolution"],
    ratio: json["ratio"],
    fileSize: json["file_size"],
    createdAt: DateTime.parse(json["created_at"]),
    colors: List<String>.from(json["colors"].map((x) => x)),
    path: json["path"],
    thumbs: Thumbs.fromJson(json["thumbs"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "short_url": shortUrl,
    "views": views,
    "favorites": favorites,
    "source": source,
    "purity": purityValues.reverse[purity],
    "category": categoryValues.reverse[category],
    "dimension_x": dimensionX,
    "dimension_y": dimensionY,
    "resolution": resolution,
    "ratio": ratio,
    "file_size": fileSize,
    "created_at": createdAt.toIso8601String(),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "path": path,
    "thumbs": thumbs.toJson(),
  };
}

enum Category { PEOPLE, ANIME, GENERAL }

final categoryValues = EnumValues({
  "anime": Category.ANIME,
  "general": Category.GENERAL,
  "people": Category.PEOPLE
});

enum FileType { IMAGE_PNG, IMAGE_JPEG }

final fileTypeValues = EnumValues({
  "image/jpeg": FileType.IMAGE_JPEG,
  "image/png": FileType.IMAGE_PNG
});

enum Purity { SFW, SKETCHY }

final purityValues = EnumValues({
  "sfw": Purity.SFW,
  "sketchy": Purity.SKETCHY
});

class Thumbs {
  Thumbs({
    required  this.large,
    required  this.original,
    required  this.small,
  });

  String large;
  String original;
  String small;

  factory Thumbs.fromJson(Map<String, dynamic> json) => Thumbs(
    large: json["large"],
    original: json["original"],
    small: json["small"],
  );

  Map<String, dynamic> toJson() => {
    "large": large,
    "original": original,
    "small": small,
  };
}

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
