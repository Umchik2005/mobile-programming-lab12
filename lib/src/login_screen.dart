import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;
  const LoginScreen({super.key, required this.authService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _submitting = false;

  bool get _isValid => _formKey.currentState?.validate() ?? false;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);
    final ok = await widget.authService.signIn(_emailCtrl.text, _passCtrl.text);
    setState(() => _submitting = false);
    if (ok) {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign-in failed')));
    }
  }

  String? _emailValidator(String? v) {
    if (v == null || v.isEmpty) return 'Email required';
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!emailRegex.hasMatch(v)) return 'Invalid email';
    return null;
  }

  String? _passValidator(String? v) => (v == null || v.isEmpty) ? 'Password required' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: () => setState(() {}),
          child: Column(
            children: [
              TextFormField(
                key: const Key('emailField'),
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: _emailValidator,
              ),
              TextFormField(
                key: const Key('passwordField'),
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: _passValidator,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const Key('submitButton'),
                onPressed: _isValid && !_submitting ? _submit : null,
                child: _submitting ? const CircularProgressIndicator() : const Text('Sign in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
