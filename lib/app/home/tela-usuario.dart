import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetoaplicado/backend/controllers/usuarioController.dart';
import 'package:projetoaplicado/backend/models/usuarioModel.dart';
import '../components/globais/barra-superior.dart';
import '../components/globais/menu-inferior.dart';
import '../login/tela-login.dart';

class Perfil extends StatefulWidget {
  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool notificationsEnabled = true;
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    userController.loadUserFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        UserModel? user = userController.currentUser;

        return Column(
          children: <Widget>[
            BarraSuperior(context),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFF1F1F1),
                    child: Icon(Icons.person, color: Color(0xFF696161), size: 60),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user?.username ?? 'Usuário',
                    style: const TextStyle(
                      color: Color(0xFF696161),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.person, color: Color(0xFF1A7CB2)),
                              SizedBox(width: 8),
                              Text(
                                'Dados pessoais',
                                style: TextStyle(
                                  color: Color(0xFF1A7CB2),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Número de telefone: ${user?.telefone ?? "Indisponível"}',
                            style: const TextStyle(
                              color: Color(0xFF696262),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Email: ${user?.email ?? "Indisponível"}',
                            style: const TextStyle(
                              color: Color(0xFF696262),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'CPF: ${user?.cpf ?? "Indisponível"}',
                            style: const TextStyle(
                              color: Color(0xFF696262),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Cargo: ${user?.cargo ?? "Indisponível"}',
                            style: const TextStyle(
                              color: Color(0xFF696262),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Cidade de atuação: ${user?.cidadeDeAtuacao ?? "Indisponível"}',
                            style: const TextStyle(
                              color: Color(0xFF696262),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Icon(Icons.settings, color: Color(0xFF1A7CB2)),
                              SizedBox(width: 8),
                              Text(
                                'Configuração',
                                style: TextStyle(
                                  color: Color(0xFF1A7CB2),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Notificações',
                                style: TextStyle(
                                  color: Color(0xFF696262),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Switch(
                                value: notificationsEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    notificationsEnabled = value;
                                  });
                                },
                                activeColor: const Color(0xFF1A7CB2), // Cor azul para a alavanca
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Idioma: Português',
                                style: TextStyle(
                                  color: Color(0xFF696262),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await userController.logoutUser();
                                Get.offAll(() => LoginApp());
                              },
                              icon: const Icon(Icons.logout, size: 16),
                              label: const Text('Logout'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFBBD8F0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
        );
      }),
      bottomNavigationBar: MenuInferior(),
    );
  }
}