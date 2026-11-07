import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Widgets/loading_widget.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.show = true});

  final bool show;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      maintainAnimation: false,
      maintainFocusability: false,
      maintainInteractivity: false,
      maintainSize: false,
      maintainState: false,
      maintainSemantics: false,
      child: Container(
        width: .infinity,
        height: .infinity,
        color: Colors.black.withValues(alpha: 0.75),
        child: Center(
          child: LoadingWidget(),
        ),
      ),
    );
  }
}
