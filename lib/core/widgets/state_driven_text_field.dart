import 'package:flutter/material.dart';

class StateDrivenTextField extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? enabled;

  const StateDrivenTextField({
    super.key,
    required this.value,
    required this.onChanged,
    this.decoration,
    this.style,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.enabled,
  });

  @override
  State<StateDrivenTextField> createState() => _StateDrivenTextFieldState();
}

class _StateDrivenTextFieldState extends State<StateDrivenTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(StateDrivenTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
      _controller.selection = TextSelection.collapsed(offset: widget.value.length);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: widget.decoration,
      style: widget.style,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
    );
  }
}
