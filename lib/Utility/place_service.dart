import 'dart:convert';
import 'package:http/http.dart' as http;

class PlacesService {
  final String apiKey = 'AIzaSyBk6ueDJ7vlhRhSs9XOIlt6j0XRmIrA4co';

  Future<List<PlacePrediction>> getPlacePredictions(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=$query'
      '&key=$apiKey'
      '&components=country:in',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          return (data['predictions'] as List)
              .map((p) => PlacePrediction.fromJson(p))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error fetching predictions: $e');
      return [];
    }
  }

  Future<PlaceDetails?> getPlaceDetails(String placeId) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=geometry,formatted_address,address_components'
      '&key=$apiKey',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          return PlaceDetails.fromJson(data['result']);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching place details: $e');
      return null;
    }
  }
}

class PlacePrediction {
  final String description;
  final String placeId;
  final String? mainText;

  PlacePrediction({
    required this.description,
    required this.placeId,
    this.mainText,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
      description: json['description'] ?? '',
      placeId: json['place_id'] ?? '',
      mainText: json['structured_formatting']?['main_text'],
    );
  }
}

// Place Details Model
class PlaceDetails {
  final double latitude;
  final double longitude;
  final String formattedAddress;
  final String? pincode;

  PlaceDetails({
    required this.latitude,
    required this.longitude,
    required this.formattedAddress,
    this.pincode,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    String? extractedPincode;

    if (json['address_components'] != null) {
      for (var component in json['address_components']) {
        if ((component['types'] as List).contains('postal_code')) {
          extractedPincode = component['long_name'];
          break;
        }
      }
    }

    return PlaceDetails(
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
      formattedAddress: json['formatted_address'] ?? '',
      pincode: extractedPincode,
    );
  }
}
