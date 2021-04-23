import 'package:flutterforms/components/editor.dart';
import 'package:flutterforms/models/saldo.dart';
import 'package:flutterforms/models/transferencia.dart';
import 'package:flutter/material.dart';
import 'package:flutterforms/models/transferencias.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';
const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                  controlador: _controladorCampoNumeroConta,
                  dica: _dicaCampoNumeroConta,
                  rotulo: _rotuloCampoNumeroConta),
              Editor(
                  controlador: _controladorCampoValor,
                  dica: _dicaCampoValor,
                  rotulo: _rotuloCampoValor,
                  icone: Icons.monetization_on),
              ElevatedButton(
                onPressed: () {
                  _criaTransferencia(context);
                },
                child: Text(_textoBotaoConfirmar),
              )
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    final transferenciaValida =
        _validaTransferencia(context, numeroConta, valor);

    if (transferenciaValida) {
      final novaTransferencia = Transferencia(valor, numeroConta);

      _atualizaEstado(context, novaTransferencia, valor);
      Navigator.pop(context);
    }
  }

  _validaTransferencia(context, numeroConta, valor) {
    final _camposPreenchidos = numeroConta != null && valor != null;
    final _saldoSuficiente =
        valor <= Provider.of<Saldo>(context, listen: false).valor;

    return _camposPreenchidos && _saldoSuficiente;
  }

  _atualizaEstado(context, novaTransferencia, valor) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);
  }
}
