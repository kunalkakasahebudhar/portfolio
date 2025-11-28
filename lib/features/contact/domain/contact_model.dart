class ContactModel {
  final String name;
  final String email;
  final String? subject;
  final String message;

  ContactModel({
    required this.name,
    required this.email,
    this.subject,
    required this.message,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      if (subject != null && subject!.isNotEmpty) 'subject': subject,
      'message': message,
    };
  }

  // Create from JSON (if needed for response)
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'] as String,
      email: json['email'] as String,
      subject: json['subject'] as String?,
      message: json['message'] as String,
    );
  }

  // Validation
  String? validateName() {
    if (name.isEmpty) {
      return 'Please enter your name';
    }
    if (name.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateEmail() {
    if (email.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateMessage() {
    if (message.isEmpty) {
      return 'Please enter a message';
    }
    if (message.length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  bool isValid() {
    return validateName() == null &&
        validateEmail() == null &&
        validateMessage() == null;
  }
}
