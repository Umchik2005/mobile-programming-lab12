import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _count = 0;

  void _increment() => setState(() => _count++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(child: Text('$_count', key: const Key('counterText'), style: const TextStyle(fontSize: 48))),
      floatingActionButton: FloatingActionButton(
        key: const Key('incrementFab'),
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
