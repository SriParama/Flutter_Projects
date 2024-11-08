import 'dart:io';


class Calc{
  
  var firstvalue=double.parse(stdin.readLineSync()!);
  var secondvalue=double.parse(stdin.readLineSync()!);
  
  
  void add()=>print("The addition value is ${firstvalue+secondvalue}");
  void sub()=>print("The addition value is ${firstvalue-secondvalue}");
  void mult()=>print("The addition value is ${firstvalue*secondvalue}");
  void div()=>print("The addition value is ${firstvalue/secondvalue}");
  void mod()=>print("The addition value is ${firstvalue%secondvalue}");
}



void main(){
      print("Enter the two value:");
    var cal= Calc();
    cal.add();
    cal.sub();
    cal.mult();
    cal.div();
    cal.mod();

}