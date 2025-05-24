import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_getx/ui/controllers/add_new_task_controller.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});



  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _shouldRefreshPreviousPage = false;
  final AddNewTaskController controller = Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
    canPop: false,
    onPopInvoked: (didPop) {
      if (didPop) {
        return;
      }
      Navigator.pop(context, _shouldRefreshPreviousPage);
    },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TMAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 42),
                  Text(
                    'Add New Task',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(hintText: 'Title'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 5,
                    decoration: const InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<AddNewTaskController>(
                    builder: (context) {
                      return Visibility(
                        visible: !context.inProgress,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapSubmitButton,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState?.validate() ?? false) {
      _addNewTask();
    }
  }


  Future<void> _addNewTask() async {
    final bool result = await controller.addNewTask(
      _titleTEController.text.trim(),
      _descriptionTEController.text.trim(),
    );
    if(result)
      {
        _shouldRefreshPreviousPage=true;
        _clearTextFields();
        Get.snackbar(
          'Success',
          'New Task Added!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }else
    {
      final errorMessage = controller.errorMessage;
      Get.snackbar(
        'Failed',
        errorMessage ?? 'Login failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
