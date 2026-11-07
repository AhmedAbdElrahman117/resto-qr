import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  final String cursorSymbol;
  final bool autoStart;
  final VoidCallback? onComplete;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 2000),
    this.cursorSymbol = '|',
    this.autoStart = true,
    this.onComplete,
  });

  @override
  State<TypewriterText> createState() => TypewriterTextState();
}

class TypewriterTextState extends State<TypewriterText>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _cursorController;
  late Animation<int> _characterCount;

  late bool _showCursor; // Changed to late to set in initState

  @override
  void initState() {
    super.initState();

    // 1. Initialize visibility based on autoStart
    _showCursor = widget.autoStart;

    _textController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _characterCount =
        StepTween(
          begin: 0,
          end: widget.text.length,
        ).animate(
          CurvedAnimation(
            parent: _textController,
            curve: Curves.linear,
          ),
        );

    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // 2. Only start blinking if we are auto-starting
    if (widget.autoStart) {
      _cursorController.repeat(reverse: true);
      start();
    }
  }

  void start() {
    if (_textController.isAnimating || _textController.isCompleted) return;

    // 3. Make cursor visible and start blinking when manually started
    setState(() {
      _showCursor = true;
    });
    _cursorController.repeat(reverse: true);

    _textController.forward().whenComplete(() {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) {
          setState(() {
            _showCursor = false; // Hide cursor at the end
          });
          _cursorController.stop();
          widget.onComplete?.call();
        }
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_textController, _cursorController]),
      builder: (context, child) {
        String textToDisplay = widget.text.substring(0, _characterCount.value);

        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: textToDisplay,
                style: widget.style,
              ),
              // Cursor Logic:
              // We keep the TextSpan but use opacity 0.0 when hidden.
              // This ensures the height of the widget remains consistent
              // even when the text is empty and cursor is hidden.
              TextSpan(
                text: widget.cursorSymbol,
                style: widget.style.copyWith(
                  color: widget.style.color?.withValues(
                    alpha: _showCursor ? _cursorController.value : 0.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
