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

  const TuckingDraggableScrollableSheet({
    super.key,
    this.tucking,
    required this.sheetBuilder,
    this.snap = true,
    this.controller,
  });

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
              return DraggableScrollableSheet(
                snap: snap,
                expand: true,
                controller: controller,
                minChildSize: minChildSize,
                maxChildSize: 1,
                initialChildSize: minChildSize,
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
