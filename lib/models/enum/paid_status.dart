enum PaidStatus { Paid, Unpaid }

extension PaidStautsExtension on PaidStatus {
  int get value {
    final values = {
      PaidStatus.Paid: 1,
      PaidStatus.Unpaid: 2,
    };

    return values[this]!;
  }

  static PaidStatus fromInt(int value) {
    final values = {
      1: PaidStatus.Paid,
      2: PaidStatus.Unpaid,
    };

    return values[value]!;
  }
}
