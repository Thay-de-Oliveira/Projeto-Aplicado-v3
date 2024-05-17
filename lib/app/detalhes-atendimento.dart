import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/app/components/globais/barra-superior.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';

class DetalhesAtendimentoScreen extends StatefulWidget {
  final AtendimentosModel atendimento;

  const DetalhesAtendimentoScreen({Key? key, required this.atendimento}) : super(key: key);

  @override
  _DetalhesAtendimentoScreenState createState() => _DetalhesAtendimentoScreenState();
}

class _DetalhesAtendimentoScreenState extends State<DetalhesAtendimentoScreen> {
  bool isPendente = false;
  AtendimentoController atendimentoController = Get.put(AtendimentoController());

  @override
  void initState() {
    super.initState();
    isPendente = widget.atendimento.pendente;
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
            expandedHeight: 50,
            flexibleSpace: BarraSuperior(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue, // Cor de fundo do contêiner
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'N° do protocolo de acontecimento: ${widget.atendimento.n_protocolo}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Cor do texto
                          ),
                        ),
                      ),
                      _buildDetailRow('Tipo de Atendimento', widget.atendimento.tipoAtendimento),
                      _buildDetailRow('Canal de Atendimento', widget.atendimento.canalAtendimento),
                      _buildDetailRow('Nome do Responsável', widget.atendimento.nomeResponsavel),
                      _buildDetailRow('Vistoria Realizada', widget.atendimento.vistoriaRealizada ? 'Sim' : 'Não'),
                      _buildDetailRow('Tipo de Vistoria', widget.atendimento.tipoVistoria),
                      _buildDetailRow('Data de Solicitação', widget.atendimento.dataSolicitacao),
                      _buildDetailRow('Data de Vistoria', widget.atendimento.dataVistoria),
                      _buildDetailRow('Itens de Ajuda Entregues', widget.atendimento.entregueItensAjuda ? 'Sim' : 'Não'),
                      Row(
                        children: [
                          Text('Pendente:'),
                          Switch(
                            value: isPendente,
                            onChanged: (value) {
                              setState(() {
                                isPendente = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          widget.atendimento.pendente = isPendente;
                          atendimentoController.editAtendimento(widget.atendimento, isPendente);
                          Navigator.pop(context);
                        },
                        child: Text('Salvar Alterações'),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200], // Cor de fundo
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
