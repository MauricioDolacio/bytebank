//Tela: Lista de Transferencias
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';
import '../../models/transferencia.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  ListaTransferencias({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Barra de cima
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),

      //Coluna de Cards
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),

      //Botão '+'
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _atualiza(Transferencia? transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
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
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}
