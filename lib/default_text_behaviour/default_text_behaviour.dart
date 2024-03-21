import 'package:flutter/material.dart';

class DefaultTextBehaviourScreen extends StatefulWidget {
  const DefaultTextBehaviourScreen({super.key});

  @override
  State<DefaultTextBehaviourScreen> createState() =>
      _DefaultTextBehaviourScreenState();
}

class _DefaultTextBehaviourScreenState
    extends State<DefaultTextBehaviourScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Text Behaviour'),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'body large',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'body medium',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'body small',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              Text(
                'display large',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'display medium',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'display small',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 20),
              Text(
                'headline large',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'headline medium',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'headline small',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              Text(
                'label large',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'label medium',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'label small',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 20),
              Text(
                'title large',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'title medium',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'title small',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 20),

              /// with a given fixed font size.....
              ///
              const Text(
                'Font size 20',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text(
                'Font size 30',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              const Text(
                'Font size 40',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                'Font size 50',
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
