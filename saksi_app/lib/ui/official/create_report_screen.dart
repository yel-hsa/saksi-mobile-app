import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import '../shared/custom_button.dart';
import '../shared/custom_input.dart';

class CreateReportScreen extends StatelessWidget {
  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final caseIdController = TextEditingController(text: '1043-C');

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New Case File',
          style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CASE IDENTIFIER',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomInput(hintText: '1043-C', controller: caseIdController),
                      const SizedBox(height: 20),
                      Text(
                        'SUMMARY',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const CustomInput(hintText: 'Short description (mock)'),
                      const Spacer(),
                      CustomButton(
                        text: 'Create Case',
                        fullWidth: true,
                        size: ButtonSize.lg,
                        variant: ButtonVariant.primary,
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Case created (mock).')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

