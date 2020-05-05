import 'dart:async';
import 'package:movies/src/models/actores_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActoresProvider {
  String _apiKey = 'dd48a6e26d794ab6452fc1ccd2f5fcc7';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Actor>> getCast(String peliId) async {
    
    final url = Uri.https( _url, '/3/movie/$peliId/credits',{
      'api_key': _apiKey, 
      'language': _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);  //Crear el mapa

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }
  
}