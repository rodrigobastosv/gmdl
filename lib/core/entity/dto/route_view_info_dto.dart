import 'route_dto.dart';

class RouteViewInfoDTO {
  int id;
  RouteDTO route;

  RouteViewInfoDTO({this.id, this.route});

  RouteViewInfoDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    route = json['route'] != null ? RouteDTO.fromJson(json['route']) : null;
  }
}
