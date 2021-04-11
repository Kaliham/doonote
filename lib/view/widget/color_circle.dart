import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doonote/bloc/cubit/draw_cubit.dart';
import 'package:doonote/constants/ui_constants.dart';
import 'package:doonote/model/colored_path.dart';

class ColorCirlce extends StatelessWidget {
  int colorIndex;
  DrawColorCubit colorCubit;

  ColorCirlce({@required this.colorIndex});

  @override
  Widget build(BuildContext context) {
    colorCubit = BlocProvider.of<DrawColorCubit>(context);
    return BlocBuilder<DrawColorCubit, int>(builder: (context, state) {
      bool selected = state == colorIndex;
      return GestureDetector(
        onTap: () {
          colorCubit.change(colorIndex);
        },
        child: ClipOval(
          child: Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            height: selected ? circleLargeSize : circleSmallSize,
            width: selected ? circleLargeSize : circleSmallSize,
            color: ColoredPath.colors[colorIndex],
          ),
        ),
      );
    });
    ;
  }
}
