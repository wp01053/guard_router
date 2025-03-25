import 'package:flutter/material.dart';

// DialogGuardWrapper Widget: Check Conditions and Call Dialogue After Page Entry
class DialogGuardWrapper extends StatefulWidget {
  final bool Function() isChecked;
  final Future<bool> Function(BuildContext) showDialogGuard;
  final Widget child;
  final Widget? indicaotr;

  const DialogGuardWrapper({
    Key? key,
    required this.isChecked,
    required this.showDialogGuard,
    required this.child,
    this.indicaotr,
  }) : super(key: key);

  @override
  _DialogGuardWrapperState createState() => _DialogGuardWrapperState();
}

class _DialogGuardWrapperState extends State<DialogGuardWrapper> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    // Check conditions once after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkGuard());
  }

  Future<void> _checkGuard() async {
    if (!widget.isChecked()) {
      // Call dialog if the condition is not met
      bool shouldProceed = await widget.showDialogGuard(context);
      if (!shouldProceed) {
        // If the user chooses not to proceed, pop the current route
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      }
    }
    setState(() {
      _checked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Before the condition check is over, the loading widget, etc. can be shown.
    if (!_checked) {
      return Center(
          child: (widget.indicaotr != null)
              ? widget.indicaotr
              : const CircularProgressIndicator());
    }
    return widget.child;
  }
}
