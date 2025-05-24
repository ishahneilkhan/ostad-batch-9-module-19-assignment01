import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tm_getx/ui/controllers/forgot_otp_controller.dart';
import 'package:tm_getx/ui/screens/reset_password_screen.dart';
import 'package:tm_getx/ui/screens/sign_in_screen.dart';
import '../utils/app_colors.dart';
import '../widgets/screen_background.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key, required this.email});
  final String email;
  @override
  State<ForgotPasswordOtpScreen> createState() => _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  bool _inProgress = false;
  final TextEditingController _pinCodeTEController = TextEditingController();
  final ForgotOtpController forgotOtpController = Get.find<ForgotOtpController>();



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
                  'Pin Verification',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digits verification otp has been sent to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildVerifyEmailForm(),
                const SizedBox(height: 48),
                Center(child: _buildHaveAccountSection())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyEmailForm() {
    return Column(
      children: [
        PinCodeTextField(
          controller: _pinCodeTEController,
          length: 6,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14, letterSpacing: 0.5),
        text: "Have account? ",
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    _recoverOTPVerify();
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
          (_) => false,
    );
  }

  Future<void> _recoverOTPVerify() async {
    String _code=_pinCodeTEController.text.trim();

    final bool result= await forgotOtpController.recoverOTPVerify(_code, widget.email);

    if (result) {
      Get.snackbar(
        'Success',
        'OTP Verified',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen(email:widget.email,otp:_code)),

      );
    } else {
      String? errorMessage=await ForgotOtpController().errorMessage;
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
    _pinCodeTEController.dispose();
    super.dispose();
  }

}
