enum RequestType { Import, Export }

extension RequestTypeExtension on RequestType {
  int get value {
    final values = {
      RequestType.Import: 1,
      RequestType.Export: 2,
    };

    return values[this]!;
  }

  static RequestType fromInt(int value) {
    final values = {
      1: RequestType.Import,
      2: RequestType.Export,
    };

    return values[value]!;
  }
}
