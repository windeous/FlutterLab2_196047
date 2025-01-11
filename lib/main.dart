import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'provider/favorites_provider.dart';
import 'views/home.dart';
import 'views/joke_types.dart';
import 'views/random_joke.dart';
import 'views/favorites_screen.dart';
import 'models/joke.dart';

// Local notifications plugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialize local notifications
Future<void> initializeNotifications() async {
  const androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Get and print FCM Token
Future<void> fetchFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");
}

// Background message handler
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Background message received: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize local notifications
  await initializeNotifications();

  // Fetch and print the FCM token
  await fetchFCMToken();

  // Register the background message handler
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MaterialApp(
        title: 'Random Jokes',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/jokesByType': (context) {
            final jokeType =
                ModalRoute.of(context)!.settings.arguments as String;
            return JokesByTypeScreen(jokeType: jokeType);
          },
          '/favorites': (context) => const FavoritesScreen(),
          '/randomJoke': (context) {
            final joke = ModalRoute.of(context)!.settings.arguments as Joke;
            return RandomJokeScreen(joke: joke);
          },
        },
      ),
    );
  }
}
