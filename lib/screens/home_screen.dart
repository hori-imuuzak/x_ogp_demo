import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ogp_provider.dart';
import '../widgets/ogp_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ogpState = ref.watch(ogpProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('OGP Fetcher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter URL (e.g. https://x.com/...)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      ref.read(ogpProvider.notifier).fetchOgp(_controller.text);
                    }
                  },
                  child: const Text('Fetch'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ogpState.when(
                data: (data) {
                  if (data == null) {
                    return const Center(
                        child: Text('Enter a URL to fetch OGP'));
                  }
                  return SingleChildScrollView(
                    child: OgpCard(ogpData: data),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
