import 'package:assignment_app/helper/global_provider.dart';
import 'package:assignment_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => GlobalProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var email = '';
  var pass = '';
  var emailError = false;
  var passError = false;
  var emailErrorMsg = '';
  var passErrorMsg = '';
  bool passVisible = false;

  bool isValidEmail() {

    if (email.isEmpty) {
      emailError = true;
      emailErrorMsg = 'Email Cannot be Empty';
      return false;
    }
     else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      setState(() {
        emailError = true;
        emailErrorMsg = 'Invalid Email Format';
      });
      return false;
    } else {
      emailError = false;
      emailErrorMsg = '';
      return true;
    }
  }

  bool isValidPass() {
    if (pass.isEmpty) {
      setState(() {
        passError = true;
        passErrorMsg = 'Password cannot be empty';
      });
      return false;
    } else if (pass.length < 6) {
      setState(() {
        passError = true;
        passErrorMsg = 'Minimum 6 characters required';
      });
      return false;
    } else {
      return true;
    }
  }

  void validate() {
    if (!isValidEmail()) {
    } else if (!isValidPass()) {
    } else {
      setState(() {
        emailError = false;
        emailErrorMsg = '';
        passError = false;
        passErrorMsg = '';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    errorText: emailError ? emailErrorMsg : null),
                onChanged: (value) {
                  setState(() {
                    emailError = false;
                    email = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passVisible = !passVisible;
                          });
                        },
                        icon: Icon(passVisible
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    errorText: passError ? passErrorMsg : null),
                obscureText: passVisible,
                onChanged: (value) {
                  setState(() {
                    passError = false;
                    pass = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 360,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    validate();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: themeColor),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
