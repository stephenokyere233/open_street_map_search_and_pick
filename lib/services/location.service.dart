import 'dart:developer';

import 'package:custom_map_search_and_pick/model.dart';
import 'package:dio/dio.dart';

class LocationService {
  LocationService._();

  static Future<List<OSMModel>> getLocationByName(
      {String baseUri = 'https://nominatim.openstreetmap.org',
      required String query}) async {
    final dio = Dio();
    try {
      final url =
          '$baseUri/search?q=$query&format=json&polygon_geojson=1&addressdetails=1';
      final response = await dio.get(url);

      final decodedResponse = response.data as List<dynamic>;
      log(name: "decoded response", decodedResponse.toString());
      return decodedResponse.map((data) => OSMModel.fromJson(data)).toList();
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? "DioException occurred";
    } catch (e) {
      log("Error fetching location data: $e");
      return [];
    } finally {
      dio.close();
    }
  }

  static Future<OSMModel?> getLocationByCoordinates(
      {String baseUri = 'https://nominatim.openstreetmap.org',
      required double lat,
      required double lng}) async {
    final dio = Dio();
    try {
      final String url =
          '$baseUri/reverse?format=json&lat=$lat&lon=$lng&zoom=18&addressdetails=1';
      final response = await dio.get(url);

      final decodedResponse = response.data;
      log(name: "decoded response", decodedResponse.toString());
      return OSMModel.fromJson(decodedResponse);
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? "DioException occurred";
    } catch (e) {
      log("Error fetching coordinates data: $e");
      return null;
    } finally {
      dio.close();
    }
  }
}
