import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SittingsScreen extends StatelessWidget {
  SittingsScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).userModel!;
        nameController.text = cubit.data!.name!;
        emailController.text = cubit.data!.email!;
        phoneController.text = cubit.data!.phone!;
        return BuildCondition(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UpdateLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 15),
                    deffaultFormField(
                      controller: nameController,
                      labelText: "Name",
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Name must not be empty";
                        }
                      },
                      type: TextInputType.name,
                    ),
                    const SizedBox(height: 15),
                    deffaultFormField(
                      controller: emailController,
                      labelText: "Email Address",
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Email Address must not be empty";
                        }
                      },
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    deffaultFormField(
                      controller: phoneController,
                      labelText: "Phone",
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Phone must not be empty";
                        }
                      },
                      type: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    deffaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: "UPDATE",
                    ),
                    const SizedBox(height: 15),
                    deffaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: "logout"),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
