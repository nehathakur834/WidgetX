import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetx_ui/widgetx_ui.dart';

/// OTP Verification Screen — shown after register or forgot-password flow.
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool _verified = false;

  void _verify() => setState(() => _verified = true);

  void _resend() {
    // In a real app: trigger resend and start countdown timer.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification code resent!')),
    );
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
          padding: EdgeInsets.fromLTRB(
            WidgetXSpacing.xl,
            WidgetXSpacing.xl,
            WidgetXSpacing.xl,
            WidgetXSpacing.xl + MediaQuery.of(context).padding.bottom,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _verified
                  ? _SuccessState(
                      onDone: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/templates/auth/login');
                        }
                      },
                    )
                  : _OtpForm(onVerify: _verify, onResend: _resend),
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpForm extends StatelessWidget {
  const _OtpForm({required this.onVerify, required this.onResend});
  final VoidCallback onVerify;
  final VoidCallback onResend;

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
            child: Icon(Icons.sms_outlined,
                size: 36, color: cs.onPrimaryContainer),
          ),
        ).animate().fadeIn(duration: 400.ms).scaleXY(begin: 0.8, end: 1.0),
        const SizedBox(height: WidgetXSpacing.xl),

        Text('Enter verification code',
            style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center)
            .animate()
            .fadeIn(delay: 80.ms, duration: 350.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: WidgetXSpacing.xs),
        Text(
          'We sent a 6-digit code to your email.\nEnter it below to continue.',
          style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(delay: 130.ms, duration: 350.ms),
        const SizedBox(height: WidgetXSpacing.xxl),

        // OTP input using WidgetXOTPField
        WidgetXOTPField(
          length: 6,
          onCompleted: (code) {
            // Auto-verify on complete for demo
            onVerify();
          },
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 300.ms),
        const SizedBox(height: WidgetXSpacing.xl),

        WidgetXButton(
          label: 'Verify',
          onPressed: onVerify,
          variant: WidgetXButtonVariant.primary,
          isFullWidth: true,
        )
            .animate()
            .fadeIn(delay: 260.ms, duration: 300.ms),
        const SizedBox(height: WidgetXSpacing.lg),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Didn't receive a code?",
                style: tt.bodyMedium),
            TextButton(
              onPressed: onResend,
              child: const Text('Resend'),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 280.ms),
      ],
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.onDone});
  final VoidCallback onDone;

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
            child: Icon(Icons.check_circle_outline,
                size: 44, color: Colors.green.shade600),
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms)
            .scaleXY(
              begin: 0.5,
              end: 1.0,
              curve: Curves.easeOutBack,
            ),
        const SizedBox(height: WidgetXSpacing.xl),

        Text('Verified!',
            style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center)
            .animate()
            .fadeIn(delay: 100.ms),
        const SizedBox(height: WidgetXSpacing.xs),
        Text(
          'Your account has been successfully verified.',
          style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(delay: 160.ms),
        const SizedBox(height: WidgetXSpacing.xxl),

        WidgetXButton(
          label: 'Continue',
          onPressed: onDone,
          variant: WidgetXButtonVariant.primary,
          isFullWidth: true,
          leadingIcon: const Icon(Icons.arrow_forward, size: 18),
        )
            .animate()
            .fadeIn(delay: 220.ms),
      ],
    );
  }
}
