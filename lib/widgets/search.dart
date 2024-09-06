import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:custom_map_search_and_pick/model.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget(
      {super.key,
      required this.baseUri,
      required this.hintText,
      required this.mapController,
      required this.onOptionSelected,
      required this.searchController,
      this.inputBorder,
      this.inputFocusBorder});

  final TextEditingController searchController;
  final InputBorder? inputBorder;
  final InputBorder? inputFocusBorder;
  final String baseUri;
  final String hintText;
  final MapController mapController;
  final Function(LatLng) onOptionSelected;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  List<OSMdata> _options = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: _buildSearchContainer(),
      ),
    );
  }

  Widget _buildSearchContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          _buildSearchField(),
          _buildOptionsList(),
        ],
      ),
    );
  }

  /// Method to Build the Search Field
  Widget _buildSearchField() {
    return TextFormField(
      controller:
          widget.searchController, // Use the controller passed from parent
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        suffixIcon: _buildSuffixIcon(), // Add the loader and clear button here
      ),
      onChanged: _onSearchTextChanged,
    );
  }

  /// Method to Build the Suffix Icon (Loader or Clear Button)
  Widget _buildSuffixIcon() {
    if (_isLoading) {
      // Show loading spinner
      return const Padding(
        padding: EdgeInsets.all(10.0),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      );
    } else if (widget.searchController.text.isNotEmpty) {
      // Show clear button when there's text
      return IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          setState(() {
            widget.searchController.clear();
            _options.clear();
          });
        },
      );
    }
    return const SizedBox(); // Show nothing if there is no text and not loading
  }

  /// Search Field Text Change Handler
  void _onSearchTextChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value.isEmpty) {
        setState(() {
          _options.clear();
        });
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final client = http.Client();
      try {
        final url =
            '${widget.baseUri}/search?q=$value&format=json&polygon_geojson=1&addressdetails=1';

        final response = await client.get(Uri.parse(url));
        final decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

        // Filter for items where "country_code" is "gh" or "country" is "Ghana"
        final filteredResponse = decodedResponse.where((e) {
          final countryCode = e['address']['country_code']?.toLowerCase();
          final country = e['address']['country']?.toLowerCase();
          return countryCode == 'gh' || country == 'ghana';
        }).toList();

        setState(() {
          _options = filteredResponse
              .map(
                (e) => OSMdata(
                  displayname: e['display_name'],
                  lat: double.parse(e['lat']),
                  lon: double.parse(e['lon']),
                ),
              )
              .toList();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
        client.close();
      }
    });
  }

  /// Method to Build the Options List
  Widget _buildOptionsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _options.length > 5 ? 5 : _options.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_options[index].displayname),
          onTap: () => _onOptionSelected(index),
        );
      },
    );
  }

  /// Option Selection Handler
  void _onOptionSelected(int index) {
    widget.mapController.move(
      LatLng(_options[index].lat, _options[index].lon),
      15.0,
    );

    _focusNode.unfocus();
    widget.onOptionSelected(LatLng(_options[index].lat, _options[index].lon));
    _options.clear();
    setState(() {});
  }
}
