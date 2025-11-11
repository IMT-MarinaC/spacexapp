DateTime? parseNullableDate(dynamic value) {
  if (value == null) return null;
  try {
    return DateTime.parse(value.toString());
  } catch (_) {
    return null;
  }
}

List<String> stringListFromJson(dynamic v) {
  if (v == null) return [];
  if (v is List) return v.map((e) => e?.toString() ?? '').toList();
  if (v is String) return [v];
  return [];
}
