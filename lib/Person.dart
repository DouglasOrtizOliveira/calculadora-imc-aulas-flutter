import 'package:flutter/material.dart';

class Person{
  String result;
  String resultimc;
  double imc;
  int sex;
  double weight, heigth;
  Color color;
  
  Person({this.sex, this.weight, this.heigth, this.result, this.imc});

  calcularImc(){
    double calculeImc;

    calculeImc = this.weight / (this.heigth * this.heigth);
    imc = calculeImc;

    return calculeImc;
  }


  void calcMasc(){
     result = "";
      if (imc < 20.7){
        result += "Abaixo do peso";
        color = Colors.blue;
      }
      else if (imc < 26.5){
        result += "Peso ideal";
        color = Colors.green;
      }
      else if (imc < 27.9){
        result += "Levemente acima do peso";
        color = Colors.yellow;
      }
      else if (imc < 31.1){
        result += "Acima do peso";
        color = Colors.orange;
      }
      else {
        result += "Obesidade";
        color = Colors.red;
      }
      resultimc = "IMC = ${imc.toStringAsPrecision(2)}";
  }

void calcFem(){
        result = "";
      if (imc < 19.1){
        result = "Abaixo do peso";
        color = Colors.blue;
      }  
      else if (imc < 25.8){
        result = "Peso ideal";
         color = Colors.green;
      }
      else if (imc < 27.3){
        result += "Levemente acima do peso";
        color = Colors.yellow;
      }  
      else if (imc < 32.3){
        result += "Acima do peso";
        color = Colors.orange;
      }
        else{
        result += "Obesidade ";
         color = Colors.red;
        }
        resultimc = "IMC = ${imc.toStringAsPrecision(2)}";
 }



void msgErro(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Erro:"),
          content: new Text("É obrigatório selecionar o sexo."),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}

}