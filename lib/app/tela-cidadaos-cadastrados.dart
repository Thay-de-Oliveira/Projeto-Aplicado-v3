import 'package:flutter/material.dart';
import 'components/globais/barra-superior.dart';
import 'components/globais/menu-inferior.dart';

// Classe Modelo para o Cidadão
class Cidadao {
  String name;
  String cpf;
  String rg;
  String telefone;
  int numeroPessoas;
  String nomeAtendente;
  String codigoIdentificacao;
  String dataVistoria;
  String ocorrencia;
  String enderecoOcorrencia;

  Cidadao({
    required this.name,
    required this.cpf,
    required this.rg,
    required this.telefone,
    required this.numeroPessoas,
    required this.nomeAtendente,
    required this.codigoIdentificacao,
    required this.dataVistoria,
    required this.ocorrencia,
    required this.enderecoOcorrencia,
  });
}

class DadosCidadao extends StatefulWidget {
  @override
  _DadosCidadaoState createState() => _DadosCidadaoState();
}

class _DadosCidadaoState extends State<DadosCidadao> {
  List<Cidadao> cidadaos = []; // Lista para manter os cidadãos

  Widget buildCidadaoCard(Cidadao cidadao) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesCidadaoPage(cidadao: cidadao))),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey, spreadRadius: 2)],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${cidadao.name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Último Atendimento: ${cidadao.dataVistoria}'),
            Text('Cobrade: ${cidadao.ocorrencia}'),
            /*FlatButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesCidadaoPage(cidadao: cidadao))),
              child: Text('Informações >'),
              textColor: Colors.blue,
            )*/
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 120,
            backgroundColor: Colors.white,
            flexibleSpace: BarraSuperior(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => buildCidadaoCard(cidadaos[index]),
              childCount: cidadaos.length,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(color: Colors.white),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}

class DetalhesCidadaoPage extends StatelessWidget {
  final Cidadao cidadao;

  DetalhesCidadaoPage({required this.cidadao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do Cidadão'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(title: Text('Nome do solicitante: ${cidadao.name}')),
          ListTile(title: Text('CPF do solicitante: ${cidadao.cpf}')),
          ListTile(title: Text('RG do solicitante: ${cidadao.rg}')),
          ListTile(title: Text('Telefone do solicitante: ${cidadao.telefone}')),
          ListTile(title: Text('Número de pessoas no imóvel: ${cidadao.numeroPessoas}')),
          ListTile(title: Text('Nome do atendente: ${cidadao.nomeAtendente}')),
          ListTile(title: Text('Código de identificação: ${cidadao.codigoIdentificacao}')),
          ListTile(title: Text('Data da vistoria: ${cidadao.dataVistoria}')),
          ListTile(title: Text('Ocorrência: ${cidadao.ocorrencia}')),
          ListTile(title: Text('Endereço da ocorrência: ${cidadao.enderecoOcorrencia}')),
        ],
      ),
    );
  }
}