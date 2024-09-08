import 'dart:async';
import 'dart:developer';
import 'package:custom_map_search_and_pick/services/location.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:custom_map_search_and_pick/model.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.baseUri,
    required this.hintText,
    required this.mapController,
    required this.onOptionSelected,
    required this.searchController,
    this.inputBorder,
    this.inputFocusBorder,
    this.customSearchFunction,
    this.customFilterFunction,
    this.notFoundText = 'Oops..No results found!',
  });

  final TextEditingController searchController;
  final InputBorder? inputBorder;
  final InputBorder? inputFocusBorder;
  final String baseUri;
  final String hintText;
  final MapController mapController;
  final Function(LatLng) onOptionSelected;
  final Future<List<OSMModel>> Function(String)? customSearchFunction;
  final bool Function(OSMModel)? customFilterFunction;
  final String notFoundText;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  List<OSMModel> _options = [];
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

  Widget _buildSearchField() {
    return TextFormField(
      controller: widget.searchController,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: widget.inputBorder ?? const OutlineInputBorder(),
        focusedBorder: widget.inputFocusBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
        suffixIcon: _buildSuffixIcon(),
      ),
      onChanged: _onSearchTextChanged,
    );
  }

  Widget _buildSuffixIcon() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(10.0),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      );
    } else if (widget.searchController.text.isNotEmpty) {
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
    return const SizedBox();
  }

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

      // Use custom search function if provided, else default to the internal one
      if (widget.customSearchFunction != null) {
        _options = await widget.customSearchFunction!(value);
      } else {
        log(value);
        _options = await _defaultSearchFunction(value);
      }

      setState(() {
        _isLoading = false;
      });
      // Check if no results were found
      if (_options.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.notFoundText),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  /// Default search function with optional custom filter
  Future<List<OSMModel>> _defaultSearchFunction(String query) async {
    final decodedResponse =
        await LocationService.getLocationByName(query: query);
    log(name: "FILTERED RESPONSE", decodedResponse.toString());

    // Apply the custom filter if provided, otherwise return all results
    final List<OSMModel> filteredResponse = widget.customFilterFunction != null
        ? decodedResponse.where(widget.customFilterFunction!).toList()
        : decodedResponse;
    log(name: "FILTERED RESPONSE", filteredResponse.toString());
    return filteredResponse; // Return filtered list
  }

  Widget _buildOptionsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _options.length > 5 ? 5 : _options.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_options[index].displayName),
          onTap: () => _onOptionSelected(index),
        );
      },
    );
  }

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
