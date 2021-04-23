import 'package:flutter/material.dart';
import 'package:flutterforms/models/transferencias.dart';
import 'package:flutterforms/screens/transferencia/lista.dart';
import 'package:provider/provider.dart';

final _titulo = 'Últimas transferências';

class UltimasTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        Consumer<Transferencias>(builder: (context, transferencias, child) {
          final _ultimasTransferencias =
              transferencias.transferencias.reversed.toList();
          final _quantidade = transferencias.transferencias.length;
          int tamanho = 2;
          
          if (_quantidade == 0) {
            return SemTransferenciaCadastrada();
          }

          if (_quantidade < 3) {
            tamanho = _quantidade;
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: tamanho,
            shrinkWrap: true,
            itemBuilder: (context, indice) {
              return ItemTransferencia(_ultimasTransferencias[indice]);
            },
          );
        }),
        ElevatedButton(
          child: Text('Ver todas as transferências'),
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ListaTransferencias();
              }),
            );
          },
        )
      ],
    );
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Você ainda não cadastrou nenhuma transferência',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
