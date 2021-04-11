import 'package:desktop_window/desktop_window.dart';
import 'package:doonote/model/notepad.dart';
import 'package:doonote/view/screen/notepad_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doonote/bloc/cubit/draw_cubit.dart';
import 'package:doonote/constants/route_constants.dart';
import 'package:doonote/model/adapter/colored_path_adapter.dart';
import 'package:doonote/model/sketch.dart';
import 'package:doonote/view/screen/drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doonote/view/screen/home_screen.dart';
import 'package:doonote/view/widget/hive_box_loader.dart';

String darkModeBox = "ThemeModeBox";
String idBox = "IdsBox";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
  await DesktopWindow.setWindowSize(Size(1500, 900));

  await DesktopWindow.setMinWindowSize(Size(900, 900));

  Hive.registerAdapter(ColoredPathAdapter());
  Hive.registerAdapter(SketchAdapter());
  Hive.registerAdapter(NotepadAdapter());
  runApp(DrawApp());
}

class DrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DrawCubit>.value(
          value: DrawCubit(),
        ),
        BlocProvider<DrawColorCubit>.value(
          value: DrawColorCubit(),
        ),
      ],
      child: HiveBoxLoader(
          boxName: notepadIdsBoxName,
          builder: (context, snapshot) {
            return HiveBoxLoader(
                boxName: idBox,
                builder: (context, snapshot) {
                  return HiveBoxLoader(
                      boxName: darkModeBox,
                      builder: (context, snapshot) {
                        return ValueListenableBuilder(
                          valueListenable: Hive.box(darkModeBox).listenable(),
                          builder: (context, box, widget) {
                            bool darkMode =
                                box.get('darkMode', defaultValue: false);
                            return MaterialApp(
                              title: 'Hive doonote',
                              debugShowCheckedModeBanner: false,
                              themeMode:
                                  darkMode ? ThemeMode.dark : ThemeMode.light,
                              theme: ThemeData(
                                primarySwatch: Colors.blue,
                                fontFamily: 'OpenSans',
                              ),
                              routes: {},
                              onGenerateRoute: onGenerateRoute,
                              darkTheme: ThemeData.dark(),
                              home: HomeScreen(),
                            );
                          },
                        );
                      });
                });
          }),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == drawRoute) {
      final args = settings.arguments as String;
      return MaterialPageRoute(builder: (context) {
        return DrawingScreen(
          boxName: args,
        );
      });
    }
    if (settings.name == notepadRoute) {
      final args = settings.arguments as Notepad;
      return MaterialPageRoute(builder: (context) {
        return NotepadScreen(
          args,
        );
      });
    }
  }
}
