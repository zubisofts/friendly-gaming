import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friendly_gaming/src/blocs/auth/auth_bloc.dart';
import 'package:friendly_gaming/src/screens/reset_password_screen.dart';
import 'package:friendly_gaming/src/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  Function onPageChanged;

  LoginScreen(this.onPageChanged);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/gaming_img3.jpg',
                      fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        EmailInput(),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        PasswordInput(),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox.shrink(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ResetPasswordScreen()));
                              },
                              child: Text('Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        LoginButton()
                      ],
                    )),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => context
                              .bloc<AuthBloc>()
                              .add(LoginWithFacebokEvent()),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: Image.asset('assets/icons/fb.png'),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        InkWell(
                          onTap: () => context
                              .bloc<AuthBloc>()
                              .add(LoginWithGoogleEvent()),
                          borderRadius: BorderRadius.circular(20.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Image.asset('assets/icons/google.png'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: onPageChanged,
                          child: Text(
                            "Signup Now",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpinKitDualRing(
                      color: Colors.blue,
                      size: 50.0,
                      lineWidth: 3,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Signing In',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        )
      ],
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isPasswordValid = true;

        if (state is OnLoginFormSubmittedState) {
          isPasswordValid = state.passwordRes;
        }

        return TextFormField(
          key: const Key('password_input'),
          onChanged: (password) => context.bloc<AuthBloc>().add(
              OnSubmitLoginFormDetailsEvent(
                  password: password, isEmail: false)),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Enter password',
              helperText: '',
              hintStyle:
                  TextStyle(color: Theme.of(context).textTheme.headline6.color),
              errorText: isPasswordValid ? null : 'invalid password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).textTheme.headline6.color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).textTheme.headline6.color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).textTheme.headline6.color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).textTheme.headline6.color))),
          style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
        );
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isEmailValid = true;

        if (state is OnLoginFormSubmittedState) {
          isEmailValid = state.emailRes;
        }

        return TextFormField(
          key: const Key("email_input"),
          onChanged: (email) => context
              .read<AuthBloc>()
              .add(OnSubmitLoginFormDetailsEvent(email: email, isEmail: true)),
          decoration: InputDecoration(
            hintText: 'Enter email',
            helperText: '',
            hintStyle:
                TextStyle(color: Theme.of(context).textTheme.headline6.color),
            errorText: isEmailValid ? null : 'invalid email',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).textTheme.headline6.color)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).textTheme.headline6.color)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).textTheme.headline6.color)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).textTheme.headline6.color)),
          ),
          style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          // pr.show();
        } else {
          // if (pr.isShowing()) pr.hide();
        }

        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          bool emailRes = false;
          bool passwordRes = false;

          if (state is OnLoginFormSubmittedState) {
            emailRes = state.emailRes;
            passwordRes = state.passwordRes;
          }
          return Container(
            margin: EdgeInsets.only(top: 32),
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              disabledColor: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 18),
              onPressed: emailRes && passwordRes
                  ? () => context
                      .bloc<AuthBloc>()
                      .add(LoginWithEmailAndPasswordEvent())
                  : null,
              child: Text(
                'LOGIN',
                style: TextStyle(color: Colors.white),
              ),
              color: emailRes && passwordRes ? Colors.blue : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
