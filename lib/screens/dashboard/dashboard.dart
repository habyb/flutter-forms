import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterforms/screens/autenticacao/login.dart';
import 'package:flutterforms/screens/dashboard/saldo.dart';
import 'package:flutterforms/screens/deposito/formulario.dart';
import 'package:flutterforms/screens/transferencia/formulario.dart';
import 'package:flutterforms/screens/transferencia/ultimas.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Receber depósito'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioDeposito();
                    }),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Nova transferência'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioTransferencia();
                    }),
                  );
                },
              )
            ],
          ),
          UltimasTransferencias(),
          Column(
            children: [
              ElevatedButton(
                child: Text('Sair'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return Login();
                  }), (route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
