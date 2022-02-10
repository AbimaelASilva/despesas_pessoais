import 'package:intl/intl.dart';

String doubleToCurrency(double value) {
  Intl.defaultLocale = 'pt_BR';

  NumberFormat formatter = NumberFormat.simpleCurrency();

  String f1 = formatter.format(value);

  String formateOk = f1.substring(2, (f1.length));
 // print('MOEDA FORMATADA sub: $formateOk');

  return formateOk;
}
