import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

void main() {
  runApp(SpotifyAuthApp());
}

class SpotifyAuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Authentication Example',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Colors.black,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(
            'Connect to Spotify',
            style: Theme.of(context).textTheme.headline6,
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
          ),
          onPressed: () async {
            // Initialize the Spotify SDK with your client ID and redirect URI
            await SpotifySdk.initialize(
              clientId: 'YOUR_CLIENT_ID',
              redirectUri: 'YOUR_REDIRECT_URI',
            );

            // Authenticate the user
            final result = await SpotifySdk.authenticate();
            if (result.isSuccess) {
              print('Successfully authenticated with Spotify');
            } else {
              print('Error authenticating with Spotify: ${result.error}');
            }
          },
        ),
      ),
    );
  }
}
