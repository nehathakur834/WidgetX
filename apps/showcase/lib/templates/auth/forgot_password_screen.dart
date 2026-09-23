import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_emailController.text.trim().isNotEmpty) {
      setState(() => _sent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(WidgetXSpacing.xl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _sent ? _SuccessView(email: _emailController.text) : _FormView(
                emailController: _emailController,
                onSubmit: _submit,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView({required this.emailController, required this.onSubmit});
  final TextEditingController emailController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Icon
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.lock_reset_outlined,
                size: 36, color: cs.onPrimaryContainer),
          ),
        ).animate().fadeIn(duration: 400.ms).scaleXY(begin: 0.8, end: 1.0),
        const SizedBox(height: WidgetXSpacing.xl),

        Text('Forgot password?',
            style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center)
            .animate()
            .fadeIn(delay: 80.ms, duration: 350.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: WidgetXSpacing.xs),
        Text(
          "Enter your email and we'll send you a reset link.",
          style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(delay: 130.ms, duration: 350.ms),
        const SizedBox(height: WidgetXSpacing.xxl),

        WidgetXTextField(
          controller: emailController,
          label: 'Email address',
          hint: 'you@example.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined, size: 18),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 300.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: WidgetXSpacing.xl),

        WidgetXButton(
          label: 'Send reset link',
          onPressed: onSubmit,
          variant: WidgetXButtonVariant.primary,
          isFullWidth: true,
        )
            .animate()
            .fadeIn(delay: 260.ms, duration: 300.ms),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mark_email_read_outlined,
                size: 40, color: Colors.green.shade600),
          ),
        ).animate().fadeIn(duration: 400.ms).scaleXY(begin: 0.7, end: 1.0),
        const SizedBox(height: WidgetXSpacing.xl),

        Text('Check your email',
            style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center)
            .animate()
            .fadeIn(delay: 100.ms, duration: 300.ms),
        const SizedBox(height: WidgetXSpacing.sm),
        Text(
          "We sent a password reset link to\n$email",
          style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(delay: 160.ms, duration: 300.ms),
        const SizedBox(height: WidgetXSpacing.xxl),

        WidgetXButton(
          label: 'Back to sign in',
          onPressed: () => Navigator.of(context).pop(),
          variant: WidgetXButtonVariant.outlined,
          isFullWidth: true,
          leadingIcon: const Icon(Icons.arrow_back, size: 18),
        )
            .animate()
            .fadeIn(delay: 220.ms, duration: 300.ms),
        const SizedBox(height: WidgetXSpacing.md),
        TextButton(
          onPressed: () {},
          child: const Text("Didn't receive it? Resend"),
        )
            .animate()
            .fadeIn(delay: 280.ms, duration: 280.ms),
      ],
    );
  }
}
