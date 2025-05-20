import 'package:flutter/material.dart';

class SwitchApp extends StatelessWidget {
  final bool toggleValue;
  const SwitchApp({super.key,

    required this.toggleValue
});



  @override
  Widget build(BuildContext context) {
    return SwitchExample(toggleValue:toggleValue);
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({
    super.key,
    required this.toggleValue,
    this.child,
  });

  final bool toggleValue;
  final Widget? child;

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;
  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch(
          // value: widget.toggleValue,
          value: light,
          activeTrackColor: Color(0xFFC5D9FB),
          activeColor: Color(0xFF4182EF),
          inactiveThumbColor: Color(0xFF8E8E8E),
          inactiveTrackColor: Color(0xFFBFBFBF),
          onChanged: (bool value) {
            setState(() {
              // widget.toggleValue = value;
              light = value;
            });
          },
        ),

      ],
    );
  }
}