class ApiErrorResponseMessage {
  String? status;
  String? errorMessage;

  ApiErrorResponseMessage({required this.status, required this.errorMessage});

  ApiErrorResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error_message'] = errorMessage;
    return data;
  }
}