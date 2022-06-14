import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class Format {
  String decimal2(double valor) {
    var format = MoneyMaskedTextController(precision: 2);
    format.updateValue(valor);
    return format.text;
  }
}
