/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: add_account_details.dart
  Description: This file allows the admin to add the details associated with an account. Based on the 
               account type that was passed as a parameter, the corresponding forms will be displayed 
               to the admin.
*/

// Imports utilised in this file
import 'package:anseo_admin/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweetsheet/sweetsheet.dart';

class AddAccountDetails extends StatefulWidget {
  /* 
    This class takes in 1 parameters: 
    -The type of the account whose details we are about to enter.
  */
  final String accountType;
  const AddAccountDetails(this.accountType, {Key? key}) : super(key: key);

  @override
  State<AddAccountDetails> createState() => _AddAccountDetailsState();
}

class _AddAccountDetailsState extends State<AddAccountDetails> {
  // A global key that assists us in validating the sign in form
  final _formKey = GlobalKey<FormState>();

  // Instance of the class FAS located in firebase_auth.dart, allowing us to authenticate the user with Firebase
  final FAS _auth = FAS();

  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  // Text field state within the form
  String error = '';
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String operatorName = 'Dublin Bus';
  String addressline1 = '';
  String addressline2 = '';
  String city = '';
  String county = '';
  String postcode = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        // Dynamically Display the account type as the title of the page
        title: Text(
          'Add ${widget.accountType} Account',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),

            /*
              If the account type selected is 
              - User = User Sign In Form 
              - Driver = Driver Sign In Form 
              - Admin = Admin Sign In Form 
            */
            child: widget.accountType == "User"
                ? addUser()
                : widget.accountType == "Driver"
                    ? addDriver()
                    : addAdmin(),
          ),
        ),
      ),
    );
  }

  /* 
    Function which returns a form to input details for the 
    user account
  */
  addUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "${widget.accountType} Sign Up",
            style: (const TextStyle(fontSize: 30.0)),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  /* Input First Name */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          "First Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Color(0xFF9CA4AA),
                          ),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a first name' : null,
                            onChanged: (val) {
                              setState(() => firstName = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15.0),

                  /* Input Last Name */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          "Last Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Color(0xFF9CA4AA),
                          ),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a last name' : null,
                            onChanged: (val) {
                              setState(() => lastName = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              /* Input Email Address */
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "Email Address",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF9CA4AA),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),
              /* Input Password */
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF9CA4AA),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),
              /* Input Phone Number */
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "Phone Number",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF9CA4AA),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
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
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),

              /* Input Address Line 1 */
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "Address Line 1",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF9CA4AA),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an address line 1' : null,
                      onChanged: (val) {
                        setState(() => addressline1 = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),

              /* Input Address Line 2 */
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "Address Line 2",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF9CA4AA),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an address line 2' : null,
                      onChanged: (val) {
                        setState(() => addressline2 = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),

              /* Input City */
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "City",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF9CA4AA),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter a city' : null,
                      onChanged: (val) {
                        setState(() => city = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  /* Input County */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          "County",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Color(0xFF9CA4AA),
                          ),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a county' : null,
                            onChanged: (val) {
                              setState(() => county = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  /* Input Postcode */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          "Postcode",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Color(0xFF9CA4AA),
                          ),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a postcode' : null,
                            onChanged: (val) {
                              setState(() => postcode = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        /* Submit Button */
        const SizedBox(height: 40.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4158D0),
                Color(0xFFC850C0),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
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
                  if (result == null || result == false) {
                    setState(() {
                      error = 'Please supply a valid email';
                    });
                  } else {
                    _sweetSheet.show(
                      isDismissible: false,
                      context: context,
                      title: const Text("User Account Created!"),
                      description: Text(
                          "The user account has been successfully created with the ID: $result. Click on 'Return' to return to the homepage"),
                      color: SweetSheetColor.SUCCESS,
                      icon: Icons.task_alt_sharp,
                      positive: SweetSheetAction(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        title: 'RETURN',
                        icon: Icons.keyboard_return,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),

        /* Displaying any error messages to the user */
        const SizedBox(height: 12.0),
        Text(
          error,
          style: const TextStyle(color: Colors.red, fontSize: 14.0),
        ),
      ],
    );
  }

  /* 
    Function which returns a form to input details for the 
    driver account
  */
  addDriver() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "${widget.accountType} Sign Up",
            style: (TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.manrope().fontFamily,
              color: Colors.black,
            )),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  /* Input First Name */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "First Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: const Color(0xFF9CA4AA),
                            fontFamily: GoogleFonts.manrope().fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a first name' : null,
                            onChanged: (val) {
                              setState(() => firstName = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15.0),

                  /* Input Last Name */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Last Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: const Color(0xFF9CA4AA),
                            fontFamily: GoogleFonts.manrope().fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a last name' : null,
                            onChanged: (val) {
                              setState(() => lastName = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              /* Input Email Address */
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Email Address",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: const Color(0xFF9CA4AA),
                      fontFamily: GoogleFonts.manrope().fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),
              /* Input Password */
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: const Color(0xFF9CA4AA),
                      fontFamily: GoogleFonts.manrope().fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),
              /* Input Operator Name */
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Select Operator",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: const Color(0xFF9CA4AA),
                      fontFamily: GoogleFonts.manrope().fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  DropdownButton<String>(
                    value: operatorName,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        operatorName = newValue!;
                      });
                    },
                    items: <String>[
                      'Dublin Bus',
                      'Go Ahead',
                      'Iarnrod Eireann',
                      'Luas'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
        /* Submit Button */
        const SizedBox(height: 40.0),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // primary: Colors.transparent,
              // shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                dynamic result = await _auth.signUpDriver(
                    email, password, firstName, lastName, operatorName);
                if (result == null || result == false) {
                  setState(() {
                    error = 'Please supply a valid email';
                  });
                } else {
                  _sweetSheet.show(
                    isDismissible: false,
                    context: context,
                    title: const Text("Driver Account Created!"),
                    description: Text(
                        "The driver account has been successfully created with the ID: $result. Click on 'Return' to return to the homepage"),
                    color: SweetSheetColor.SUCCESS,
                    icon: Icons.task_alt_sharp,
                    positive: SweetSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      title: 'RETURN',
                      icon: Icons.keyboard_return,
                    ),
                  );
                }
              }
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4158D0),
                    Color(0xFFC850C0),
                  ],
                ),
              ),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                  ),
                ),
              ),
            ),
          ),
        ),

        /* Displaying any error messages to the user */
        const SizedBox(height: 12.0),
        Text(
          error,
          style: const TextStyle(color: Colors.red, fontSize: 14.0),
        ),
      ],
    );
  }

  /* 
    Function which returns a form to input details for the 
    user account
  */
  addAdmin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "${widget.accountType} Sign Up",
            style: (TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.manrope().fontFamily,
              color: Colors.black,
            )),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  /* Input First Name */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "First Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: const Color(0xFF9CA4AA),
                            fontFamily: GoogleFonts.manrope().fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a first name' : null,
                            onChanged: (val) {
                              setState(() => firstName = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15.0),

                  /* Input Last Name */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Last Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: const Color(0xFF9CA4AA),
                            fontFamily: GoogleFonts.manrope().fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a last name' : null,
                            onChanged: (val) {
                              setState(() => lastName = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              /* Input Email Address */
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Email Address",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: const Color(0xFF9CA4AA),
                      fontFamily: GoogleFonts.manrope().fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),
              /* Input Password */
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: const Color(0xFF9CA4AA),
                      fontFamily: GoogleFonts.manrope().fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  TextFormField(
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
        /* Submit Button */
        const SizedBox(height: 40.0),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // primary: Colors.transparent,
              // shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                dynamic result = await _auth.signUpAdmin(
                    email, password, firstName, lastName);
                if (result == null || result == false) {
                  setState(() {
                    error = 'Please supply a valid email';
                  });
                } else {
                  _sweetSheet.show(
                    isDismissible: false,
                    context: context,
                    title: const Text("Admin Account Created!"),
                    description: Text(
                        "The admin account has been successfully created with the ID: $result. Click on 'Return' to return to the homepage"),
                    color: SweetSheetColor.SUCCESS,
                    icon: Icons.task_alt_sharp,
                    positive: SweetSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      title: 'RETURN',
                      icon: Icons.keyboard_return,
                    ),
                  );
                }
              }
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4158D0),
                    Color(0xFFC850C0),
                  ],
                ),
              ),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                  ),
                ),
              ),
            ),
          ),
        ),

        /* Displaying any error messages to the user */
        const SizedBox(height: 12.0),
        Text(
          error,
          style: const TextStyle(color: Colors.red, fontSize: 14.0),
        ),
      ],
    );
  }
}
