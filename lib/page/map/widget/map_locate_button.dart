import 'package:flutter/material.dart';

import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

import '../../../core/utils/utils.dart';

class MapLocateButton extends StatelessWidget {
  const MapLocateButton({
    Key key,
    @required this.mapController,
    @required this.lastPosition,
  }) : super(key: key);

  final MapController mapController;
  final Position lastPosition;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'locate-vehicle',
      backgroundColor: Colors.white,
      child: SvgPicture.asset('assets/icons/map-locate-vehicle.svg'),
      onPressed: () => mapController.move(
        LatLng(
          lastPosition.latitude,
          lastPosition.longitude,
        ),
        DEFAULT_MAP_ZOOM,
      ),
    );
  }
}
