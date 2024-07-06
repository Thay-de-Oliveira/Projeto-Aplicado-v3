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
  final RelatorioAtendimentoController _relatorioController = Get.find<RelatorioAtendimentoController>();
  AtendimentoController atendimentoController = Get.find<AtendimentoController>();
  AcontecimentoController acontecimentoController = Get.find<AcontecimentoController>();
  CidadaoController cidadaoController = Get.find<CidadaoController>();

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
          .getAcontecimentoByProtocolo(widget.atendimento.nProtocolo);
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
      final pdfUrl = await _relatorioController.gerarRelatorioUrl(widget.atendimento.nProtocolo);
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
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
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
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              _buildDocumentRow(context),
                              const SizedBox(height: 10),

                              _buildSection(
                                context,
                                'Dados da ocorrência',
                                [
                                  _buildInfoRow(
                                      'assets/imagens/icon-numero-protocolo.png',
                                      'N° do Protocolo:',
                                      widget.atendimento.nProtocolo,
                                      const Color(0xFFCFDDF2)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-subgrupo.png',
                                      'Subgrupo:',
                                      _acontecimento!.subgrupo,
                                      const Color(0xFFCFDDF2)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow('assets/imagens/icon-tipo.png',
                                      'Tipo:', _acontecimento!.tipo, const Color(0xFFCFDDF2)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-evento.png',
                                      'Evento:',
                                      '${_acontecimento!.tipo} ${_acontecimento!.subtipo}',
                                      const Color(0xFFCFDDF2)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-cobrade.png',
                                      'COBRADE:',
                                      _acontecimento!.infoCobrade!,
                                      const Color(0xFFCFDDF2)),
                                ],
                              ),

                              _buildSection(
                                context,
                                'Dados do atendimento',
                                [
                                  _buildInfoRow(
                                      'assets/imagens/icon-atendente-nome.png',
                                      'Nome do atendente:',
                                      widget.atendimento.atendenteResponsavel,
                                      const Color(0xFF8CD79C)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-data-vistoria.png',
                                      'Data da vistoria:',
                                      widget.atendimento.dataVistoria ?? 'Vistoria não realizada',
                                      const Color(0xFF8CD79C)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-ocorrencia.png',
                                      'Ocorrência:',
                                      widget.atendimento.nProtocolo,
                                      const Color(0xFF8CD79C)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-endereco.png',
                                      'Endereço:',
                                      '${widget.atendimento.bairro}, ${widget.atendimento.cidade} - ${widget.atendimento.estado}',
                                      const Color(0xFF8CD79C)),
                                ],
                              ),

                              _buildSection(
                                context,
                                'Dados do cidadão',
                                [
                                  _buildInfoRow(
                                      'assets/imagens/icon-nome-solicitante.png',
                                      'Nome do solicitante:',
                                      cidadao?.name ?? '',
                                      const Color(0xFFF08D86)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-cpf.png',
                                      'CPF do solicitante:',
                                      cidadao?.cpf ?? '',
                                      const Color(0xFFF08D86)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-rg.png',
                                      'RG do solicitante:',
                                      cidadao?.rg ?? '',
                                      const Color(0xFFF08D86)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-telefone.png',
                                      'Telefone do solicitante:',
                                      cidadao?.telefone ?? '',
                                      const Color(0xFFF08D86)),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(
                                      'assets/imagens/icon-pessoas-imovel.png',
                                      'Número de pessoas no imóvel:',
                                      cidadao?.numPessoasNaCasa.toString() ?? '',
                                      const Color(0xFFF08D86)),
                                ],
                              ),

                              _buildPhotoSection(widget.atendimento.imagesUrls)

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

  Widget _buildSection(BuildContext context, String sectionTitle, List<Widget> details) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...details,
        ],
      ),
    );
  }

  Widget _buildPhotoSection(List<String>? imagesUrls) {
    if (imagesUrls == null || imagesUrls.isEmpty) {
      return SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Registro fotográfico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: imagesUrls.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}