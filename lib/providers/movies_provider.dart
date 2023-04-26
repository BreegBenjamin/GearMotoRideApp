import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/gear_moto_ride_model.dart';

import 'package:gear_moto_ride_app/helpers/debouncer.dart';

import 'package:gear_moto_ride_app/models/models.dart';
import 'package:gear_moto_ride_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '324f660cfd9d984ba74e315eca1e0c06';
  final String _baseUrl = 'api.themoviedb.org';
  final String _baseUrlMotoGear = "kc2aszeh.api.sanity.io";
  final String _language = 'es-ES';
  String _querySanity =
      "*[motoId != null]{motoId, weight,motorcycleName, textDescription, category, year,country,category,cylinderCapacity,cylinders,engineTiming,maximumPower,maximumTorque,acceleration,maximumSpeed,driving,brakePower,imageUrlFrontPage,imageUrlBackground,brand}";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  List<Motorcycle> listMotocicles = [];
  List<Motorcycle> popularListMotocicles = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  int _numPageMoto = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamContoller =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream => _suggestionStreamContoller.stream;

  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();

    getGearMotoRideFirstData();
    //Notify
    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  //Moto Ride Api
  Future<String> _getJsonDataFromMotoApi(String query) async {
    var url = Uri.https(_baseUrlMotoGear, '/v2023-04-24/data/query/production',
        {'query': query});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
  }

  void getMotorcycleByPagination() async {
    _numPageMoto += 10;
    int numMP = _numPageMoto - 10;
    String query = "$_querySanity[$numMP...$_numPageMoto]";
    String json = await _getJsonDataFromMotoApi(query);
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      final results = await searchMovies(value);
      _suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }

  //Moto Providers Data
  void getGearMotoRideFirstData() async {
    try {
      String json = await _getJsonDataFromMotoApi(_querySanity);
      GearMotoRideModel response = gearMotoRideModelFromJson(json);
      if (response.motorcycle.any((element) => true)) {
        listMotocicles = response.motorcycle;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
