import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morse_code_converter/feature/home/bloc/home_cubit/home_cubit.dart';
import 'package:morse_code_converter/feature/home/widgets/button_widget.dart';
import 'package:morse_code_converter/feature/home/widgets/converted_text_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController morseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: morseController,
                      decoration: InputDecoration(
                          labelText: 'Enter text',
                          hintText: 'Enter text',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorText: (state is HomeErrorState)
                              ? state.errorString
                              : null),
                      onChanged: (value) {
                        context.read<HomeCubit>().resetState();
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ButtonWidget(
                      onPressed: () {
                        context
                            .read<HomeCubit>()
                            .convertToEnglish(morseController.text);
                      },
                      label: 'Morse Code To English Text',
                    ),
                    const SizedBox(height: 20.0),
                    ButtonWidget(
                      onPressed: () {
                        context
                            .read<HomeCubit>()
                            .convertToMorse(morseController.text);
                      },
                      label: 'English To Morse Code',
                    ),
                    const SizedBox(height: 20.0),
                    ButtonWidget(
                      onPressed: () {
                        context.read<HomeCubit>().resetState();
                        morseController.clear();
                      },
                      label: 'Clear',
                    ),
                    if (state is HomeConvertState)
                      ConvertedTextWidget(state: state),
                    if (state is HomeFailureState)
                      Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
