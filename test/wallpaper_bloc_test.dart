// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/data/model/wallpaper_model.dart';
import 'package:test_app/data/repository/wallpaper_repository.dart';
import 'package:test_app/logic/wallpaper_bloc/wallpaper_bloc.dart';

class MockWallpaperRepository extends Mock implements WallPaperRepository {
  @override
  Future<WallpaperModel> getWallpapers() {
    return super.noSuchMethod(Invocation.method(#getWallpapersdart, null),
        returnValue: Future.value(WallpaperModel(data: [
          Datum(
              id: "id",
              url: "url",
              shortUrl: "shortUrl",
              views: 2,
              favorites: 6,
              source: "source",
              purity: Purity.SFW,
              category: null,
              dimensionX: 1,
              dimensionY: 1,
              resolution: "resolution",
              ratio: "ratio",
              fileSize: 1,
              createdAt: DateTime.utc(2020),
              colors: ["ss"],
              path: "path",
              thumbs: Thumbs(large: "s", original: "dd", small: "ss"))
        ])));
  }
}

@GenerateMocks([MockWallpaperRepository])
void main() {

  late MockWallpaperRepository mockWallpaperRepository;
  late WallpaperBloc wallpaperBloc;
  late Datum fakeModel;
  late Datum fakeModel2;

  setUp(() {
    mockWallpaperRepository = MockWallpaperRepository();
    wallpaperBloc = WallpaperBloc(mockWallpaperRepository);
    fakeModel = Datum(
        id: "id",
        url: "url",
        shortUrl: "shortUrl",
        views: 2,
        favorites: 6,
        source: "source",
        purity: Purity.SFW,
        category: null,
        dimensionX: 1,
        dimensionY: 1,
        resolution: "resolution",
        ratio: "ratio",
        fileSize: 1,
        createdAt: DateTime.utc(2020),
        colors: ["ss"],
        path: "path",
        thumbs: Thumbs(large: "s", original: "dd", small: "ss"));
    fakeModel2 = Datum(
        id: "id2",
        url: "url",
        shortUrl: "shortUrl",
        views: 2,
        favorites: 6,
        source: "source",
        purity: Purity.SFW,
        category: null,
        dimensionX: 1,
        dimensionY: 1,
        resolution: "resolution",
        ratio: "ratio",
        fileSize: 1,
        createdAt: DateTime.utc(2020),
        colors: ["ss"],
        path: "path",
        thumbs: Thumbs(large: "s", original: "dd", small: "ss"));
  });

  group("Test Wallpaper Bloc", () {

    blocTest<WallpaperBloc, WallpaperState>("First data load from Api",
        build: () {
          when(mockWallpaperRepository.getWallpapers()).thenAnswer(
              (_) => Future.value(WallpaperModel(data: [fakeModel])));
          return wallpaperBloc;
        },
        act: (WallpaperBloc bloc) async {
           bloc.add(LoadWallpaperFromRepositoryEvent());
        },
        expect: () => <WallpaperState>[
              WallpaperLoadingState(),
              WallpaperLoadedState(WallpaperModel(data: [fakeModel]))
            ]);

    blocTest<WallpaperBloc, WallpaperState>("First data load from Api fails",
        build: () {
          when(mockWallpaperRepository.getWallpapers())
              .thenThrow((_) => "Error !");
          return wallpaperBloc;
        },
        act: (WallpaperBloc bloc) async {
          return bloc.add(LoadWallpaperFromRepositoryEvent());
        },
        expect: () => <WallpaperState>[
              WallpaperLoadingState(),
              WallpaperLoadingFailedState()
            ]);

    blocTest<WallpaperBloc, WallpaperState>("More data load from Api",
        build: () {
          when(mockWallpaperRepository.getWallpapers()).thenAnswer(
              (_) => Future.value(WallpaperModel(data: [fakeModel2])));
          return wallpaperBloc;
        },
        act: (WallpaperBloc bloc) async {
          bloc.add(LoadMoreWallpaperEvent());
        },
        expect: () => <WallpaperState>[
              MoreWallpaperLoadingState(WallpaperModel(data: [fakeModel])),
              WallpaperLoadedState(WallpaperModel(data: [
                fakeModel,
                fakeModel2,
              ])),
            ]);

    blocTest<WallpaperBloc, WallpaperState>("More data load from Api fails",
        build: () {
          when(mockWallpaperRepository.getWallpapers())
              .thenThrow((_) => "Error !");
          return wallpaperBloc;
        },
        act: (WallpaperBloc bloc) async {
          bloc.add(LoadMoreWallpaperEvent());
        },
        expect: () => <WallpaperState>[
              MoreWallpaperLoadingState(WallpaperModel(data: [])),
              WallpaperLoadingFailedState(),
            ]);
  });
}
