import 'package:flutter/material.dart';
import 'package:restaurant_app/const.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = '/error/';

  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/404.png',
              width: 500,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Ups salah alamat!',
              style: interText2.copyWith(fontSize: 24),
            ),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              'Ada masalah nih\nsama yang develop aplikasinya!',
              textAlign: TextAlign.center,
              style: interText,
            ),
            const SizedBox(height: 10),
            SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Kembali',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
