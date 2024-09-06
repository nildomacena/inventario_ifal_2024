import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario_ifal/data/repositories/auth_repository.dart';
import 'package:inventario_ifal/modules/login/signup_page.dart';
import 'package:inventario_ifal/routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController siapeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();

  bool lembrarCredenciais = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  LoginController({required this.authRepository});

  toggleLembrarCredenciais(bool? value) {
    lembrarCredenciais = value ?? !lembrarCredenciais;
    update();
  }

  onSignUpClick() {
    Get.to(() => SignupPage());
  }

  toggleShowPassword() {
    showPassword = !showPassword;
    update();
  }

  toggleShowConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  login() async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      try {
        await authRepository.login(
          email: email,
          password: password,
        );
        Get.offAllNamed(Routes.home);
      } catch (e) {
        Get.snackbar('Erro', e.toString());
      } finally {
        update();
      }
    }
  }

  signUp() async {
    if (formSignUpKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      final name = nomeController.text;
      final siape = siapeController.text;
      final cpf = cpfController.text;
      try {
        await authRepository.signUp(
          email: email,
          password: password,
          name: name,
          cpf: cpf,
          siape: siape,
        );
        Get.offAllNamed(Routes.home);
      } catch (e) {
        Get.snackbar('Erro', e.toString());
      } finally {
        update();
      }
    }
  }

  @override
  void onInit() {
    if (kDebugMode) {
      emailController.text = 'ednildo.filho@ifal.edu.br';
      nomeController.text = 'Ednildo Macena';
      siapeController.text = '1234567';
      cpfController.text = '12345678901';
      passwordController.text = 'q1w2e3';
      confirmPasswordController.text = 'q1w2e3';
    }
    super.onInit();
  }
}
