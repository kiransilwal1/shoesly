import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/widgets/buttons/button_styles.dart';
import '../../../../core/widgets/buttons/minimal_buttons.dart';

class TextFieldWithPlusMinus extends StatefulWidget {
  const TextFieldWithPlusMinus({Key? key}) : super(key: key);

  @override
  _TextFieldWithPlusMinusState createState() => _TextFieldWithPlusMinusState();
}

class _TextFieldWithPlusMinusState extends State<TextFieldWithPlusMinus> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController(text: '1');
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _incrementValue() {
    setState(() {
      int currentValue = int.parse(_controller.text);
      _controller.text = (currentValue + 1).toString();
    });
  }

  void _decrementValue() {
    setState(() {
      int currentValue = int.parse(_controller.text);
      if (currentValue > 1) {
        _controller.text = (currentValue - 1).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: 'Enter number',
        suffixIcon: Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MinimalButton(
                isDisabled: false,
                style: const IconOnlyStyle(
                  iconImagePath: 'assets/icons/minus-cirlce.png',
                ),
                onPressed: _decrementValue,
              ),
              MinimalButton(
                isDisabled: false,
                style: const IconOnlyStyle(
                    iconImagePath: 'assets/icons/add-circle.png'),
                onPressed: _incrementValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
