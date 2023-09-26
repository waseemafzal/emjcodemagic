import 'dart:convert';

import 'package:emjay_global/model/city_model.dart';
import 'package:emjay_global/model/country_model.dart';
import 'package:emjay_global/model/state_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CountryStateCityController extends GetxController {
  Future<List<CountryModel>> getCountries() async {
    final response = await http.get(
        Uri.parse('https://project.cyphersol.com/emj/emjApi/getCountries'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<CountryModel> countries = [];
      for (var item in jsonData['data']) {
        countries.add(CountryModel(
          countryId: item['country_id'],
          countryName: item['country'],
        ));
      }
      return countries;
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<List<StateModel>> getStatesByCountryId(String countryId) async {
    final response = await http.get(Uri.parse(
        'https://project.cyphersol.com/emj/emjApi/getStates?country_id=$countryId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<StateModel> states = [];
      for (var item in jsonData['data']) {
        states.add(StateModel(
          stateId: item['id'],
          stateName: item['name'],
        ));
      }
      return states;
    } else {
      throw Exception('Failed to load states');
    }
  }

  Future<List<CityModel>> getCitiesByStateId(String stateId) async {
    final response = await http.get(Uri.parse(
        'https://project.cyphersol.com/emj/emjApi/getCities?state_id=$stateId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<CityModel> cities = [];
      for (var item in jsonData['data']) {
        cities.add(CityModel(
          cityId: item['id'],
          cityName: item['name'],
        ));
      }
      return cities;
    } else {
      throw Exception('Failed to load states');
    }
  }
}
