import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_responce.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/respository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();
  ApiResponse<MovieListModel> movieList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response) {
    movieList = response;
    notifyListeners();
  }

  Future<void> fatchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());
    _myRepo.fetchMoviesList().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
