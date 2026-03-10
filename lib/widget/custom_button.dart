import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String? txt;
  final IconData? icon;
  final Color? clr;
  final void Function()? OnPressed;

  const CustomButton({ this.txt,this.clr,this.OnPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton(onPressed: OnPressed,
          style:ElevatedButton.styleFrom(
              backgroundColor:clr?? const Color(0xFF758F8E), // grey-green shade,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),maximumSize:const Size(double.infinity, 55),elevation: 2 )
          , child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
            ],

            Text(
              txt!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )


    ;
  }
}
