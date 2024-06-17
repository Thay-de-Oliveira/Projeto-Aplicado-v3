import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:projetoaplicado/app/home/relatorios/acontecimento/tela-relat-aconte-detalhes.dart';
import 'package:projetoaplicado/app/home/relatorios/atendimento/tela-relatorio-atend-detalhes.dart' as atendimento;
import 'package:projetoaplicado/backend/controllers/relatorioAtendimentoController.dart';
import 'package:projetoaplicado/backend/models/cidadaoModel.dart';
import '../../../components/globais/barra-superior.dart' as globais;
import '../../../components/globais/menu-inferior.dart';
import 'package:projetoaplicado/backend/models/atendimentoModel.dart';
import 'package:projetoaplicado/backend/controllers/atendimentoController.dart';
import 'package:projetoaplicado/backend/models/acontecimentoModel.dart';
import 'package:projetoaplicado/backend/controllers/acontecimentoController.dart';
import 'package:projetoaplicado/backend/controllers/cidadaoController.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DetalheHistorico extends StatefulWidget {
  final AtendimentosModel atendimento;

  const DetalheHistorico({Key? key, required this.atendimento})
      : super(key: key);

  @override
  _DetalheHistorico createState() => _DetalheHistorico();
}

class _DetalheHistorico extends State<DetalheHistorico> {
  final RelatorioAtendimentoController _relatorioController = RelatorioAtendimentoController();
  AtendimentoController atendimentoController = Get.put(AtendimentoController());
  AcontecimentoController acontecimentoController = Get.put(AcontecimentoController());
  CidadaoController cidadaoController = Get.put(CidadaoController());

  bool isPendente = false;
  bool isLoading = true;
  AcontecimentoModel? _acontecimento;
  CidadaoModel? cidadao;

  @override
  void initState() {
    super.initState();
    isPendente = widget.atendimento.pendente;
    _loadData();
  }

