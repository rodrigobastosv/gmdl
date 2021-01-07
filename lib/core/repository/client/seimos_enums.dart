enum MatchMode {
  START,
  EXACT,
}

extension MatchModeExt on MatchMode {
  String get value {
    switch (this) {
      case MatchMode.START:
        return 'START';
      case MatchMode.EXACT:
        return 'EXACT';
      default:
        return 'START';
    }
  }
}

enum SortMode {
  ASC,
  DESC,
}

extension SortModeExt on SortMode {
  String get value {
    switch (this) {
      case SortMode.ASC:
        return 'ASC';
      case SortMode.DESC:
        return 'DESC';
      default:
        return 'ASC';
    }
  }
}
