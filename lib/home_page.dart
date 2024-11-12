import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ponto Eletrônico'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBaterPontoButton(
                  context, 'Início do Dia', 'Início do Dia registrado'),
              SizedBox(height: 20),
              _buildBaterPontoButton(
                  context, 'Pausa para Almoço', 'Pausa para Almoço registrada'),
              SizedBox(height: 20),
              _buildBaterPontoButton(
                  context, 'Volta do Almoço', 'Volta do Almoço registrada'),
              SizedBox(height: 20),
              _buildBaterPontoButton(
                  context, 'Fim do Expediente', 'Fim do Expediente registrado'),
            ],
          ),
        ),
      ),
      drawer: _buildDrawer(context),
    );
  }

  ElevatedButton _buildBaterPontoButton(
      BuildContext context, String texto, String mensagem) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(mensagem)));
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        textStyle: TextStyle(fontSize: 18),
      ),
      child: Text(texto),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Menu de Navegação'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Listar Funcionários'),
            onTap: () {
              Navigator.pushNamed(context, '/listagem');
            },
          ),
          ListTile(
            title: Text('Adicionar Funcionário'),
            onTap: () {
              Navigator.pushNamed(context, '/formulario');
            },
          ),
        ],
      ),
    );
  }
}
