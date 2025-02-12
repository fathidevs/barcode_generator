class Checksum {
  final String code;
  Checksum({required this.code});

  int ean13Checksum() {
    // if (code.length < 12) {
    //   throw ArgumentError("Barcode must have 12 digits.");
    // }
    String barcode = code.substring(0, code.length - 1);
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
