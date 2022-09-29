import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        //Lista de Cards
        body: ListaTransferencias(),

        //Barra de cima
        appBar: AppBar(
          title: Text('Transferências'),
        ),

        //Botão '+'
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    ));

//Lista de Cards de transferencias
class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTransferencia(Transferencia(100.00, 1000)),
        ItemTransferencia(Transferencia(200.00, 1000)),
        ItemTransferencia(Transferencia(300.00, 1000)),
      ],
    );
  }
}

//Card de transferencia
class ItemTransferencia extends StatelessWidget {
  //Estamos criando um objeto Transferencia
  final Transferencia _transferencia;

  //Em nosso construtor pedimos um objeto Transferencia
  ItemTransferencia(this._transferencia);

  //Criação do card
  //Pegamos os valores inseridos no objeto e o transformamos em String para o card
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

//Parametros de transferencia
class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
}
