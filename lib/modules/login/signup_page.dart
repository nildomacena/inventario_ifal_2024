import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/modules/login/login_controller.dart';

class SignupPage extends StatelessWidget {
  final LoginController controller = Get.find();
  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Form: formSignUpKey
    // Campos do formulário: nome, email, matricula siape, senha, confirmar senha
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<LoginController>(builder: (_) {
            return Form(
              key: controller.formSignUpKey,
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
                          'Inventário IFAL - Cadastro',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: controller.nomeController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: const Icon(Icons.email),
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
                          controller: controller.siapeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Matrícula SIAPE',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
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
                        TextFormField(
                          controller: controller.confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirmar Senha',
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
                            if (value != controller.passwordController.text) {
                              return 'Senhas não conferem';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: Get.width,
                          child: ElevatedButton(
                            onPressed: controller.signUp,
                            child: const Text('Cadastrar'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Já tenho uma conta'),
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
