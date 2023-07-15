import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SlidingToggleSwitch extends StatefulWidget {
  final Function onChange;
  final double width;
  final double height;
  final Color trackOnColor;
  final Color trackOffColor;
  final Color trackDisabledColor;
  final Color borderColor;
  final double borderWidth;
  final bool initialValue;
  final Color thumbOnColor;
  final Color thumbOffColor;
  final Color thumbDisabledColor;
  final double thumbScale;
  final bool disabled;

  const SlidingToggleSwitch(
      {super.key,
      required this.onChange,
      this.height = 30,
      this.width = 50,
      this.trackOffColor = const Color.fromARGB(40, 0, 0, 0),
      this.trackOnColor = const Color.fromARGB(255, 119, 228, 255),
      this.trackDisabledColor = const Color.fromARGB(255, 214, 214, 214),
      this.borderColor = Colors.transparent,
      this.thumbOnColor = const Color.fromARGB(255, 97, 192, 80),
      this.thumbOffColor = const Color.fromARGB(255, 97, 192, 80),
      this.thumbDisabledColor = const Color.fromARGB(255, 237, 237, 237),
      this.borderWidth = 2,
      this.thumbScale = 1,
      this.initialValue = false,
      this.disabled = false});

  @override
  State<SlidingToggleSwitch> createState() => _SlidingToggleSwitchState();
}

class _SlidingToggleSwitchState extends State<SlidingToggleSwitch> with SingleTickerProviderStateMixin {
  late bool value;
  double thumbLoc = 0;
  late double thumbLocMax;
  late double thumbMid;
  late final Ticker _ticker;
  bool snap = false;

  @override
  void initState() {
    if (widget.width < widget.height) throw Exception("Sliding Toggle switch width cannot be smaller than height.");

    super.initState();
    value = widget.initialValue;
    thumbLocMax = widget.width - widget.height;
    thumbMid = thumbLocMax / 2;

    if (value) {
      thumbLoc = thumbLocMax;
    } else {
      thumbLoc = 0;
    }

    _ticker = createTicker((elapsed) {
      if (snap) {
        if (value) {
          thumbLoc += (thumbLocMax - thumbLoc) / 2;
          if (thumbLoc > thumbLocMax - 0.1) {
            thumbLoc = thumbLocMax;
            snap = false;
          }
        } else {
          thumbLoc *= 0.8;
          if (thumbLoc <= 0.1) {
            thumbLoc = 0;
            snap = false;
          }
        }
        setState(() {});
      }
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width + 10,
          height: widget.height + 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              )),
        ),
        GestureDetector(
          onTap: () {
            if (!widget.disabled) {
              value = !value;
              snap = true;
              widget.onChange(value);
            }
          },
          onHorizontalDragStart: (DragStartDetails details) {
            if (!widget.disabled) {
              setState(() {
                thumbLoc = details.localPosition.dx - widget.height / 2;
              });
            }
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            if (!widget.disabled) {
              thumbLoc += details.delta.dx;
              setState(() {
                thumbLoc = clampDouble(thumbLoc, 0, thumbLocMax);
              });
            }
          },
          onHorizontalDragEnd: (details) {
            if (!widget.disabled) {
              value = thumbLoc > thumbMid;
              snap = true;
              widget.onChange(value);
            }
          },
          //track
          child: Container(
            margin: const EdgeInsets.all(5),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.disabled
                  ? widget.trackDisabledColor
                  : Color.lerp(widget.trackOffColor, widget.trackOnColor, thumbLoc / thumbLocMax),
              borderRadius: BorderRadius.circular(1000),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(thumbLoc, 0),
          child: GestureDetector(
            onTap: () {
              if (!widget.disabled) {
                if (!widget.disabled) {
                  value = !value;
                  snap = true;
                  widget.onChange(value);
                }
              }
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              if (!widget.disabled) {
                thumbLoc += details.delta.dx;
                setState(() {
                  thumbLoc = clampDouble(thumbLoc, 0, thumbLocMax);
                });
              }
            },
            onHorizontalDragEnd: (details) {
              if (!widget.disabled) {
                value = thumbLoc > thumbMid;
                snap = true;
                widget.onChange(value);
              }
            },
            //thumb
            child: Container(
              clipBehavior: Clip.none,
              margin: const EdgeInsets.all(5),
              width: widget.height,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.disabled
                    ? widget.thumbDisabledColor
                    : Color.lerp(widget.thumbOffColor, widget.thumbOnColor, thumbLoc / thumbLocMax),
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
