extension DateTimeExtension on DateTime {
  static String get getUtc => DateTime.now().toUtc().toIso8601String();
  String get stringUtc => this.toUtc().toIso8601String();
}
