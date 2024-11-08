import 'dart:io';

void main() {
  print('Welcome to the Calculator!');
  bool isCalculating = true;

  while (isCalculating) {
    print('Enter the first number:');
    double num1 = double.parse(stdin.readLineSync()!);

    print('Enter the second number:');
    double num2 = double.parse(stdin.readLineSync()!);

    print('Enter an operator (+, -, *, /):');
    String operator = stdin.readLineSync()!;

    double result = 0;

    switch (operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      default:
        print('Invalid operator');
        continue;
    }

    print('The result is: $result');

    print('Do you want to perform another calculation? (Y/N)');
    String continueCalculation = stdin.readLineSync()!.toUpperCase();

    isCalculating = continueCalculation == 'Y';
  }

  print('Thank you for using the Calculator!');
}
