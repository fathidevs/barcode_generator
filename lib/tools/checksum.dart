class Checksum {
  final String code;
  Checksum({required this.code});

  List<int> get _digits =>
      code.split('').map((digit) => int.parse(digit)).toList();

  int get lastDigit => _digits.last;

  int _odd() {
    int odd = 0;
    for (int i = 0; i < _digits.length - 1; i += 2) {
      odd += _digits[i];
    }
    return odd;
  }

  int _even() {
    int even = 0;
    for (int i = 1; i < _digits.length - 1; i += 2) {
      even += _digits[i];
    }
    return even;
  }

  int get _sum => _odd() + (_even() * lastDigit);

  int get _modulo => _sum % 10;

  int get checksum => 10 - _modulo;

  int calculateChecksum(String barcode) {
    if (barcode.length != 12) {
      throw ArgumentError("Barcode must have 12 digits.");
    }

    int sum = 0;

    // Iterate through the barcode digits, calculating the weighted sum
    for (int i = 0; i < barcode.length; i++) {
      int digit = int.parse(barcode[i]);
      if (i % 2 == 0) {
        // Odd positions (1st, 3rd, 5th, ...) multiply by 1
        sum += digit * 1;
      } else {
        // Even positions (2nd, 4th, 6th, ...) multiply by 3
        sum += digit * 3;
      }
    }

    // Calculate the checksum
    int remainder = sum % 10;
    int checksum =
        (10 - remainder) % 10; // This ensures it wraps around to 0 if necessary

    return checksum;
  }
}
