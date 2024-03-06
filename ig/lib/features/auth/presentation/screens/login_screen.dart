import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ig/core/constants/constants.dart';
import 'package:ig/core/widgets/round_button.dart';
import 'package:ig/core/widgets/round_text_field.dart';
import 'package:ig/features/auth/presentation/screens/create_account_screen.dart';
import 'package:ig/features/auth/providers/auth_provider.dart';
import 'package:ig/features/auth/utils/utils.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState(); 
  static const String _routeName = '/login'; 
  static String get route => _routeName;
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isLoading = false;

  Future<void> login() async{
    if(_formKey.currentState!.validate()){
      setState(() => isLoading = true);
      ref.read(authProvider).signIn(email: _emailController.text,password: _passwordController.text,);
      setState(() => isLoading = false);
    }
  }

  @override
  void initState(){
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  super.initState();
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: Constants.defaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/icons/igword.png',
            width: 220,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  RoundTextField(
                    controller: _emailController,
                    hintText: 'Email', 
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                    ),
                    const SizedBox(height: 15,),
                    RoundTextField(
                    controller: _passwordController,
                    hintText: 'Password', 
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    validator: validatePassword,
                    isPassword: true,
                    ),
                    const SizedBox(height: 15,),
                    RoundButton(onPressed: login, label: 'Log In'),
                    const SizedBox(height: 15,),
                    const Text('Forgot password',style: TextStyle(fontSize: 20),),
                ]),
            ),
            Column(
              children: [
                  RoundButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(CreateAccountScreen.routeName);
                    }, 
                    label: 'Create new account',
                    color: Colors.transparent,),
                    Image.asset('assets/icons/meta-logo.png',height: 80,),
              ],
            )
          ],

        ) ),
    );
  }
}