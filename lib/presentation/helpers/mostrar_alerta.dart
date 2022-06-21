import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta( BuildContext context, String titulo, String subtitulo ) {

  if ( Platform.isAndroid ) {
    //*Es dispositivo android
    return showDialog(
      context: context,
      builder: ( _ ) => AlertDialog(
        title: Text( titulo ),
        content: Text( subtitulo ),
        actions: <Widget>[
          MaterialButton(
            child: const Text('Ok'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context)
          )
        ],
      )
    );
  }
    //*Es dispositivo ios
  showCupertinoDialog(
    context: context, 
    builder: ( _ ) => CupertinoAlertDialog(
      title: Text( titulo ),
      content: Text( subtitulo ),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
  );

}