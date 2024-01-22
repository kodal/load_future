import 'package:flutter/widgets.dart';
import 'package:load_future/src/simple_overlay.dart';

class DialogBarrier extends StatelessWidget {
  const DialogBarrier({
    Key? key,
    required this.child,
    required this.isLoading,
    required this.indicator,
    this.barrierColor = const Color(0x80000000),
  }) : super(key: key);

  final Widget child;
  final Widget indicator;
  final bool isLoading;
  final Color barrierColor;

  @override
  Widget build(BuildContext context) => SimpleOverlay(
        overlay: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: ModalBarrier(
                color: barrierColor,
                dismissible: false,
              ),
            ),
            indicator,
          ],
        ),
        showOverlay: isLoading,
        child: child,
      );
}
