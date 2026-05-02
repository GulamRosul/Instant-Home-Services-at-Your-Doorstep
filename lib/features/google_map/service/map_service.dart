import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapSearchResult {
  const MapSearchResult({
    required this.location,
    this.formattedAddress,
    this.name,
  });

  final LatLng location;
  final String? formattedAddress;
  final String? name;

  String? get displayLabel {
    final address = formattedAddress?.trim();
    if (address != null && address.isNotEmpty) {
      return address;
    }

    final title = name?.trim();
    if (title != null && title.isNotEmpty) {
      return title;
    }

    return null;
  }
}

class MapPlaceSuggestion {
  const MapPlaceSuggestion({
    required this.placeId,
    required this.description,
    this.primaryText,
    this.secondaryText,
  });

  final String placeId;
  final String description;
  final String? primaryText;
  final String? secondaryText;
}

class MapService {
  MapService({required this.apiKey, http.Client? client})
    : _client = client ?? http.Client();

  final String apiKey;
  final http.Client _client;

  static const String _nominatimUserAgent =
      'protiva502/1.0 (support@protiva502.app)';

  Future<MapSearchResult?> searchPlace(String query) async {
    final uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/textsearch/json',
      {'query': query, 'key': apiKey},
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Place search failed.');
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final status = payload['status'] as String? ?? 'UNKNOWN_ERROR';

    if (status == 'ZERO_RESULTS') {
      return null;
    }

    if (status != 'OK') {
      throw Exception(
        payload['error_message'] as String? ?? 'Unable to search place.',
      );
    }

    final results = payload['results'] as List<dynamic>;
    if (results.isEmpty) {
      return null;
    }

    final place = results.first as Map<String, dynamic>;
    final geometry = place['geometry'] as Map<String, dynamic>? ?? {};
    final location = geometry['location'] as Map<String, dynamic>? ?? {};
    final lat = location['lat'];
    final lng = location['lng'];

    if (lat is! num || lng is! num) {
      return null;
    }

    return MapSearchResult(
      location: LatLng(lat.toDouble(), lng.toDouble()),
      formattedAddress: place['formatted_address'] as String?,
      name: place['name'] as String?,
    );
  }

  Future<List<MapPlaceSuggestion>> getPlaceSuggestions(String query) async {
    final uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/autocomplete/json',
      {'input': query, 'key': apiKey, 'components': 'country:bd'},
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Place autocomplete failed.');
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final status = payload['status'] as String? ?? 'UNKNOWN_ERROR';

    if (status == 'ZERO_RESULTS') {
      return const [];
    }

    if (status != 'OK') {
      throw Exception(
        payload['error_message'] as String? ?? 'Unable to load suggestions.',
      );
    }

    final predictions = payload['predictions'] as List<dynamic>? ?? const [];

    return predictions
        .whereType<Map<String, dynamic>>()
        .map((prediction) {
          final structuredFormatting =
              prediction['structured_formatting'] as Map<String, dynamic>? ??
              const {};

          return MapPlaceSuggestion(
            placeId: prediction['place_id'] as String? ?? '',
            description: prediction['description'] as String? ?? '',
            primaryText: structuredFormatting['main_text'] as String?,
            secondaryText: structuredFormatting['secondary_text'] as String?,
          );
        })
        .where(
          (suggestion) =>
              suggestion.placeId.isNotEmpty &&
              suggestion.description.isNotEmpty,
        )
        .toList();
  }

  Future<MapSearchResult?> getPlaceDetails(String placeId) async {
    final uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/details/json',
      {
        'place_id': placeId,
        'fields': 'geometry,formatted_address,name',
        'key': apiKey,
      },
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Place details failed.');
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final status = payload['status'] as String? ?? 'UNKNOWN_ERROR';

    if (status != 'OK') {
      throw Exception(
        payload['error_message'] as String? ?? 'Unable to load place details.',
      );
    }

    final result = payload['result'] as Map<String, dynamic>? ?? const {};
    final geometry = result['geometry'] as Map<String, dynamic>? ?? {};
    final location = geometry['location'] as Map<String, dynamic>? ?? {};
    final lat = location['lat'];
    final lng = location['lng'];

    if (lat is! num || lng is! num) {
      return null;
    }

    return MapSearchResult(
      location: LatLng(lat.toDouble(), lng.toDouble()),
      formattedAddress: result['formatted_address'] as String?,
      name: result['name'] as String?,
    );
  }

  Future<String?> reverseGeocode(LatLng location) async {
    final googleAddress = await _reverseGeocodeWithGoogle(location);
    if (googleAddress != null) {
      return googleAddress;
    }

    return _reverseGeocodeWithOpenStreetMap(location);
  }

  Future<String?> _reverseGeocodeWithGoogle(LatLng location) async {
    final uri = Uri.https('maps.googleapis.com', 'maps/api/geocode/json', {
      'latlng': '${location.latitude},${location.longitude}',
      'key': apiKey,
    });

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      return null;
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final status = payload['status'] as String? ?? 'UNKNOWN_ERROR';

    if (status != 'OK') {
      return null;
    }

    final results = payload['results'] as List<dynamic>;
    if (results.isEmpty) {
      return null;
    }

    final firstResult = results.first as Map<String, dynamic>;
    final formattedAddress = firstResult['formatted_address'] as String?;

    if (formattedAddress == null || formattedAddress.trim().isEmpty) {
      return null;
    }

    return formattedAddress.trim();
  }

  Future<String?> _reverseGeocodeWithOpenStreetMap(LatLng location) async {
    final uri = Uri.https('nominatim.openstreetmap.org', '/reverse', {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'format': 'jsonv2',
      'zoom': '18',
      'addressdetails': '1',
    });

    final response = await _client.get(
      uri,
      headers: {'User-Agent': _nominatimUserAgent},
    );

    if (response.statusCode != 200) {
      return null;
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final displayName = payload['display_name'] as String?;

    if (displayName == null || displayName.trim().isEmpty) {
      return null;
    }

    return displayName.trim();
  }

  Future<MapSearchResult?> lookupApproximateLocationFromIp() async {
    final uri = Uri.https('ipapi.co', '/json/');

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      return null;
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final latitude = payload['latitude'];
    final longitude = payload['longitude'];

    if (latitude is! num || longitude is! num) {
      return null;
    }

    final city = (payload['city'] as String?)?.trim();
    final region = (payload['region'] as String?)?.trim();
    final country = (payload['country_name'] as String?)?.trim();

    final labelParts = <String>[
      if (city != null && city.isNotEmpty) city,
      if (region != null && region.isNotEmpty) region,
      if (country != null && country.isNotEmpty) country,
    ];

    return MapSearchResult(
      location: LatLng(latitude.toDouble(), longitude.toDouble()),
      formattedAddress: labelParts.isEmpty ? null : labelParts.join(', '),
    );
  }

  void dispose() {
    _client.close();
  }
}
