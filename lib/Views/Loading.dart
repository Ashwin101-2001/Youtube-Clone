import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ytube_search/constanst/constants.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: loaderColor[400],
      child: Center(

          child: Image.network(
            'https://img.pikbest.com/58pic/35/39/61/62K58PICb88i68HEwVnm5_PIC2018.gif!w340',
            width: 300,
            height: 400,
            fit: BoxFit.contain,
          ),)

    );
  }
}
