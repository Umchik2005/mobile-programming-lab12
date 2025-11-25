import 'package:flutter/material.dart';
import 'src/counter_screen.dart';
import 'src/login_screen.dart';
import 'src/auth_service.dart';

class MyApp extends StatelessWidget {
  final String? initialRoute;
  const MyApp({super.key, this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final authService = InMemoryAuthService();

    return MaterialApp(
      title: 'Testing & Debugging Lab',
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const CounterScreen(),
        '/login': (context) => LoginScreen(authService: authService),
      },
    );
  }
}

// Below are short examples used in the lab description.

// 6) Example of excessive rebuilds (bad)
class RebuildsBad extends StatefulWidget {
  const RebuildsBad({super.key});
  @override
  State<RebuildsBad> createState() => _RebuildsBadState();
}

class _RebuildsBadState extends State<RebuildsBad> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    // Doing heavy work in build — triggers on every rebuild
    final heavy = List.generate(1000, (i) => i).reduce((a, b) => a + b);
    return Column(
      children: [
        Text('Heavy: $heavy'),
        Text('Count: $counter'),
        ElevatedButton(
            onPressed: () => setState(() => counter++), child: const Text('Inc'))
      ],
    );
  }
}

// Refactored (good)
class RebuildsGood extends StatefulWidget {
  const RebuildsGood({super.key});
  @override
  State<RebuildsGood> createState() => _RebuildsGoodState();
}

class _RebuildsGoodState extends State<RebuildsGood> {
  int counter = 0;
  late final int heavy;
  @override
  void initState() {
    super.initState();
    heavy = List.generate(1000, (i) => i).reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Heavy: $heavy'),
        Text('Count: $counter'),
        ElevatedButton(
            onPressed: () => setState(() => counter++), child: const Text('Inc'))
      ],
    );
  }
}

// 9) Jank example
class JankButton extends StatelessWidget {
  const JankButton({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Simulate heavy synchronous computation (jank)
        var sum = 0;
        for (var i = 0; i < 200000000; i++) {
          sum += i & 0xFF;
        }
        // Normally avoid heavy work on UI thread — move to isolate or compute asynchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Done $sum')));
      },
      child: const Text('Cause Jank'),
    );
  }
}

// 10) Responsive layout sample
class ResponsiveSample extends StatelessWidget {
  const ResponsiveSample({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 400) {
        return const Center(child: Text('Small screen'));
      }
      if (constraints.maxWidth < 800) {
        return Row(children: const [Expanded(child: Text('Medium screen'))]);
      }
      return const Center(child: Text('Large screen'));
    });
  }
}
