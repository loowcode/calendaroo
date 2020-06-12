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
  void dispose(){
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
        print("long");
        if (this._overlayEntry == null) {
          this._overlayEntry = this._createOverlayEntry();
          Overlay.of(context).insert(this._overlayEntry);
        }
      },
      child: FloatingActionButton(
        onPressed: () {
          if (!_controller.isDismissed) {
            _controller.reverse();
          }
          removeMiniButtons();
          NavigationService().navigateTo(ADD_EVENT);
        },
        child: Icon(Icons.add),
        elevation: 4.0,
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx - 4.0,
              top: offset.dy - (size.height / 2) - 110.0,
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
              curve: Interval(0.0, 1.0 - 2 / 2 / 2.0, curve: Curves.easeOut),
            ),
            child: FloatingActionButton(
              key: Key('mini-event'),
              backgroundColor: primaryWhite,
              foregroundColor: accentYellow,
              mini: true,
              child: Icon(Icons.calendar_today),
              onPressed: () {
                removeMiniButtons();
              },
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
              key: Key('mini-goal'),
              backgroundColor: primaryWhite,
              foregroundColor: accentYellow,
              mini: true,
              child: Icon(Icons.flag),
              onPressed: () {
                removeMiniButtons();
              },
            ),
          ),
        ),
      ],
    );
  }

  void removeMiniButtons() {
    if (this._overlayEntry != null) {
      this._overlayEntry.remove();
      this._overlayEntry = null;
    }
  }
}