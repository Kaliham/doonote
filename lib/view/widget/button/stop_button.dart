import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doonote/bloc/cubit/draw_cubit.dart';

class StopButton extends StatelessWidget {
  StopButton();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DrawCubit>(context);
    return BlocBuilder<DrawCubit, bool>(builder: (context, state) {
      return IconButton(
        icon: !state
            ? Icon(Icons.brush_outlined)
            : Icon(Icons.zoom_out_map_rounded),
        onPressed: () {
          BlocProvider.of<DrawCubit>(context).change();
        },
      );
    });
  }
}
