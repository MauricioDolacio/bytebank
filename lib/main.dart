import 'package:flutter/material.dart';

void main() =>
    runApp(BytebankApp()); //Colocar dessa forma faz o Hot Reload funcionar

//Aplicativo
class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

//Tela: Formulario de Transferencia
class FormularioTransferencia extends StatelessWidget {
  //Criando controladores (recebem as informações dos campos)
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        children: [
          //Campo Numero da Conta
          Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: 'Número da conta',
              dica: '0000'),
          //Campo Valor
          Editor(
              controlador: _controladorCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icone: Icons.monetization_on),
          //Botão Confirmar
          ElevatedButton(
            child: const Text('Confirmar'),
            onPressed: () => _criaTransferencia(context),
          )
        ],
      ),
    );
  }

  //Método que cria as transferencias
  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('criando transferencia');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //Margens
      padding:
          const EdgeInsets.all(16.0), //all coloca margens por todas as direções
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 22.0),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

//Tela: Lista de Transferencias
class ListaTransferencias extends StatelessWidget {
  final List<Transferencia> _transferencias = [];

  @override
  Widget build(BuildContext context) {
    _transferencias.add(Transferencia(100.00, 1000));
    return Scaffold(
      //Barra de cima
      appBar: AppBar(
        title: const Text('Transferências'),
      ),

      //Coluna de Cards
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),

      //Botão '+'
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');
            _transferencias.add(transferenciaRecebida!);
          });
        },
        child: const Icon(Icons.add),
      ),
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
      leading: const Icon(Icons.monetization_on),
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

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
