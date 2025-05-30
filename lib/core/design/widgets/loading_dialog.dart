import 'package:flutter/material.dart';
import 'package:parking_controller/core/services/main.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static showLoading() {
    showDialog(
      context: getCurrentContext(),
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(),
    );
  }

  static hideLoading() {
    Navigator.of(getCurrentContext()).pop();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
