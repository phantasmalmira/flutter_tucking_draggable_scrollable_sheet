import 'package:flutter/material.dart';
import 'package:flutter_tucking_draggable_scrollable_sheet/flutter_tucking_draggable_scrollable_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tucking Draggable Scrollable Sheet'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Headline',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Expanded(
                child: TuckingDraggableScrollableSheet(
                  snap: true,
                  tucking: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Tucking Subtitle',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  sheetBuilder: (context, scrollController) => Card(
                    elevation: 20,
                    child: ListView.builder(
                      controller: scrollController,
                      itemBuilder: (context, index) => ListTile(
                        title: Text('Item $index'),
                      ),
                      itemCount: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
