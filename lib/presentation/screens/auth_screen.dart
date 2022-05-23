import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_event.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_state.dart';
import 'package:hostel_complain_management_app/data/enums.dart';

import '../utils/snackbars.dart';
import 'feed_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String id = 'auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  String name = '', email = '', password = '';
  Hostel selectedHostel = Hostel.rjb;

  void dropdownCallback(Hostel? selectedValue) {
    if (selectedValue is Hostel) {
      setState(() {
        selectedHostel = selectedValue;
      });
    }
  }

  void _onSaveSignup() {
    bool isValid = _signUpFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _signUpFormKey.currentState!.save();
    context.read<AuthBloc>().add(SignUpEvent(
          name: name,
          email: email,
          password: password,
          hostel: selectedHostel,
        ));
  }

  void _onSaveLogin() {
    bool isValid = _loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _loginFormKey.currentState!.save();
    context.read<AuthBloc>().add(LoginEvent(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: (state is SwitchFormState)
            ? state.showLogin
                ? const Text('Log In')
                : const Text('Sign Up')
            : const Text('Log In'),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is SwitchFormState) {
            if (!state.showLogin) {
              return _signUpScreen(state);
            }
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return _loginScreen(state);
        },
        listener: (context, state) {
          if (state is LoginFailureState) {
            showErrorSnackbar(state.message, context);
          } else if (state is SignUpFailureState) {
            showErrorSnackbar(state.message, context);
          } else if (state is SignUpSuccessState) {
            showSuccessSnackbar('Signed up successfully!', context);
          } else if (state is LoginSuccessState) {
            showSuccessSnackbar('Logged In', context);
            Navigator.pushReplacementNamed(context, FeedScreen.id);
          }
        },
      ),
    );
  }

  Widget _loginScreen(AuthState state) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!.trim();
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.trim().length < 8) {
                          return 'Password must be of atleast 8 characters';
                        } else if (value.trim().contains(' ')) {
                          return 'Password must not contain spaces';
                        }
                        return null;
                      },
                      obscureText: true,
                      onSaved: (value) {
                        password = value!.trim();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _onSaveLogin,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Log in'),
                  )),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const SwitchFormEvent(showLogin: false));
                  },
                  child: const Text(
                    "Don't have an account? Sign up!",
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpScreen(AuthState state) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _signUpFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value!.trim();
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem(
                          value: Hostel.rkb,
                          child: Text('Radhakrishnan Bhawan'),
                        ),
                        DropdownMenuItem(
                          value: Hostel.rb,
                          child: Text('Rajiv Bhawan'),
                        ),
                        DropdownMenuItem(
                          value: Hostel.kb,
                          child: Text('Kasturba Bhawan'),
                        ),
                        DropdownMenuItem(
                          value: Hostel.rjb,
                          child: Text('Rajendra Bhawan'),
                        ),
                        DropdownMenuItem(
                          value: Hostel.sb,
                          child: Text('Sarjoini Bhawan'),
                        ),
                      ],
                      onChanged: dropdownCallback,
                      decoration: const InputDecoration(
                        // labelText: 'Choose Hostel',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      hint: const Text('Select your Hostel'),
                      validator: (value) {
                        if (value == null) {
                          return 'Please choose hostel';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!.trim();
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.trim().length < 8) {
                          return 'Password must be of atleast 8 characters';
                        } else if (value.trim().contains(' ')) {
                          return 'Password must not contain spaces';
                        }
                        return null;
                      },
                      obscureText: true,
                      onSaved: (value) {
                        password = value!.trim();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _onSaveSignup,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Sign up'),
                ),
              ),
              // const SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const SwitchFormEvent(showLogin: true));
                  },
                  child: const Text(
                    'Already have an account? Log in!',
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
