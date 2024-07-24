import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/modules/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.find();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<LoginController>(builder: (_) {
            return Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/imgs/logo.png',
                          height: 100,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Inventário IFAL - Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Usuário',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (!value.isEmail) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: controller.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: const Icon(Icons.visibility),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (value.length < 6) {
                              return 'Senha deve ter no mínimo 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GetBuilder<LoginController>(
                                  builder: (_) {
                                    return Checkbox(
                                      value: controller.lembrarCredenciais,
                                      onChanged:
                                          controller.toggleLembrarCredenciais,
                                    );
                                  },
                                ),
                                const Text('Lembrar de mim?'),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                // Ação para esquecimento de senha
                              },
                              child: const Text('Esqueceu sua senha?'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.login,
                            child: const Text('Entrar'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Não tem uma conta?'),
                            TextButton(
                              onPressed: controller.onSignUpClick,
                              child: const Text('Cadastre-se'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
