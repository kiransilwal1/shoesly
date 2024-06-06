import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/common/widgets/buttons/button_styles.dart';
import '../../../../core/common/widgets/buttons/minimal_buttons.dart';

class TextFieldWithPlusMinus extends StatefulWidget {
  const TextFieldWithPlusMinus({Key? key, required this.onChanged})
      : super(key: key);
  final Function(int) onChanged;

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldWithPlusMinusState createState() => _TextFieldWithPlusMinusState();
}

class _TextFieldWithPlusMinusState extends State<TextFieldWithPlusMinus> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {});
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
    widget.onChanged(int.parse(_controller.text));
  }

  void _decrementValue() {
    setState(() {
      int currentValue = int.parse(_controller.text);
      if (currentValue > 1) {
        _controller.text = (currentValue - 1).toString();
      }
    });
    widget.onChanged(int.parse(_controller.text));
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
        suffixIcon: SizedBox(
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
