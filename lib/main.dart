import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_your_secrets/src/app.dart';
import 'package:save_your_secrets/src/providers/creation_form_provider.dart';
import 'package:save_your_secrets/src/providers/edit_form_provider.dart';
import 'package:save_your_secrets/src/providers/login_form_provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => CreationFormProvider()),
        ChangeNotifierProvider(create: (_) => EditFormProvider()),
      ],
      child: App()
    )
  );
}
