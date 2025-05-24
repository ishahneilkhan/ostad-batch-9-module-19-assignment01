import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_getx/ui/controllers/forgot_email_controller.dart';

import '../widgets/screen_background.dart';
import '../widgets/snackbar_message.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  String? _emailError;
  bool _inProgress = false;
  final ForgotEmailController forgotEmailController = Get.find<ForgotEmailController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Forgot Password',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email address to receive a reset OTP',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildEmailForm(),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    return Column(
      children: [
        TextFormField(

          controller: _emailTEController,
          focusNode: _emailFocusNode,
          decoration: InputDecoration(
            hintText: 'Email Address',
            errorText: _emailError,
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _inProgress ? null : _onTapSendOtpButton,
          child: _inProgress
              ? const CircularProgressIndicator()
              : const Text('Send OTP'),
        ),
      ],
    );
  }

  void _onTapSendOtpButton() {
    String email = _emailTEController.text;

    if (email.isEmpty || !email.contains('@')) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      return;
    }

    setState(() {
      _emailError = null;
    });

    _sendOtpRequest();
  }

  Future<void> _sendOtpRequest() async {
    String _email=_emailTEController.text.trim();
    final bool result= await forgotEmailController.sendOtpRequest(_email);
    if (result) {
      Get.snackbar(
        'Success',
        'Email an email 6 digit PinCode',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordOtpScreen(email: _email),
        ),
      );
    } else {
      String? errorMessage=await ForgotEmailController().errorMessage;
      Get.snackbar(
        'Failed',
        errorMessage!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  @override
  void dispose() {
    _emailTEController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
