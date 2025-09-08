extension StringExtension on String {
  bool get hasNoData => isEmpty || trim().isEmpty;

  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  String get removeSpecialCharacters {
    return replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  String get removeExtraSpaces {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String get toAllCaps => toUpperCase();
}
