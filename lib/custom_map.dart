import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'model.dart';
import 'widgets/controls.dart';
import 'widgets/search.dart';
import 'widgets/wide_button.dart';

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      tileProvider: CancellableNetworkTileProvider(),
    );

CameraFit ghanaBounds = const CameraFit.coordinates(
    coordinates: [LatLng(11.166667, -3.255555), LatLng(4.733333, 1.2)]);

class CustomSearchAndPickMap extends StatefulWidget {
  final void Function(PickedData pickedData) onPicked;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;
  final IconData currentLocationIcon;
  final IconData locationPinIcon;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color locationPinIconColor;
  final String locationPinText;
  final TextStyle locationPinTextStyle;
  final String buttonText;
  final String hintText;
  final double buttonHeight;
  final double buttonWidth;
  final TextStyle buttonTextStyle;
  final String baseUri;

  const CustomSearchAndPickMap({
    super.key,
    required this.onPicked,
    this.zoomOutIcon = Icons.zoom_out_map,
    this.zoomInIcon = Icons.zoom_in_map,
    this.currentLocationIcon = Icons.my_location,
    this.buttonColor = Colors.blue,
    this.locationPinIconColor = Colors.blue,
    this.locationPinText = 'Location',
    this.locationPinTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
    this.hintText = 'Search Location',
    this.buttonTextStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    this.buttonTextColor = Colors.white,
    this.buttonText = 'Set Current Location',
    this.buttonHeight = 50,
    this.buttonWidth = 200,
    this.baseUri = 'https://nominatim.openstreetmap.org',
    this.locationPinIcon = Icons.location_on,
  });

  @override
  State<CustomSearchAndPickMap> createState() =>
      _OpenStreetMapSearchAndPickState();
}

class _OpenStreetMapSearchAndPickState extends State<CustomSearchAndPickMap> {
  MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  late Future<Position?> latlongFuture;
  final Dio dio = Dio();

  @override
  void initState() {
    _mapController = MapController();
    _mapController.mapEventStream.listen(
      (event) async {
        if (event is MapEventMoveEnd) {
          String url =
              '${widget.baseUri}/reverse?format=json&lat=${event.camera.center.latitude}&lon=${event.camera.center.longitude}&zoom=18&addressdetails=1';
          try {
            Response response = await dio.get(url);
            var decodedResponse = response.data as Map<String, dynamic>;
            _searchController.text = decodedResponse['display_name'];
            setState(() {});
          } catch (e) {
            if (kDebugMode) {
              print("Error during map move: $e");
            }
          }
        }
      },
    );

    latlongFuture = getCurrentPosLatLong();

    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor, width: 3.0),
    );
    return FutureBuilder<Position?>(
      future: latlongFuture,
      builder: (context, snapshot) {
        LatLng? mapCentre;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          log(snapshot.error.toString());
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          mapCentre = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
        }
        return SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: FlutterMap(
                  options: MapOptions(
                      initialCenter: mapCentre!,
                      initialZoom: 15.0,
                      initialCameraFit: ghanaBounds,
                      maxZoom: 30,
                      interactionOptions:
                          const InteractionOptions(flags: InteractiveFlag.all),
                      minZoom: 6),
                  mapController: _mapController,
                  children: [openStreetMapTileLayer],
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Icon(
                        widget.locationPinIcon,
                        size: 50,
                        color: widget.locationPinIconColor,
                      ),
                    ),
                  ),
                ),
              ),
              MapControls(
                zoomInIcon: Icons.zoom_in,
                zoomOutIcon: Icons.zoom_out,
                currentLocationIcon: Icons.my_location,
                buttonColor: Colors.blue,
                buttonTextColor: Colors.white,
                onZoomIn: () {
                  _mapController.move(
                    _mapController.camera.center,
                    _mapController.camera.zoom + 1,
                  );
                },
                onZoomOut: () {
                  _mapController.move(
                    _mapController.camera.center,
                    _mapController.camera.zoom - 1,
                  );
                },
                onMoveToCurrentLocation: () async {
                  if (mapCentre != null) {
                    _mapController.move(
                      LatLng(mapCentre.latitude, mapCentre.longitude),
                      _mapController.camera.zoom,
                    );
                  } else {
                    _mapController.move(
                      const LatLng(50.5, 30.51),
                      _mapController.camera.zoom,
                    );
                  }
                  await setNameCurrentPos();
                },
              ),
              SearchBarWidget(
                searchController: _searchController,
                baseUri: widget.baseUri, // Search API base URI
                hintText: 'Search for a location...', // Search hint text
                mapController: _mapController, // Pass the map controller
                onOptionSelected: (LatLng location) {
                  print('Selected Location: $location');
                },
                inputBorder: inputBorder,
                inputFocusBorder: inputFocusBorder,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WideButton(
                      widget.buttonText,
                      textStyle: widget.buttonTextStyle,
                      height: widget.buttonHeight,
                      width: widget.buttonWidth,
                      onPressed: () async {
                        final value = await pickData();
                        widget.onPicked(value);
                      },
                      backgroundColor: widget.buttonColor,
                      foregroundColor: widget.buttonTextColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<Position?> getCurrentPosLatLong() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      return await getPosition(locationPermission);
    }

    Position position = await Geolocator.getCurrentPosition();
    await setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

  Future<Position?> getPosition(LocationPermission locationPermission) async {
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      return null;
    }
    Position position = await Geolocator.getCurrentPosition();
    await setNameCurrentPosAtInit(position.latitude, position.longitude);
    return position;
  }

  Future<void> setNameCurrentPos() async {
    double latitude = _mapController.camera.center.latitude;
    double longitude = _mapController.camera.center.longitude;

    if (kDebugMode) {
      print("Latitude: $latitude, Longitude: $longitude");
    }

    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    try {
      Response response = await dio.get(url);
      var decodedResponse = response.data as Map<String, dynamic>;

      _searchController.text =
          decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print("Error during reverse geocoding: $e");
      }
    }
  }

  Future<void> setNameCurrentPosAtInit(
      double latitude, double longitude) async {
    String url =
        '${widget.baseUri}/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    try {
      Response response = await dio.get(url);
      var decodedResponse = response.data as Map<String, dynamic>;

      _searchController.text =
          decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print("Error during reverse geocoding at init: $e");
      }
    }
  }

  Future<PickedData> pickData() async {
    LatLng center = LatLng(_mapController.camera.center.latitude,
        _mapController.camera.center.longitude);

    String url =
        '${widget.baseUri}/reverse?format=json&lat=${center.latitude}&lon=${center.longitude}&zoom=18&addressdetails=1';

    try {
      Response response = await dio.get(url);
      var decodedResponse = response.data as Map<String, dynamic>;

      String displayName = decodedResponse['display_name'];
      return PickedData(center, displayName, decodedResponse["address"]);
    } catch (e) {
      if (kDebugMode) {
        print("Error picking data: $e");
      }
      return PickedData(center, "Error retrieving data", {});
    }
  }
}
