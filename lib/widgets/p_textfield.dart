
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';

class PTextField extends StatefulWidget {
  final String? hintText,errorText,obscuringCharacter;
  final String? initialText;
  final Color fillColor, borderColor,focusedColor;
  final bool isObscured;
  final double borderRadius;
  final double? height;
  final double? size;
  final TextEditingController? controller;
  final int? maxLines;
  final FontWeight? fontWeight;
  final bool? enabled;
  final bool? isDense;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Color? textColor;
  final InputBorder? focuseInputBorder;
  final InputBorder? enabledInputBorder;
  final EdgeInsetsGeometry? contentPadding;
  final GlobalKey<FormState>? formKey;
  final void Function(String? value) feedback;
  final String? Function(String? value) validator;
   const PTextField({
    Key? key, required this.hintText,this.inputFormatters,this.size=12,this.textInputType=TextInputType.text,this.textColor=Constants.black,this.focuseInputBorder,this.contentPadding ,this.enabledInputBorder,
     required this.feedback, this.fillColor = Constants.white,this.focusedColor = Constants.yellow,  this.borderColor = Constants.greyN3, this.isObscured = false,
    this.errorText,  this.controller ,this.enabled=true,this.obscuringCharacter='*',this.fontWeight=FontWeight.w400,this.isDense=false,required this.validator, this.formKey, this.borderRadius = 6,
     this.maxLines, this.initialText, this.height
  }) : super(key: key);

  @override
  State<PTextField> createState() => _PTextFieldState();
}

class _PTextFieldState extends State<PTextField> {
  TextEditingController? controller;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    controller ??= TextEditingController()..text = widget.initialText ?? '';
    super.initState();
  }
 late  bool isObscured = widget.isObscured;
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: widget.formKey,
      child: SizedBox(
        height: widget.height ?? 60,
        child: TextFormField(
          enabled: widget.enabled,
            scrollController: scrollController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller ?? controller ,
            obscureText: isObscured,
            keyboardType:widget.textInputType??TextInputType.text,
            inputFormatters:widget.inputFormatters??[],
            obscuringCharacter: widget.obscuringCharacter ?? '*',
            style:  TextStyle(fontWeight: widget.fontWeight ?? FontWeight.w400,fontSize:widget.size ?? 12,color: widget.textColor ?? Constants.grey),
            cursorColor: Constants.yellow,

            maxLines: !isObscured ? widget.maxLines : 1,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
            widget.feedback(value);
            },
            validator: (value){
            return widget.validator(value);
            },
            decoration: InputDecoration(
              counterText: ' ',
              isDense: widget.isDense ?? true,
              contentPadding:widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
              suffixIcon: widget.isObscured ? IconButton(icon: const Icon(Icons.remove_red_eye_outlined,size: 20),onPressed: (){setState(() {
                isObscured = !isObscured;
              });}) : null,
              filled: true,
              fillColor: widget.fillColor,
              hintStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Constants.greyN1),
              focusedBorder:widget.focuseInputBorder ?? OutlineInputBorder(borderSide: BorderSide(color: widget.focusedColor), borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),),
              errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Constants.red,), borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),),
              focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Constants.red), borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),),
              enabledBorder:widget.enabledInputBorder ?? OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor,width: 0), borderRadius:
              BorderRadius.all(Radius.circular(widget.borderRadius))), disabledBorder : const OutlineInputBorder(borderSide: BorderSide(color: Constants.white,width: 2.0),),
              border:  OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor,width: 0), borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius))),
              hintText:widget.hintText,

            )),
      ),
    );
  }
}