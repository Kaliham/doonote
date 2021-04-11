import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:doonote/bloc/cubit/draw_cubit.dart';

class HiveBoxLoader extends StatelessWidget {
  String boxName;
  Function builder;
  String errorMessage;
  String loadingMessage;
  HiveBoxLoader({
    @required this.builder,
    @required this.boxName,
    this.errorMessage = 'Something went wrong :/',
    this.loadingMessage = "loading...",
  });
  @override
  Widget build(BuildContext context) {
    print(boxName);
    return Container(
      child: FutureBuilder(
        future: Hive.openBox(boxName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print(snapshot.error);
              return Scaffold(
                body: Center(
                  child: Text(errorMessage),
                ),
              );
            } else {
              return builder(context, snapshot);
            }
          } else {
            return Scaffold(
              body: Center(
                child: Text(loadingMessage),
              ),
            );
          }
        },
      ),
    );
  }
}
