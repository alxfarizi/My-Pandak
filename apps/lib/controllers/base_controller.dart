//base_controller.dart
import 'package:flutter/material.dart';

abstract class BaseController extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  @protected
  Future<T> handleAsync<T>(Future<T> future) async {
    try {
      setLoading(true);
      clearError();
      final result = await future;
      return result;
    } catch (e) {
      setError(e.toString());
      rethrow; // Re-throw untuk handling di level controller
    } finally {
      setLoading(false);
    }
  }

  // Method khusus untuk operasi yang bisa return null
  @protected
  Future<T?> handleAsyncNullable<T>(Future<T?> future) async {
    try {
      setLoading(true);
      clearError();
      final result = await future;
      return result;
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }

  // Method untuk operasi boolean (create, update, delete)
  @protected
  Future<bool> handleAsyncBool(Future<dynamic> future) async {
    try {
      setLoading(true);
      clearError();
      await future;
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      setLoading(false);
    }
  }
}
