import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterforms/components/mensagem.dart';
import 'package:flutterforms/screens/autenticacao/registrar.dart';
import 'package:flutterforms/screens/dashboard/dashboard.dart';

class Login extends StatelessWidget {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  width: 200,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 455,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: _construirFormulario(context)),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  _construirFormulario(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Faça seu Login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'CPF'),
            maxLength: 14,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: (value) {
              if (value.length == 0) {
                return 'informe o CPF!';
              } else if (value.length < 14) {
                return 'CPF inválido!';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            controller: _cpfController,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Senha'),
            maxLength: 15,
            validator: (value) {
              if (value.length == 0) {
                return 'informe uma Senha!';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.text,
            controller: _senhaController,
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: Text('CONTINUAR'),
              style: OutlinedButton.styleFrom(
                  primary: Theme.of(context).accentColor),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (_cpfController.text == '111.111.111-11' &&
                      _senhaController.text == 'abc123') {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ),
                        (route) => false);
                  } else {
                    exibirAlerta(
                        context: context,
                        title: 'ATENÇÂO',
                        content: 'CPF ou Senha incorretos');
                  }
                }
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Esqueci minha senha >',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          OutlinedButton(
            child: Text('Criar uma conta >'),
            style: OutlinedButton.styleFrom(
                primary: Theme.of(context).accentColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Registrar()),
              );
            },
          ),
        ],
      ),
    );
  }
}
