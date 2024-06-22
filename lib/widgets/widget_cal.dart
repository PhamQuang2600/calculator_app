import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetCalculator {

  static Widget numberEnter(BuildContext context,String number, double height, VoidCallback onTap,{bool? isFirst = false}){
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: isFirst == true? Border.all(color: Colors.black26): const Border(bottom: BorderSide(color: Colors.black26), top: BorderSide(color: Colors.black26), right: BorderSide(color: Colors.black26))
        ),
        width: (MediaQuery.of(context).size.width - 20)/4,
        height:  height/5,
        child: Center(child: Text(number, style: const TextStyle(color: Colors.black, fontSize: 28))),
      ),
    );
  }
  static Widget calculation(BuildContext context,String icon, double height, VoidCallback onTap,{bool? isFirst = false, bool? isIcon = false, bool? isSvg = false}){
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: isFirst == true? Border.all(color: Colors.black26): const Border(bottom: BorderSide(color: Colors.black26), top: BorderSide(color: Colors.black26), right: BorderSide(color: Colors.black26))
        ),
        width: (MediaQuery.of(context).size.width - 20)/4,
        height:  height/5,
        child: Center(child: isIcon ==true?Image.asset(icon, height: 28, width: 28, color: Colors.blue):isSvg == true?SvgPicture.asset(icon, height: 28, width: 28, color: Colors.blue,): Text(icon, style: const TextStyle(color: Colors.blue, fontSize: 28))),
      ),);
  }
}