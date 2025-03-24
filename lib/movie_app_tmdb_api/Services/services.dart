import 'dart:convert';
import 'package:flutter_getx_st/http/base/http_general.dart';
import 'package:flutter_getx_st/http/base/http_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_getx_st/movie_app_tmdb_api/Model/model.dart';

const apiKey = "f95a6d45558dee5ab593965b75e80dfd";

class APIservices {
  final nowShowingApi =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
  final upComingApi =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
  // for nowShowing moveis
  Future<List<Movie>> getNowShowing() async {
    RestReponse response = await HttpGeneral.generalGet(url: nowShowingApi);
    print("response:${response.data}");
    List<Movie> movies =
        response.data["results"].map((movie) => Movie.fromMap(movie)).toList();
    return movies;
  }

  // for up coming moveis
  Future<List<Movie>> getUpComing() async {
    RestReponse response = await HttpGeneral.generalGet(url: upComingApi);
    List<Movie> movies =
        response.data["dates"].map((movie) => Movie.fromMap(movie)).toList();
    return movies;
  }

  // for popular moves
  Future<List<Movie>> getPopular() async {
    RestReponse response = await HttpGeneral.generalGet(url: popularApi);
    List<Movie> movies =
        response.data["results"].map((movie) => Movie.fromMap(movie)).toList();
    return movies;
  }
}