  Future<void> _loadData() async {
    await _fetchCidadao(widget.atendimento.cidadaoResponsavel);
    await _loadAcontecimento();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadAcontecimento() async {
    try {
      AcontecimentoModel acontecimento = await acontecimentoController
          .getAcontecimentoByProtocolo(widget.atendimento.n_protocolo);
      setState(() {
        _acontecimento = acontecimento;
      });
    } catch (e) {
      print("Erro ao carregar o acontecimento: $e");
      setState(() {
        _acontecimento = null;
      });
    }
  }

  Future<void> _fetchCidadao(String cpf) async {
    try {
      await cidadaoController.getCidadaoByCpf(cpf);
      setState(() {
        cidadao = cidadaoController.listCidadaoObs.first;
      });
    } catch (e) {
      print("Erro ao carregar o cidadão: $e");
      setState(() {
        cidadao = null;
      });
    }
  }

  Future<void> _visualizarRelatorio(BuildContext context, String tipo) async {
    setState(() {
      isLoading = true;
    });

    try {
      final pdfUrl = await _relatorioController.gerarRelatorioUrl(widget.atendimento.n_protocolo);
      final downloadUrl = _transformUrlToDownloadUrl(pdfUrl);

      if (tipo == 'atendimento') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => atendimento.DetalhesRelatorioAtendimento(pdfUrl: downloadUrl),
          ),
        );
      } else if (tipo == 'acontecimento') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesRelatorioAcontecimento(acontecimento: _acontecimento!),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar relatório: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _transformUrlToDownloadUrl(String viewUrl) {
    final fileId = viewUrl.split('/d/')[1].split('/')[0];
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                Column(
                  children: [
                    globais.BarraSuperior(context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Seção de Documentos
                              const Text(
                                'Documentos',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildDocumentRow(context),
                              const SizedBox(height: 20),

                              // Seção de Dados da Ocorrência
                              const Text(
                                'Dados da ocorrência',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x3F2F2F2F),
                                      blurRadius: 1,
                                      offset: Offset(1, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_acontecimento != null) ...[
                                      _buildInfoRow(
                                          'assets/imagens/icon-numero-protocolo.png',
                                          'N° do Protocolo:',
                                          widget.atendimento.n_protocolo,
                                          Colors.blue),
                                      const SizedBox(height: 8),
                                      _buildInfoRow(
                                          'assets/imagens/icon-subgrupo.png',
                                          'Subgrupo:',
                                          _acontecimento!.subgrupo,
                                          Colors.blue),
                                      const SizedBox(height: 8),
                                      _buildInfoRow('assets/imagens/icon-tipo.png',
                                          'Tipo:', _acontecimento!.tipo, Colors.blue),
                                      const SizedBox(height: 8),
                                      _buildInfoRow(
                                          'assets/imagens/icon-evento.png',
                                          'Evento:',
                                          '${_acontecimento!.tipo} ${_acontecimento!.subtipo}',
                                          Colors.blue),
                                      const SizedBox(height: 8),
                                      _buildInfoRow(
                                          'assets/imagens/icon-cobrade.png',
                                          'COBRADE:',
                                          _acontecimento!.infoCobrade,
                                          Colors.blue),
                                    ] else ...[
                                      const Text(
                                        'Não foi possível carregar os dados da ocorrência.',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Seção de Atendimento
                              const Text(
                                'Atendimento',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x3F2F2F2F),
                                      blurRadius: 1,
                                      offset: Offset(1, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(
                                        'assets/imagens/icon-atendente-nome.png',
                                        'Nome do atendente:',
                                        widget.atendimento.atendenteResponsavel,
                                        Colors.green),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                        'assets/imagens/icon-data-vistoria.png',
                                        'Data da vistoria:',
                                        widget.atendimento.dataVistoria,
                                        Colors.green),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                        'assets/imagens/icon-ocorrencia.png',
                                        'Ocorrência:',
                                        widget.atendimento.n_protocolo,
                                        Colors.green),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                        'assets/imagens/icon-endereco.png',
                                        'Endereço:',
                                        '${cidadao?.bairro}, ${cidadao?.cidade} - ${cidadao?.estado}',
                                        Colors.green),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Seção de Família/Cidadãos
                              const Text(
                                'Família/Cidadãos',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x3F2F2F2F),
                                      blurRadius: 1,
                                      offset: Offset(1, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(
                                        'assets/imagens/icon-nome-solicitante.png',
                                        'Nome do solicitante:',
                                        cidadao?.name ?? '',
                                        Colors.red),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                        'assets/imagens/icon-cpf.png',
                                        'CPF do solicitante:',
                                        cidadao?.cpf ?? '',
                                        Colors.red),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                        'assets/imagens/icon-rg.png',
                                        'RG do solicitante:',
                                        cidadao?.rg ?? '',
                                        Colors.red),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                        'assets/imagens/icon-telefone.png',
                                        'Telefone do solicitante:',
                                        cidadao?.telefone ?? '',
                                        Colors.red),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                        'assets/imagens/icon-pessoas-imovel.png',
                                        'Número de pessoas no imóvel:',
                                        cidadao?.numPessoasNaCasa.toString() ?? '',
                                        Colors.red),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Seção de Registro fotográfico
                              if (widget.atendimento.imagesUrls != null &&
                                  widget.atendimento.imagesUrls!.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Registro fotográfico',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        height: 182,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        aspectRatio: 16 / 9,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enableInfiniteScroll: true,
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        viewportFraction: 0.8,
                                      ),
                                      items:
                                          widget.atendimento.imagesUrls!.map((item) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Image.network(
                                                item,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 20), // Adicionado aqui
                                  ],
                                ),

                              // Botão com localização
                              if (cidadao != null)
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          String endereco = '${cidadao!.rua}, ${cidadao!.bairro}, ${cidadao!.cidade} - ${cidadao!.estado}, ${cidadao!.cep}';
                                          MapsLauncher.launchQuery(endereco);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.location_on, color: Color(0xFF2987C0)),
                                              SizedBox(width: 10),
                                              Text(
                                                'Localização do acontecimento',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      elevation: 4,
                                      margin: const EdgeInsets.all(10),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      bottomNavigationBar: MenuInferior(),
    );
  }

  Widget _buildInfoRow(
      String iconPath, String title, String value, Color backgroundColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(iconPath, width: 20, height: 20),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$title ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(String title, String date, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 75,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3F2F2F2F),
                blurRadius: 1,
                offset: Offset(1, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'Emitido em $date',
                style: const TextStyle(
                  color: Color(0xFF6C6C6C),
                  fontSize: 8,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 16,
                decoration: ShapeDecoration(
                  color: const Color(0xFF7CA0FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Visualizar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentRow(BuildContext context) {
    List<Map<String, dynamic>> documents = [
      {
        'title': 'Ocorrência',
        'date': _acontecimento != null ? DateFormat('dd/MM/yyyy').format(_acontecimento!.dataHora) : 'Data não disponível',
        'onTap': () => _visualizarRelatorio(context, 'acontecimento'),
      },
      {
        'title': 'Relatório',
        'date': widget.atendimento.dataVistoria,
        'onTap': () => _visualizarRelatorio(context, 'atendimento'),
      },
      {
        'title': 'Recibo',
        'date': '01/01/2024',
        'onTap': () {
        },
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: documents.map((doc) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: _buildDocumentCard(
              doc['title']!,
              doc['date']!,
              doc['onTap'],
            ),
          ),
        );
      }).toList(),
    );
  }
}