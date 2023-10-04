import 'package:flutter/material.dart';

import 'components/barra-superior.dart';
import 'components/menu-inferior.dart';

import 'tela-atend-pendente.dart';
import 'tela-atend-historico.dart';
import 'tela-atendimento-forms.dart';

class AtendimentoPendente extends StatefulWidget {
  @override
  _AtendimentoPendenteState createState() => _AtendimentoPendenteState();
}

class _AtendimentoPendenteState extends State<AtendimentoPendente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: CustomScrollView(
        //Permite rolagem da página
        slivers: <Widget>[
          SliverAppBar(
            floating: true, // A barra irá flutuar no topo
            pinned: true, // A barra será fixa no topo
            snap: false, // Não encolherá a barra ao rolar para baixo
            expandedHeight: 50, // Aumente este valor para adicionar mais espaço
            //backgroundColor: Color(0xfff8f7f7),
            flexibleSpace: BarraSuperior(context), //Barra
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Botão CADASTRO
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 2,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AtendimentoForms()));
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-cadastro-inativo.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Cadastro',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Botão PENDENTE
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xFFBBD8F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 2,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AtendimentoPendente()));
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-pendente-ativo.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Pendente',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Botão HISTÓRICO
                    GestureDetector(
                      child: Ink(
                        decoration: ShapeDecoration(
                          //Estilo
                          color: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            //Sombras
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 2,
                              offset: Offset(2, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HistoricoAtendimento()));
                          },
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //Icone
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                      'assets/imagens/icon-historico.png'),
                                ),
                                SizedBox(
                                    height:
                                        5.0), //Espaço entre o ícone e o texto
                                Text(
                                  'Histórico',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),

                //Barra de pesquisa + filtro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Botão FILTRO
                    InkWell(
                      onTap: () {
                        // Ação a ser executada quando o botão de filtro for pressionado
                      },
                      child: Container(
                        width: 65,
                        height: 32,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 65,
                                height: 32,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFCFDDF2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x269FE3FF),
                                      blurRadius: 8,
                                      offset: Offset(1, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 6.09,
                              top: 7,
                              child: Container(
                                width: 53.91,
                                height: 18,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.filter_list,
                                      color: Color(0xff121212),
                                      size: 16,
                                    ),
                                    SizedBox(
                                        width:
                                            4), // Espaço entre o ícone e o texto
                                    Text(
                                      'Filtrar',
                                      style: TextStyle(
                                        color: Color(0xFF2F2F2F),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Espaçamento entre a barra de pesquisa e o botão de filtro
                    SizedBox(width: 10),

                    //Barra de pesquisa
                    Container(
                      width: 253,
                      height: 32,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 253,
                              height: 32,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x199FE3FF),
                                    blurRadius: 8,
                                    offset: Offset(1, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 227,
                            top: 8,
                            child: Container(
                              width: 15.37,
                              height: 16,
                              child: Stack(children: []),
                            ),
                          ),
                          Positioned(
                            left: 14,
                            top: 0,
                            child: Container(
                              height: 32,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            140.0), //Espaçamento à direita do texto
                                    child: Text(
                                      'Pesquisar',
                                      style: TextStyle(
                                        color: Color(0xFF979797),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Color(0xFF979797),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: 25),

                //Card 1
                Center(
                  child: Container(
                    width: 330,
                    height: 116,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            //Card
                            width: 330,
                            height: 113,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F2F2F2F),
                                  blurRadius: 1,
                                  offset: Offset(1, 1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        //1
                        Positioned(
                          //2 - Titulo do card
                          left: 9,
                          top: 7,
                          child: SizedBox(
                            width: 189,
                            height: 21,
                            child: Text(
                              'Seca - Estiagem',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 9,
                          top: 94,
                          child: Container(
                            width: 138,
                            height: 9,
                            child: Stack(
                              children: [
                                Positioned(
                                  //Tempo do card em "Pendente"
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 23,
                                    height: 9,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          //Icone
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 9,
                                            height: 9,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/icon-card-tempo.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          //Texto
                                          left: 9,
                                          top: 4,
                                          child: SizedBox(
                                            width: 14,
                                            height: 8,
                                            child: Text(
                                              '10d',
                                              style: TextStyle(
                                                color: Color(0xFF082778),
                                                fontSize: 8,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //
                                Positioned(
                                  //Comentários do card
                                  left: 32,
                                  top: 4,
                                  child: Container(
                                    width: 20,
                                    height: 9,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          //Icone
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 9,
                                            height: 9,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/icon-card-comentario.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          //Texto
                                          left: 10,
                                          top: 0,
                                          child: SizedBox(
                                            width: 10,
                                            height: 8,
                                            child: Text(
                                              '02',
                                              style: TextStyle(
                                                color: Color(0xFF082778),
                                                fontSize: 8,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //
                                Positioned(
                                  //Vencimento do card
                                  left: 61,
                                  top: 4,
                                  child: Container(
                                    width: 77,
                                    height: 8,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/icon-card-vencimento.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          //Texto
                                          left: 10,
                                          top: 0,
                                          child: SizedBox(
                                            width: 67,
                                            height: 8,
                                            child: Text(
                                              'Venc.: 08/06/2023',
                                              style: TextStyle(
                                                color: Color(0xFF082778),
                                                fontSize: 8,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          left: 208,
                          top: 89,
                          child: Container(
                            width: 116,
                            height: 17,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 116,
                                    height: 17,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFCFDDF2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AtendimentoForms(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 110,
                                    height: 17,
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .transparent, // Cor de fundo transparente
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Realizar atendimento',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                          height: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //
                        Positioned(
                          //Data acontecimento
                          left: 9,
                          top: 31,
                          child: Container(
                            width: 251,
                            height: 53,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 20,
                                  top: 20,
                                  child: SizedBox(
                                    width: 199,
                                    height: 14,
                                    child: Text(
                                      'Data do acontecimento: 08/05/2023',
                                      style: TextStyle(
                                        color: Colors.black
                                            .withOpacity(0.8500000238418579),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                //
                                Positioned(
                                  //Endereço
                                  left: 20,
                                  top: 39,
                                  child: SizedBox(
                                    width: 214,
                                    height: 14,
                                    child: Text(
                                      'Bairro: São Pedro | Cidade: Chapecó/SC',
                                      style: TextStyle(
                                        color: Colors.black
                                            .withOpacity(0.8500000238418579),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 20,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFFCFDDF2),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 3,
                                          top: 3,
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Stack(children: []),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //
                                Positioned(
                                  //N° do protocolo de acontecimento
                                  left: 20,
                                  top: 0,
                                  child: SizedBox(
                                    width: 231,
                                    height: 14,
                                    child: Text(
                                      'N° do protocolo de acontecimento: 0003',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  //Circulo para
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFCFDDF2),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 39,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFFCFDDF2),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 3,
                                          top: 3,
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 4,
                                          top: 3,
                                          child: Container(
                                            width: 6,
                                            height: 8.73,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/icon-calendario.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 34,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/8x8"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }
}
