library flutter_tucking_draggable_scrollable_sheet;

import 'package:flutter/cupertino.dart';

const _kLayoutIdTucking = 'tucking';
const _kLayoutIdSheet = 'sheet';

class TuckingDraggableScrollableSheet extends StatelessWidget {
  final Widget? tucking;
  final Widget Function(BuildContext context, ScrollController controller)
      sheetBuilder;
  final bool snap;
  final DraggableScrollableController? controller;

  /// The extent of how far the sheet is tucked into [tucking] initially.
  /// Defaults to 0.0. Must be between 0.0 and 1.0.
  /// 0.0 means the tucking is fully visible.
  /// 1.0 means the tucking is fully behind the sheet.
  final double initialTuckedExtent;

  const TuckingDraggableScrollableSheet({
    super.key,
    this.tucking,
    required this.sheetBuilder,
    this.snap = true,
    this.controller,
    this.initialTuckedExtent = 0.0,
  }) : assert(initialTuckedExtent >= 0.0 && initialTuckedExtent <= 1.0);

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _TuckingDraggableScrollableSheetDelegate(),
      children: [
        if (tucking != null) LayoutId(id: _kLayoutIdTucking, child: tucking!),
        LayoutId(
          id: _kLayoutIdSheet,
          child: LayoutBuilder(
            builder: (context, constraints) {
              /// Min child size is when tucking is visible
              final minChildSize =
                  constraints.minHeight / constraints.maxHeight;
              final initialChildSize = initialTuckedExtent == 0.0
                  ? minChildSize

                  /// Sets it to exact minChildSize to avoid rounding errors
                  : initialTuckedExtent == 1.0
                      ? 1.0

                      /// Sets it to exact 1.0 to avoid rounding errors
                      : (1 - minChildSize) * initialTuckedExtent + minChildSize;

              /// Calculates the initialChildSize based on initialTuckedExtent
              return DraggableScrollableSheet(
                snap: snap,
                expand: true,
                controller: controller,
                minChildSize: minChildSize,
                maxChildSize: 1,
                initialChildSize: initialChildSize,
                builder: sheetBuilder,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TuckingDraggableScrollableSheetDelegate
    extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    var tuckingSize = Size.zero;
    if (hasChild(_kLayoutIdTucking)) {
      // Layout the tucking widget at the top of the screen.
      tuckingSize = layoutChild(_kLayoutIdTucking, BoxConstraints.loose(size));
      positionChild(_kLayoutIdTucking, Offset.zero);
    }
    layoutChild(
      _kLayoutIdSheet,

      /// The box constraints will be passed to a [LayoutBuilder].
      /// [LayoutBuilder] sets the correct [initialChildSize], [minChildSize] and [maxChildSize] for the [DraggableScrollableSheet].
      BoxConstraints(
        minWidth: size.width,
        maxWidth: size.width,
        minHeight: size.height - tuckingSize.height,
        maxHeight: size.height,
      ),
    );
    positionChild(_kLayoutIdSheet, Offset.zero);
    // Stack the sheet on top of the tucking widget.
  }

  @override
  bool shouldRelayout(_TuckingDraggableScrollableSheetDelegate oldDelegate) {
    return false;
  }
}
