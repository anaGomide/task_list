import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'viewmodels/task_view_model.dart';
import 'views/task_list_view.dart';

void main() async {
  // Inicializa o binding antes de qualquer operação
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
      ],
      child: MaterialApp(
        title: 'Task List',
        theme: ThemeData(
          primaryColor: const Color(0xFF007FFF), // Primary color
          scaffoldBackgroundColor: const Color(0xFFFFFFFF), // Background branco
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF007FFF), // Primary color
            secondary: const Color(0x1A007FFF), // 10% de saturação
            background: const Color(0xFFF5F7F9), // Cinza claro
          ),
          textTheme: TextTheme(
            // Weight 700, size 20
            headlineLarge: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3F3D56), // Cor #3F3D56
            ),
            // Weight 600, size 18
            headlineMedium: GoogleFonts.urbanist(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3F3D56), // Cor #3F3D56
            ),
            // Weight 600, size 16
            headlineSmall: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3F3D56), // Cor #3F3D56
            ),
            // Weight 500, size 16, color #8D9CB8
            titleLarge: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8D9CB8), // Cor #8D9CB8
            ),
            // Weight 500, size 14, color #8D9CB8
            titleMedium: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8D9CB8), // Cor #8D9CB8
            ),
            // Weight 500, size 16, color #8D9CB8
            bodyLarge: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8D9CB8), // Cor #8D9CB8
            ),
          ),
        ),
        initialRoute: '/todo',
        routes: {
          '/todo': (context) => TaskListView(),
        },
      ),
    );
  }
}
