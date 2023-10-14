import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class SocButton extends StatefulWidget {
  const SocButton({
    required this.onPressed,
    required this.label,
    this.height,
    this.width,
    this.color,
    this.prefix,
    this.labelStyle,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String label;
  final Color? color;
  final double? height, width;
  final Widget? prefix;
  final TextStyle? labelStyle;

  @override
  State<SocButton> createState() => _SocButtonState();
}

class _SocButtonState extends State<SocButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    double blur = isPressed ? 5.0 : 8.0;
    final Offset offset = isPressed ? const Offset(1, 1) : const Offset(4, 4);

    return GestureDetector(
      onTapDown: (_) {
        widget.onPressed();
        setState(() {
          isPressed = true;
        });
      },
      onLongPressUp: () {
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      child: Center(
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: widget.height ?? 50,
            width: widget.width ?? 150,
            decoration: BoxDecoration(
                color: widget.color ?? Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: blur,
                    offset: offset,
                    inset: isPressed,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: blur,
                    offset: -offset,
                    inset: isPressed,
                  )
                ]),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.prefix != null
                      ? Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: widget.prefix,
                        )
                      : const SizedBox(),
                  Text(
                    widget.label,
                    style: widget.labelStyle ??
                        TextStyle(
                          fontSize: isPressed ? 15.5 : 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
