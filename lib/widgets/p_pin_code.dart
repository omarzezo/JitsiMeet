import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PPinCode extends StatefulWidget {
  final int length;
  final void Function(String? value) feedback;
  const PPinCode({
    this.length=5,
    Key? key, required this.feedback,
  }) : super(key: key);

  @override
  State<PPinCode> createState() => _PTextFieldState();
}

class _PTextFieldState extends State<PPinCode> {
  TextEditingController? controller;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  PinCodeTextField(
      appContext: context,
      pastedTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      length:widget.length,
      obscureText: false,
      obscuringCharacter: '*',
      animationType: AnimationType.fade,
      // validator: (v) {
      //   if (v?.length  == 3) {
      //     return "";
      //   } else {
      //     return null;
      //   }
      // },
      pinTheme: PinTheme(
          activeColor: Colors.amber,
          selectedFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          borderWidth: 1,fieldHeight:50, fieldWidth: 50,
          selectedColor: Colors.amber,
          inactiveColor: Colors.grey,
          activeFillColor: Colors.white
      ),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: const TextStyle(fontSize: 20, height: 1.6,color: Colors.black),
      // errorAnimationController: errorController,
      // controller: widget.pinCodeController,
      keyboardType: TextInputType.number,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.white,
          blurRadius: 0,
        )
      ],
      onCompleted: (v) {
      },
      onTap: () {
      },
      onChanged: (value) {
        setState(() {
          widget.feedback(value);
        });
      },
      beforeTextPaste: (text) {
        return true;
      },
    );
  }
}