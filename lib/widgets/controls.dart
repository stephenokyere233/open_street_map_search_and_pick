import 'package:flutter/material.dart';

class MapControls extends StatelessWidget {
  final IconData zoomInIcon;
  final IconData zoomOutIcon;
  final IconData currentLocationIcon;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onMoveToCurrentLocation;

  const MapControls({
    super.key,
    required this.zoomInIcon,
    required this.zoomOutIcon,
    required this.currentLocationIcon,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onMoveToCurrentLocation,
  });

  @override
  Widget build(BuildContext context) {
    return _buildControls();
  }

  Widget _buildControls() {
    return Positioned(
      bottom: 80,
      right: 5,
      child: Column(
        children: [
          _buildRoundedButton(
            icon: zoomInIcon,
            onPressed: onZoomIn,
          ),
          const SizedBox(height: 10),
          _buildRoundedButton(
            icon: zoomOutIcon,
            onPressed: onZoomOut,
          ),
          const SizedBox(height: 10),
          _buildRoundedButton(
            icon: currentLocationIcon,
            onPressed: onMoveToCurrentLocation,
          ),
        ],
      ),
    );
  }

  // Helper function to create a rounded button
  Widget _buildRoundedButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 50, // Set the desired button size
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: buttonColor,
      ),
      child: IconButton(
        icon: Icon(icon),
        color: buttonTextColor,
        onPressed: onPressed,
      ),
    );
  }
}
