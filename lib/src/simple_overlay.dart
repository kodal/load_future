import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SimpleOverlay extends MultiChildRenderObjectWidget {
  SimpleOverlay({
    Key? key,
    required Widget child,
    required Widget overlay,
    required bool showOverlay,
  }) : super(key: key, children: [child, if (showOverlay) overlay]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSimpleOverlay();
  }
}

class _SimpleOverlayChild extends ContainerBoxParentData<RenderBox>
    with ContainerParentDataMixin<RenderBox> {}

class RenderSimpleOverlay extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _SimpleOverlayChild>,
        RenderBoxContainerDefaultsMixin<RenderBox, _SimpleOverlayChild> {
  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = _SimpleOverlayChild();
  }

  @override
  void performLayout() {
    var childConstraints = constraints;

    final child = firstChild;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      childConstraints = BoxConstraints.tight(child.size);
    }

    final overlay = (child == null) ? null : childAfter(child);
    if (overlay != null) {
      overlay.layout(childConstraints, parentUsesSize: true);
    }

    size = child?.size ?? overlay?.size ?? constraints.smallest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
