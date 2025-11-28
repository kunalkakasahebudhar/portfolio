import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:portfolio/features/contact/domain/contact_model.dart';

class ContactApiService {
  // API Configuration
  static const String _baseUrl = 'http://localhost:8910'; // Development
  // static const String _baseUrl = 'https://your-domain.com'; // Production
  static const String _contactEndpoint = '/api/contact';
  static const Duration _timeout = Duration(seconds: 10);

  /// Send contact message to backend API
  /// Returns true if successful, false otherwise
  Future<bool> sendContactMessage(ContactModel contact) async {
    try {
      final url = Uri.parse('$_baseUrl$_contactEndpoint');

      // Make POST request
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(contact.toJson()),
          )
          .timeout(_timeout);

      // Check response status
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      } else if (response.statusCode == 400) {
        // Validation error from backend
        final data = jsonDecode(response.body);
        throw ContactApiException(
          'Validation error: ${data['message'] ?? 'Invalid data'}',
        );
      } else if (response.statusCode == 500) {
        // Server error
        throw ContactApiException('Server error. Please try again later.');
      } else {
        throw ContactApiException('Unexpected error: ${response.statusCode}');
      }
    } on SocketException {
      throw ContactApiException(
        'No internet connection. Please check your network.',
      );
    } on TimeoutException {
      throw ContactApiException('Request timeout. Please try again.');
    } on FormatException {
      throw ContactApiException('Invalid response from server.');
    } catch (e) {
      if (e is ContactApiException) {
        rethrow;
      }
      throw ContactApiException('Failed to send message: ${e.toString()}');
    }
  }

  /// Send contact message with detailed response
  /// Returns ContactApiResponse with success status and message
  Future<ContactApiResponse> sendContactMessageDetailed(
    ContactModel contact,
  ) async {
    try {
      final url = Uri.parse('$_baseUrl$_contactEndpoint');

      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(contact.toJson()),
          )
          .timeout(_timeout);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ContactApiResponse(
          success: data['success'] ?? false,
          message: data['message'] ?? 'Email sent successfully',
        );
      } else {
        return ContactApiResponse(
          success: false,
          message: data['message'] ?? 'Failed to send email',
        );
      }
    } on SocketException {
      return ContactApiResponse(
        success: false,
        message: 'No internet connection',
      );
    } on TimeoutException {
      return ContactApiResponse(success: false, message: 'Request timeout');
    } catch (e) {
      return ContactApiResponse(
        success: false,
        message: 'Error: ${e.toString()}',
      );
    }
  }
}

/// API Response model
class ContactApiResponse {
  final bool success;
  final String message;

  ContactApiResponse({required this.success, required this.message});
}

/// Custom exception for API errors
class ContactApiException implements Exception {
  final String message;

  ContactApiException(this.message);

  @override
  String toString() => message;
}
