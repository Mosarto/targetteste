import 'package:flutter/material.dart';
import 'package:target/data/providers/item_provider.dart';
import 'package:target/screens/home_screen.dart';
import 'package:target/utils/validators.dart';
import 'package:target/widgets/custom_text_field_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode? _userFocusNode;
  TextEditingController? _userController;

  FocusNode? _passwordFocusNode;
  TextEditingController? _passwordController;

  @override
  void initState() {
    _userFocusNode = FocusNode();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _userFocusNode?.dispose();
    _userController?.dispose();
    _passwordController?.dispose();
    _passwordFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.all(42),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
            colors: [
              Color(0xff1e5365),
              Color(0xff6fb0ae),
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                CustomTextFieldWidget(
                  focusNode: _userFocusNode,
                  controller: _userController,
                  validator: senhaValidator,
                  label: 'Usuário',
                  icon: const Icon(
                    Icons.person_rounded,
                    color: Color(0xff1f2737),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFieldWidget(
                  obscureText: true,
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  validator: senhaValidator,
                  label: 'Senha',
                  icon: const Icon(
                    Icons.lock_rounded,
                    color: Color(0xff1f2737),
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(136, 48),
                    backgroundColor: const Color(0xff44bd6e),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await getItems().then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              items: value,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                TextButton(
                  onPressed: () async {
                    if (!await launchUrl(
                      Uri.parse('https://www.google.com.br'),
                    )) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Não foi possível abrir o link'),
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Política de privacidade',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
