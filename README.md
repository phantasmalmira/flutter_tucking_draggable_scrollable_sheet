# flutter_tucking_draggable_scrollable_sheet

[![pub package](https://pub.dartlang.org/packages/flutter_tucking_draggable_scrollable_sheet.svg)](https://pub.dartlang.org/packages/flutter_tucking_draggable_scrollable_sheet)
[![GitHub Stars](https://img.shields.io/github/stars/phantasmalmira/flutter_tucking_draggable_scrollable_sheet.svg?logo=github)](https://github.com/phantasmalmira/flutter_tucking_draggable_scrollable_sheet)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-green.svg)

Basically a [DraggableScrollableSheet](https://api.flutter.dev/flutter/widgets/DraggableScrollableSheet-class.html), but enhanced by constraining the `minChildSize` and `maxChildSize` accordingly to the `tucking` widget.

<p>
  <img width="205px" alt="Example" src="https://raw.githubusercontent.com/phantasmalmira/flutter_tucking_draggable_scrollable_sheet/main/screenshots/example.gif"/>
</p>

## Installation

Add the following to your `pubspec.yaml` file

```yaml
dependencies:
    flutter_tucking_draggable_scrollable_sheet: ^1.0.0
```

## Usage

```dart
TuckingDraggableScrollableSheet(
    /// Control snapping of [DraggableScrollableSheet]
    snap: true,
    /// Extent of how much [tucking] widget is tucked behind the sheet initially
    initialTuckedExtent: 0.0
    /// The [Widget] that will be covered when sheet is fully expanded
    tucking: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Tucking Subtitle'),
    ),
    /// Builder is forwarded to [DraggableScrollableSheet]
    sheetBuilder: (context, scrollController) => Card(
        child: ListView.builder(
            /// Ensure [scrollController] is passed to nesting scroll views
            controller: scrollController,
            itemBuilder: (context, index) => ListTile(
                title: Text('Item $index'),
            ),
            itemCount: 100,
        ),
    ),
)
```
