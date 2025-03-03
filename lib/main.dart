import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';

import 'app/app.dart';
import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Khalti.init(
    publicKey: 'b0c9156478474dc1bfe3bf4774502a3d',
    enabledDebugging: false,
  );
  runApp(const MyApp());
}

