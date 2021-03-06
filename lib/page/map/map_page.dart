import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/extensions.dart';
import '../../core/utils/map_utils.dart';
import '../../core/utils/utils.dart';
import '../../widget/general/gm_scaffold.dart';
import 'widget/map_locate_button.dart';
import 'widget/map_stop_list_tile.dart';

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
    final mapCubit = context.watch<MapCubit>();
    final routeCubit = mapCubit.routeCubit;
    final route = routeCubit.route;
    final lastPosition = routeCubit.lastPosition;
    final routePath = route.routePath;
    return BlocBuilder<MapCubit, MapState>(
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
                      lastPosition.latitude,
                      lastPosition.longitude,
                    ),
                    zoom: DEFAULT_MAP_ZOOM,
                    onTap: (position) => mapCubit.showStopOnMap(null),
                  ),
                  layers: [
                    tileOptions,
                    PolylineLayerOptions(
                      polylines: [
                        Polyline(
                          points: decodeEncodedPath(routePath),
                          strokeWidth: DEFAULT_POLYLINE_WIDTH,
                          color: PLANNED_PATH_COLOR,
                        ),
                      ],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        getMarkerOnPosition(lastPosition),
                        ...getMapStopMarkers(mapCubit),
                      ],
                    ),
                  ],
                ),
                if (state is MapShowStop && state.stop != null)
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
          floatingActionButton: MapLocateButton(
            mapController: _mapController,
            lastPosition: lastPosition,
          ),
        ),
        mainButtonLabel:
            context.getText('driver.forro.map.seestoplist'),
        mainButtonIcon: const Icon(Icons.list),
        mainButtonAction: () => Navigator.of(context).pop(),
      ),
    );
  }
}
