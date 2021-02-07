import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/utils/utils.dart';
import 'package:latlong/latlong.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../core/extension/extensions.dart';
import '../../core/utils/map_utils.dart';
import '../../widget/general/gm_scaffold.dart';
import 'widget/map_stop_list_tile.dart';
import 'widget/map_stop_marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key key,
  }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeCubit = context.watch<RouteCubit>();
    final route = routeCubit.route;
    final lastPosition = routeCubit.lastPosition;
    final routePath = route.routePath;
    return BlocBuilder<RouteCubit, RouteState>(
      builder: (_, state) => GMScaffold(
        withAppBar: false,
        body: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(
                      // TODO
                      route.stops[1].latitude,
                      route.stops[1].longitude,
                      //lastPosition.latitude,
                      //lastPosition.longitude,
                    ),
                    zoom: DEFAULT_MAP_ZOOM,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    PolylineLayerOptions(
                      polylines: [
                        Polyline(
                          points: decodeEncodedPath(routePath),
                          strokeWidth: 2,
                          color: const Color(0xFF800080),
                        ),
                      ],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        _getCurrentPositionMarker(lastPosition),
                        ..._getStopMarkers(routeCubit),
                      ],
                    ),
                  ],
                ),
                if (state is ShowedStopOnMap)
                  MapStopListTile(
                    stop: state.stop,
                    isNextStopSuggested: isStopNextSuggestion(
                      route,
                      state.stop,
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'locate-vehicle',
            backgroundColor: Colors.white,
            child: SvgPicture.asset('assets/icons/map-locate-vehicle.svg'),
            onPressed: () => _mapController.move(
              LatLng(
                lastPosition.latitude,
                lastPosition.longitude,
              ),
              DEFAULT_MAP_ZOOM,
            ),
          ),
        ),
        mainButtonLabel:
            context.getTextUppercase('driver.forro.map.seestoplist'),
        mainButtonIcon: const Icon(Icons.list),
        mainButtonAction: () => Navigator.of(context).pop(),
      ),
    );
  }

  Marker _getCurrentPositionMarker(Position lastPosition) {
    return Marker(
      width: 30,
      height: 30,
      point: LatLng(
        lastPosition.latitude,
        lastPosition.longitude,
      ),
      builder: (_) => SvgPicture.asset(
        'assets/icons/map-current-position.svg',
      ),
    );
  }

  List<Marker> _getStopMarkers(RouteCubit routeCubit) {
    final route = routeCubit.route;
    final stops = route.stops;
    return stops
        .map(
          (stop) => Marker(
            width: 30,
            height: 30,
            point: LatLng(
              stop.latitude,
              stop.longitude,
            ),
            builder: (_) => GestureDetector(
              onTap: () {
                print('aaaa');
                routeCubit.showStopOnMap(stop);
              },
              child: MapStopMarker(
                stop: stop,
                isNextSuggestion: isStopNextSuggestion(route, stop),
              ),
            ),
          ),
        )
        .toList();
  }
}
