import 'package:flutter/foundation.dart';

import 'gm_base_exception.dart';

class ResourceNotFoundException implements GMBaseException {
  ResourceNotFoundException({
    @required this.resource,
    this.message,
  });

  final String resource;
  final String message;
}
