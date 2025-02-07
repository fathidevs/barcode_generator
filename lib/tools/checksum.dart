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
}
