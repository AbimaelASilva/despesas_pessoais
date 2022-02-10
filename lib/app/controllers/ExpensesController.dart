import 'package:despesas_pessoais/app/generalUse/formateDate.dart';
import 'package:despesas_pessoais/app/models/ExpensesModel.dart';
import 'package:despesas_pessoais/app/repositories/ExpensesRepositorie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpensesController extends GetxController {
  // #### CONTROLLERS ####
  int idExpense = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController dateRegisterController = TextEditingController();
  TextEditingController startDateFilterController = TextEditingController(
      text: formateDate(DateTime.now()
          .subtract(Duration(days: 30, hours: 0, minutes: 0, seconds: 0))));
  TextEditingController endDateFilterController =
      TextEditingController(text: formateDate(DateTime.now()));

  double heightFull = 0;
  double widthFull = 0;
  bool consultingExpense = true;
  bool thereIsExpense = true;
  List<ExpensesModel> allExpensesList = [];
  void getAllExpanses() async {
    allExpensesList = await ExpensesRepositorie().getAllExpanses();
    // print('tamanho as despesas ${allExpensesList.length}');
    // print('há  despesas thereIsExpense: $thereIsExpense');

  //organize list by Date
    allExpensesList
        .sort((starDate, endDate) => starDate.date.compareTo(endDate.date));
        
    consultingExpense = false;
    filterList('no');
    update();

    if (allExpensesList.isEmpty) {
      thereIsExpense = false;
      update();
    }
    update();
  }

  List<String> daysOfTheWeekList = [
    'D',
    'S',
    'T',
    'Q',
    'Q',
    'S',
    'S',
  ];
  double sumAmountExpenses = 0;
  void sumAmountExpensesFunction() {
    sumAmountExpenses = allExpensesList
        .map((expense) => expense)
        .fold(0, (prev, amount) => prev + amount.value);
    // print('VALOR TOTAL DAS DESPESAS: $sumAmountExpenses');
  }

  List<ExpensesModel> filteredExpensesList = [];
  filterList(String filter) {
    //format  startDateFilterController
    var dateDivderStart = startDateFilterController.text.split('-');
    String yyyyStart = dateDivderStart[2];
    String mmStart = dateDivderStart[1];
    String ddStart = dateDivderStart[0];

    //format  endDateFilterController
    var dateDivderEnd = endDateFilterController.text.split('-');
    String yyyyEnd = dateDivderEnd[2];
    String mmEnd = dateDivderEnd[1];
    String ddEnd = dateDivderEnd[0];
    //   String brDateToInternacional =  DateFormat("yyyy-MM-dd").format(DateTime.parse("15-08-2021"));
    // DateFormat("dd-MM-yyyy").format(DateTime.parse("2019-09-30"));
    //  .format(DateTime.parse('${startDateFilterController.text}T00:00:00.000000+00:00'));

    // print('==> DATA brDateToInternacional: $brDateToInternacional');

    filteredExpensesList = allExpensesList.where((expense) {
      // print('==>DENTRO DO FILTRO');
      if (filter == 'no') {
        print('==>DENTRO DO FILTRO AQUI' '');
        return expense.date
                .isAfter(DateTime.parse('$yyyyStart-$mmStart-$ddStart')) &&
            expense.date.isBefore(DateTime.parse(
                '$yyyyEnd-$mmEnd-$ddEnd' + 'T23:59:59.338723+00:00'));
      } else {
        return (expense.title.toLowerCase().contains(filter.toLowerCase())) &&
            expense.date
                .isAfter(DateTime.parse('$yyyyStart-$mmStart-$ddStart')) &&
            expense.date.isBefore(DateTime.parse(
                '$yyyyEnd-$mmEnd-$ddEnd' + 'T23:59:59.338723+00:00'));
      }
    }).toList();

    //DateTime.parse('2021-08-16T14:30:41.338723+00:00')
    //  DateTime.parse(DateFormat('yyyy-MM-dd').format())
    update();
  }

  double sumAmountExpensesByDayFunction(int indexWeekDay) {
    double sumAmountExpensesByDay = allExpensesList.map((expense) {
      // Ajsutando o primeiro dia da semana par domingo(por padrão era segunda feira)
      if ((expense.date.add(Duration(days: 1)).weekday) == indexWeekDay + 1) {
        return expense.value;
      } else {
        return 0;
      }
    }).fold(0, (prev, value) => prev + value);
    // print(        'VALOR TOTAL DESPESAS DIA(${indexWeekDay + 1}): $sumAmountExpensesByDay');
    fillPercentFunction(sumAmountExpensesByDay);
    return sumAmountExpensesByDay;
  }

  double fillPercent = 0;
  double fillStop = 0;
  List<double> stops = [];
  fillPercentFunction(double value) {
    fillPercent = (value * 100) / sumAmountExpenses;

    fillStop = (100 - fillPercent) / 100;

    stops = [0.0, fillStop, fillStop, sumAmountExpenses];
  }

  void clearControllers() {
    titleController.clear();
    valueController.clear();
    dateRegisterController.clear();
    update();
  }

  ExpensesModel expenseEnteredInTheControls() => ExpensesModel(
        date: dateWithoutFormate,
        id: idExpense,
        title: titleController.text,
        value: double.parse(valueController.text.replaceAll(',', '.')),
      );

  DateTime currentDate = DateTime.now();
  DateTime dateWithoutFormate = DateTime.now();
  selectDate(BuildContext context, String comingFrom) async {
    String helpText = '';
    switch (comingFrom) {
      case 'expenseDate':
        helpText = 'Data da despesa';
        break;
      case 'stardDateFilter':
        helpText = 'Data Inicial';
        break;
      case 'endDateFilter':
        helpText = 'Data Final';
        break;
      default:
    }
    final DateTime? pickedDate = await showDatePicker(
        helpText: helpText,
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate) {
      switch (comingFrom) {
        case 'expenseDate':
          dateWithoutFormate = pickedDate;
          dateRegisterController.text = formateDate(pickedDate);
          break;
        case 'stardDateFilter':
          //format  endDateFilterController
          var dateDivderEnd = endDateFilterController.text.split('-');
          String yyyyEnd = dateDivderEnd[2];
          String mmEnd = dateDivderEnd[1];
          String ddEnd = dateDivderEnd[0];
          if (pickedDate.isAfter(DateTime.parse('$yyyyEnd-$mmEnd-$ddEnd'))) {
            Get.snackbar(
                'Ops!', 'A data inicial não pode ser maior que a data final!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black87,
                colorText: Colors.white);
          } else {
            startDateFilterController.text = formateDate(pickedDate);
            filterList('no');
          }

          break;
        case 'endDateFilter':
          //format  startDateFilterController
          var dateDivderStart = startDateFilterController.text.split('-');
          String yyyyStart = dateDivderStart[2];
          String mmStart = dateDivderStart[1];
          String ddStart = dateDivderStart[0];

          if (pickedDate
              .isBefore(DateTime.parse('$yyyyStart-$mmStart-$ddStart'))) {
            Get.snackbar(
                'Ops!', 'A data final não pode ser menor que a data inicial!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black87,
                colorText: Colors.white);
          } else {
            endDateFilterController.text = formateDate(pickedDate);
            filterList('no');
          }

          break;
        default:
      }

      update();
    }
  }

  verifyIfEmptyController() {
    bool verify = (titleController.text.isNotEmpty &&
            valueController.text.isNotEmpty &&
            dateRegisterController.text.isNotEmpty)
        ? true
        : false;

    if (verify) {
      registerOrEditExpense();
    } else {
      Get.snackbar('Ops!', 'Preencha o(s) Campo(s) Vazio(s)!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white);
    }
  }

  bool inEditOrRegisterExpensesProcess = false;
  registerOrEditExpense() async {
    inEditOrRegisterExpensesProcess = true;
    update();
    bool returnEditOrRegisterExpense = false;
    if (isEditing) {
      returnEditOrRegisterExpense = await ExpensesRepositorie()
          .updateExpense(expenseEnteredInTheControls());
    } else {
      returnEditOrRegisterExpense = await ExpensesRepositorie()
          .registerNewExpense(expenseEnteredInTheControls());
    }

    if (returnEditOrRegisterExpense) {
      Get.back();
      Get.snackbar(
          'Muito Bem',
          isEditing
              ? 'Despesa atualizada com Sucesso!'
              : 'Despesa registrada com Sucesso!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white);
      getAllExpanses();
      clearControllers();
      inEditOrRegisterExpensesProcess = false;

      update();
    } else {
      Get.back();
      Get.snackbar(
          'Ops!',
          isEditing
              ? 'Falha ao atualizar a despesa!'
              : 'Falha ao registrar a despesa!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white);
      inEditOrRegisterExpensesProcess = false;
      isEditing = false;
      update();
    }

    update();
  }

  bool isEditing = false;

  void loadControllersToEdit(ExpensesModel expenseToEdit) {
    isEditing = true;
    idExpense = expenseToEdit.id;
    titleController.text = expenseToEdit.title;
    valueController.text = expenseToEdit.value.toString();
    dateRegisterController.text = expenseToEdit.date.toString();
    update();
  }
}
