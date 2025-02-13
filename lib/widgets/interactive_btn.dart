import 'package:flutter/material.dart';

import '../tools/bg_consts.dart';

class InteractiveBtn extends StatefulWidget {
  final Widget body;
  final Color backgroundColor;
  final Color shadowColor;
  final BorderRadius radius;
  final VoidCallback? onPressed;

  final EdgeInsets padding;
  const InteractiveBtn({
    super.key,
    required this.body,
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.black12,
    this.radius = const BorderRadius.all(Radius.circular(BgConsts.radius)),
    this.padding = const EdgeInsets.symmetric(
        horizontal: BgConsts.hSpace, vertical: BgConsts.hSpace - 5.0),
    required this.onPressed,
  });

  @override
  State<InteractiveBtn> createState() => _InteractiveBtnState();
}

class _InteractiveBtnState extends State<InteractiveBtn> {
  double _blurValue = 3.0;
  Offset _blurOffset = const Offset(2.5, 2.5);

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.onPressed != null;
    return AnimatedOpacity(
      curve: Curves.easeInOutCubic,
      duration: Durations.short4,
      opacity: enabled ? 1.0 : 0.5,
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: Durations.short4,
        decoration: BoxDecoration(
          color: enabled ? widget.backgroundColor : Colors.grey,
          borderRadius: widget.radius,
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              spreadRadius: 0.0,
              offset: enabled ? _blurOffset : const Offset(0.0, 0.0),
              blurRadius: enabled ? _blurValue : 0.0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onHover: _onHover,
            borderRadius: widget.radius,
            child: Padding(
              padding: widget.padding,
              child: widget.body,
            ),
          ),
        ),
      ),
    );
  }

  _onTapDown(TapDownDetails details) {
    setState(() {
      _blurValue = .5;
      _blurOffset = const Offset(.5, .5);
    });
  }

  _onTapUp(TapUpDetails details) {
    setState(() {
      _blurValue = 3.0;
      _blurOffset = const Offset(2.5, 2.5);
    });
  }

  _onTapCancel() {
    setState(() {
      _blurValue = 3.0;
      _blurOffset = const Offset(2.5, 2.5);
    });
  }

  _onHover(bool hover) {
    if (hover) {
      setState(() {
        _blurValue = .5;
        _blurOffset = const Offset(.5, .5);
      });
    } else {
      setState(() {
        _blurValue = 3.0;
        _blurOffset = const Offset(2.5, 2.5);
      });
    }
  }
}
