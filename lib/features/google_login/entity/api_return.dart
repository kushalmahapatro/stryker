class ApiReturn {
  ApiReturn(
    this.status,
    this.message,
    this.name,
    this.email,
    this.profileImage,
  );

  final bool status;
  final String message;
  final String name;
  final String email;
  final String profileImage;
}
