import 'package:latlong2/latlong.dart';

class PickedData {
  final LatLng latLong;
  final String addressName;
  final Address? address;

  PickedData(this.latLong, this.addressName, this.address);
}

class OSMModel {
  final int placeId;
  final String name;
  final String displayName;
  final Address address;
  final double lat;
  final double lon;
  final String addressType;

  final String? licence;
  final String? osmType;
  final int? osmId;
  final String? osmClass;
  final String? type;
  final int? placeRank;
  final double? importance;
  final List<String>? boundingBox;
  final GeoJson? geoJson;

  OSMModel({
    required this.placeId,
    required this.name,
    required this.displayName,
    required this.address,
    required this.lat,
    required this.lon,
    required this.addressType,
    this.licence,
    this.osmType,
    this.osmId,
    this.osmClass,
    this.type,
    this.placeRank,
    this.importance,
    this.boundingBox,
    this.geoJson,
  });

  factory OSMModel.fromJson(Map<String, dynamic> json) {
    return OSMModel(
      placeId: json['place_id'],
      name: json['name'],
      displayName: json['display_name'],
      address: Address.fromJson(json['address']),
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
      addressType: json['addresstype'] ?? '', // Default to empty string if null
      licence: json['licence'],
      osmType: json['osm_type'],
      osmId: json['osm_id'],
      osmClass: json['class'],
      type: json['type'],
      placeRank: json['place_rank'],
      importance: json['importance']?.toDouble(),
      boundingBox: json['boundingbox'] != null
          ? List<String>.from(json['boundingbox'])
          : null,
      geoJson:
          json['geojson'] != null ? GeoJson.fromJson(json['geojson']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'name': name,
      'display_name': displayName,
      'address': address.toJson(),
      'lat': lat.toString(),
      'lon': lon.toString(),
      'addresstype': addressType,
      'licence': licence,
      'osm_type': osmType,
      'osm_id': osmId,
      'class': osmClass,
      'type': type,
      'place_rank': placeRank,
      'importance': importance,
      'boundingbox': boundingBox ?? [],
      'geojson': geoJson?.toJson() ?? {},
    };
  }
}

class Address {
  final String? road;
  final String? residential;
  final String? cityDistrict;
  final String? city;
  final String? state;
  final String? isoCode;
  final String? postcode;
  final String? country;
  final String? countryCode;

  Address({
    this.road,
    this.residential,
    this.cityDistrict,
    this.city,
    this.state,
    this.isoCode,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      road: json['road'],
      residential: json['residential'],
      cityDistrict: json['city_district'],
      city: json['city'],
      state: json['state'],
      isoCode: json['ISO3166-2-lvl4'],
      postcode: json['postcode'],
      country: json['country'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'road': road,
      'residential': residential,
      'city_district': cityDistrict,
      'city': city,
      'state': state,
      'ISO3166-2-lvl4': isoCode,
      'postcode': postcode,
      'country': country,
      'country_code': countryCode,
    };
  }
}

class GeoJson {
  final String? type;
  final List<List<dynamic>>? coordinates;

  GeoJson({
    this.type,
    this.coordinates,
  });

  factory GeoJson.fromJson(Map<String, dynamic> json) {
    return GeoJson(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<List<dynamic>>.from(
              (json['coordinates'] as List).map(
                (coordinate) {
                  if (coordinate is List) {
                    return List<dynamic>.from(coordinate);
                  }
                  return []; // Return empty list if not valid
                },
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates ?? [],
    };
  }
}
