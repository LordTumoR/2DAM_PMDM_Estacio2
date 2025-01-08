import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/data/bg_data.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_block.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_event.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/login_state.dart';
import 'package:flutter_twitter_copy/utils/animations.dart';
import 'package:flutter_twitter_copy/utils/text_utils.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int selectedIndex = 0;
  bool showOption = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: showOption
                  ? ShowUpAnimation(
                      delay: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bgList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: selectedIndex == index
                                  ? Colors.white
                                  : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(bgList[index]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  showOption = !showOption;
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(bgList[selectedIndex]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.username != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successful')),
            );
            context.go('/home');
          } else if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgList[selectedIndex]),
                fit: BoxFit.fill,
              ),
            ),
            alignment: Alignment.center,
            child: Container(
              height: 400,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Center(
                            child: TextUtil(
                          text: "Login",
                          weight: true,
                          size: 30,
                        )),
                        const Spacer(),
                        TextUtil(text: "Email"),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.mail, color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        const Spacer(),
                        TextUtil(text: "Password"),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.lock, color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                          _emailController.text,
                                          _passwordController.text,
                                        ),
                                      );
                                },
                          child: state.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Log In"),
                        ),
                        const Spacer(),
                        Center(
                          child: TextUtil(
                              text:
                                  "No tienes cuenta, Pos te jodes que no puedes hacer nada",
                              size: 12,
                              weight: true),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
