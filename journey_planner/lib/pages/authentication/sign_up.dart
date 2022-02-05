import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_planner/services/firebase_auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  const SignUp({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FAS _auth = FAS();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String addressline1 = '';
  String addressline2 = '';
  String city = '';
  String county = '';
  String postcode = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Sign up'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  /* Input First Name */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a first name' : null,
                      onChanged: (val) {
                        setState(() => firstName = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "First Name",
                      )),

                  /* Input Last Name */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a last name' : null,
                      onChanged: (val) {
                        setState(() => lastName = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                      )),

                  /* Input Email Address */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                      )),

                  /* Input Password */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "Password",
                      )),

                  /* Input Phone Number */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a phone number' : null,
                      onChanged: (val) {
                        setState(() => phoneNumber = val);
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                      )),

                  /* Input Address Line 1 */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an address line 1' : null,
                      onChanged: (val) {
                        setState(() => addressline1 = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "Address Line 1",
                      )),

                  /* Input Address Line 2 */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an address line 2' : null,
                      onChanged: (val) {
                        setState(() => addressline2 = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "Address Line 2",
                      )),

                  /* Input City */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter a city' : null,
                      onChanged: (val) {
                        setState(() => city = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "City",
                      )),

                  /* Input County */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a county' : null,
                      onChanged: (val) {
                        setState(() => county = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "County",
                      )),

                  /* Input Postcode */
                  const SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a postcode' : null,
                      onChanged: (val) {
                        setState(() => postcode = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "Postcode",
                      )),

                  /* Submit Button */
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.pink[400]),
                      // color: Colors.pink[400],
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth.signUpUser(
                              email,
                              password,
                              firstName,
                              lastName,
                              addressline1,
                              addressline2,
                              city,
                              county,
                              postcode,
                              phoneNumber);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      }),
                  const SizedBox(height: 12.0),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
