import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Register Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginRegisterPage(),
    );
  }
}

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  LoginRegisterPageState createState() => LoginRegisterPageState();
}

class LoginRegisterPageState extends State<LoginRegisterPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  bool _isLogin = true;
  bool _isLoggedIn = false; // Adăugăm o variabilă pentru a urmări starea de autentificare

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoggedIn ? ProfilePage() : _buildLoginPage(),
      ),
    );
  }

  Widget _buildLoginPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'img/logo_intercon.png',
                height: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: _isLogin ? _buildLoginForm() : _buildRegisterForm(),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin; // Schimbă starea pentru a trece de la login la register și invers
                });
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                backgroundColor: Colors.transparent,
              ),
              child: Text(
                _isLogin ? 'Create Account' : 'Back to Login',
                style: TextStyle(color: Colors.pink.withOpacity(0.7)), // Opacitate 70% și culoare gradient roz-mov
              ),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Implement "Forgot Password" functionality here
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                backgroundColor: Colors.transparent,
              ),
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.pink.withOpacity(0.7)), // Opacitate 70% și culoare gradient roz-mov
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _login();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, // Setăm zero pentru a elimina padding-ul implicit al butonului
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pink.withOpacity(1), // Aplicăm opacitatea de 70% pentru culoarea roz
                    Colors.purple.withOpacity(0.7), // Aplicăm opacitatea de 70% pentru culoarea mov
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0), // Setăm dimensiunile minime ale butonului
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _register();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
              backgroundColor: Colors.pink.withOpacity(0.7), // Aplicăm opacitatea de 70% pentru culoarea roz
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
            ),
            child: Text('Register'),
          ),
        ],
      ),
    );
  }

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://localhost:5000/api/users/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Login successful, handle token
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['token'];
      // Implement logic to handle token (e.g., save it, navigate to home screen, etc.)
      setState(() {
        _isLoggedIn = true; // Actualizăm starea de autentificare
      });
      Navigator.push( // Navigăm către pagina de profil
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    } else {
      // Login failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to login. Please check your credentials.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }



  void _register() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final username = _usernameController.text;

    final response = await http.post(
      Uri.parse('http://localhost:5000/api/users/register'),
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'username': username,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Registration successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to register. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality
              Navigator.pop(context); // Go back to login page
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to your profile!'),
      ),
    );
  }
}
