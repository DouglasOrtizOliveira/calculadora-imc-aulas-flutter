import 'package:flutter/material.dart';
import 'package:calculadora_imc/Person.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  
  Person _person = Person();
  
  @override
  void initState() {
    super.initState();
    resetFields();
  }

  
  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    _results = 0;
    setState(() {
      _person.result = 'Informe seus dados';
      _person.resultimc = "";
      _person.color = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      backgroundColor: Colors.black26,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          sexButton(),
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }


    int _results = 0;
  int _buttonValue;
  
  void _handleButtonValueChange(int value) {
    setState(() {
      _buttonValue = value;
  
      switch (_buttonValue) {
        case 0:
          _results = 1;
          break;
        case 1:
          _results = 2;
          break;
      }
    });
  }


  void calculateImc() {
   _person.weight = double.parse(_weightController.text);
   _person.heigth = double.parse(_heightController.text) / 100.0;
  
  
    _person.imc = _person.calcularImc();
    setState(() {
      if(_results == 1){
          _person.calcMasc();
        }else if(_results == 2){
          _person.calcFem();
        }else{
         _person.msgErro(context);
        }
    });
    
  }
   
   Widget sexButton(){
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 0.01),
       child: new Row(
       mainAxisAlignment: MainAxisAlignment.center ,
       children: <Widget>[
          new Radio(
            value: 0,
            groupValue: _buttonValue,
            onChanged: _handleButtonValueChange,
          ),
          new Text(
            'Masculino',
            style: new TextStyle(
            fontSize: 20.0,
            ),
          ),
          new Radio(
            activeColor: Colors.pink,
            value: 1,
             groupValue: _buttonValue,
            onChanged: _handleButtonValueChange,
          ),
          new Text(
            'Feminino',
            style: new TextStyle(
            fontSize: 20.0,
            ),
          ),
        ]
     ),
   );
  }


  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculateImc();
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.black87)),
      ),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: new Column(
        
        mainAxisAlignment: MainAxisAlignment.center ,
        children: <Widget>[
        
        Text(
       _person.resultimc,
        textAlign: TextAlign.center, 
        style: TextStyle(color: Colors.black, fontSize: 36.0, fontWeight: FontWeight.bold),
    ),
   
    new Text(
      _person.result,
        textAlign: TextAlign.right,
        
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: _person.color),  
    
        ),
      ],
     ),
    );
  }

  Widget buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}
