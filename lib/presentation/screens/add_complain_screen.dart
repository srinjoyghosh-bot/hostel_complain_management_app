import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/add_complain/add_complain_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/add_complain/add_complain_event.dart';
import 'package:hostel_complain_management_app/business_logic/add_complain/add_complain_state.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/presentation/utils/snackbars.dart';

import '../widgets/app_drawer.dart';

class AddComplainScreen extends StatefulWidget {
  const AddComplainScreen({Key? key}) : super(key: key);
  static const String id = 'add';

  @override
  _AddComplainScreenState createState() => _AddComplainScreenState();
}

class _AddComplainScreenState extends State<AddComplainScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '', body = '';
  ComplainType selectedType = ComplainType.miscellaneous;

  void onSubmit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    context.read<AddComplainBloc>().add(
        AddComplainEvent(title: title, body: body, complainType: selectedType));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Complain'),
      ),
      body: BlocConsumer<AddComplainBloc, AddComplainState>(
          listener: (context, state) {
        if (state is AddSuccessState) {
          showSuccessSnackbar('Complain added!', context);
        } else if (state is AddFailureState) {
          showErrorSnackbar(state.message, context);
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Give a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    title = value!.trim();
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Body',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Give a body';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    body = value!.trim();
                  },
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      value: ComplainType.mess,
                      child: Text('Mess'),
                    ),
                    DropdownMenuItem(
                      value: ComplainType.maintenance,
                      child: Text('Maintenance'),
                    ),
                    DropdownMenuItem(
                      value: ComplainType.cultural,
                      child: Text('Cultural'),
                    ),
                    DropdownMenuItem(
                      value: ComplainType.sports,
                      child: Text('Sports'),
                    ),
                    DropdownMenuItem(
                      value: ComplainType.miscellaneous,
                      child: Text('Miscellaneous'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value is ComplainType) {
                      selectedType = value;
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Choose a complain type';
                    }
                    return null;
                  },
                  hint: const Text('Select a complain type'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
      floatingActionButton:
          (context.watch<AddComplainBloc>().state is LoadingState)
              ? null
              : FloatingActionButton(
                  onPressed: onSubmit,
                  child: const Icon(Icons.done_rounded),
                ),
      drawer: AppDrawer(),
    );
  }
}
