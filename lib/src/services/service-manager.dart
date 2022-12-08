import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:practica4_tennis_mobil/src/modules/matches-models.dart';

class ServiceManager {

  final _URL = dotenv.env['SERVER_LOCATION_API_NODE_ENDPOINT']; // This is to access variable name from .env file

  // cargar los datos del future
  Future<List<Matches>> getAllMatches() async {
    // parse of url
    final uri = Uri.parse('${_URL}/matches');
    // call api method get

    final response = await http.get(uri);
    
    // casting de los objetos que retorna la repuesta de la API
    List<Matches> matchesData = matchesDataFromJson(response.body).data;
  
    // retorna los datos
    return matchesData;
  }
}

var serviceManager = ServiceManager();
