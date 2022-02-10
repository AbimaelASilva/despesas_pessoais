import 'package:intl/intl.dart';

String formateDate(dateToFormate) {
/*  var date = dateToFormate.toString().split(' ');
  String separatedDateToHour = date[0];
  var separatedDateYearMountDday = separatedDateToHour.split('-');
  String formatedDate = separatedDateYearMountDday[2] +
      '/' +
      separatedDateYearMountDday[1] +
      '/' +
      separatedDateYearMountDday[0];
       // print('DATA: $formatedDate');
  // print('DATA DO PEDIDO ${request.id}: $formatedDate');
//  return formatedDate;
*/
  //final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(dateToFormate);

  return formatted;
}
