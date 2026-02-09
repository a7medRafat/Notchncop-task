extension DateStringX on String? {
  String get yearOrDash {
    final v = this;
    if (v == null || v.trim().isEmpty) return '—';
    if (v.length < 4) return '—';
    return v.substring(0, 4);
  }
}
