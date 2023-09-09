import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricPermissionPage extends StatefulWidget {
  @override
  _BiometricPermissionPageState createState() => _BiometricPermissionPageState();
}

class _BiometricPermissionPageState extends State<BiometricPermissionPage> {
  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool hasBiometrics = false;

  @override
  void initState() {
    super.initState();
    checkBiometrics();
  }

  Future<void> checkBiometrics() async {
    try {
      final canCheckBiometrics = await localAuthentication.canCheckBiometrics;
      setState(() {
        hasBiometrics = canCheckBiometrics;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> requestBiometricPermission() async {
    try {
      final isAuthorized = await localAuthentication.authenticate(
        localizedReason: 'Authenticate to access the app',
       
        options: AuthenticationOptions(
            biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true, // Android only, keeps the authentication open until your app closes
        ) // Android only, keeps the authentication open until your app closes
      );
      if (isAuthorized) {
        // The user is authenticated successfully.
        // You can navigate to the main screen or perform the login action here.
        print('Biometric authentication succeeded.');
      } else {
        // Biometric authentication failed or was canceled by the user.
        print('Biometric authentication failed.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric Permission Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Biometric Permission:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              hasBiometrics ? 'Available' : 'Not Available',
              style: TextStyle(
                fontSize: 24,
                color: hasBiometrics ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: hasBiometrics ? requestBiometricPermission : null,
              child: Text('Authenticate with Biometrics'),
            ),
          ],
        ),
      ),
    );
  }
}
