import 'package:calendaroo/colors.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:flutter/material.dart';

class FabButton extends StatefulWidget {
  FabButton({Key key}) : super(key: key);

  @override
  State createState() => FabButtonState();
}

class FabButtonState extends State<FabButton> with TickerProviderStateMixin {
  AnimationController _controller;

  OverlayEntry _overlayEntry;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildFab();
  }

  Widget _buildFab() {
    return GestureDetector(
      onLongPress: () {
        if (_controller.isDismissed) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        if (_overlayEntry == null) {
          _overlayEntry = _createOverlayEntry();
          Overlay.of(context).insert(_overlayEntry);
        }
      },
      child: FloatingActionButton(
        onPressed: () {
          if (!_controller.isDismissed) {
            _controller.reverse();
          }
          removeMiniButtons();
          NavigationService().navigateTo(DETAILS);
        },
        elevation: 4.0,
        child: Icon(Icons.add),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    var renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var nMiniButtons = 3;
    var miniButtonHeight = (64 + 32) * nMiniButtons + 16;
    var padding = 16;
    return OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx - padding / 4.0,
              top: offset.dy -
                  (size.height / 2) -
                  miniButtonHeight / 2 -
                  padding,
              child: _floatingMiniButtons(),
            ));
  }

  Widget _floatingMiniButtons() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, 1.0 - 3 / 2 / 2.0, curve: Curves.easeOut),
            ),
            child: FloatingActionButton(
              backgroundColor: white,
              foregroundColor: grey,
              mini: true,
              onPressed: () {
                removeMiniButtons();
              },
              child: Icon(Icons.close),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, 1.0 - 2 / 2 / 2.0, curve: Curves.easeOut),
            ),
            child: FloatingActionButton(
              backgroundColor: white,
              foregroundColor: yellow,
              mini: true,
              onPressed: () {
                removeMiniButtons();
              },
              child: Icon(Icons.calendar_today),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, 1.0 - 1 / 2 / 2.0, curve: Curves.easeOut),
            ),
            child: FloatingActionButton(
              backgroundColor: white,
              foregroundColor: yellow,
              mini: true,
              onPressed: () {
                removeMiniButtons();
              },
              child: Icon(Icons.flag),
            ),
          ),
        ),
      ],
    );
  }

  void removeMiniButtons() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }
}
