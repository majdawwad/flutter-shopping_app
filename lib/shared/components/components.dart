import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUpperCase = false,
  required Function()? function,
  required String text,
}) =>
    Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
          color: color,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 18.0,
              bottom: 18.0,
            ),
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          onPressed: function,
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType type,
  required String? Function(String? value)? functionValidation,
  required String labelText,
  TextStyle? labelStyle,
  TextStyle? hintStyle,
  InputBorder? enborder,
  required IconData prifixIcon,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixFunction,
  Function()? onTap,
  Function(String)? onChanged,
  Function(String)? onSubmit,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: functionValidation,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        enabledBorder: enborder,
        prefixIcon: Icon(
          prifixIcon,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixFunction,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );

Widget defaultDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 25.0,
      ),
      child: Container(
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

void defaultToast(
        {String? message,
        required BuildContext context,
        required DialogType typeMeswsage}) =>
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: typeMeswsage,
      btnOkIcon: Icons.check_circle,
      btnOkColor: defaultToastColor(typeMeswsage),
      body: Column(
        children: [
          Text(
            message!,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 11.0,
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green.shade500,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
              ),
            ),
          ),
        ],
      ),
    ).show();

Color defaultToastColor(DialogType? type) {
  late Color color;
  if (type == DialogType.SUCCES) {
    color = Colors.green.shade800;
  } else if (type == DialogType.ERROR) {
    color = Colors.red.shade800;
  } else {
    color = Colors.amber.shade800;
  }
  return color;
}

TextFormField buildTextFormField({
  TextEditingController? controller,
  TextDirection? textDirection,
  TextInputType? type,
  String? labelText,
  TextStyle? labelStyle,
  String? hintText,
  TextDirection? hintTextDirection,
  TextStyle? hintStyle,
  IconData? prifixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
  Color colorEnableBorder = Colors.grey,
  Color colorFocusedBorder = const Color.fromRGBO(254, 159, 21, 1),
  Color colorBackgroundPrefixIcon = const Color.fromRGBO(254, 159, 21, 1),
  Color colorPrifixIcon = Colors.white,
  Function()? searchFunction,
  String? Function(String? value)? functionValidation,
  Function()? suffixFunction,
  Function()? prefixFunction,
  Function()? onTap,
  Function(String)? onChanged,
  Function(String)? onSubmit,
}) {
  return TextFormField(
    controller: controller,
    textDirection: textDirection,
    keyboardType: type,
    obscureText: isPassword,
    validator: functionValidation,
    onChanged: onChanged,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      hintText: hintText,
      hintTextDirection: hintTextDirection,
      hintStyle: hintStyle,
      prefixIcon: prifixIcon != null
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return InkWell(
                  borderRadius: BorderRadius.circular(37.0),
                  onTap: searchFunction,
                  child: Container(
                    width: constraints.maxWidth / 5,
                    height: constraints.minHeight / .8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(37.0),
                      color: colorBackgroundPrefixIcon,
                    ),
                    child: Icon(
                      prifixIcon,
                      color: colorPrifixIcon,
                    ),
                  ),
                );
              },
            )
          : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
              onPressed: suffixFunction,
              icon: Icon(
                suffixIcon,
              ),
            )
          : null,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          37.0,
        ),
        borderSide: BorderSide(
          color: colorEnableBorder,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          37.0,
        ),
        borderSide: BorderSide(
          color: colorFocusedBorder,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          37.0,
        ),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}
