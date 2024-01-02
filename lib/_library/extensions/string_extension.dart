extension StringExtension on String {
  String get getValueOrDefault {
    return this;
  }

  T? item<T>() {
    if (T == bool) return bool.fromEnvironment(this) as T;
    if (T == int) return int.tryParse(this) as T?;
    if (T == double) return double.parse(this) as T;
    if (T == String) return this as T;
    return null;
  }
}
