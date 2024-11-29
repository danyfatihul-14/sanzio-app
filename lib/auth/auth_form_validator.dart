class AuthFormValidator {
  registerValidator(
      String email, String password, String fullName, String username) {
    if (username.isEmpty) {
      return "Username tidak boleh kosong";
    }

    if (fullName.isEmpty) {
      return "Nama lengkap tidak boleh kosong";
    }

    if (email.isEmpty) {
      return "Email tidak boleh kosong";
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return "Email tidak valid";
    }

    if (password.isEmpty) {
      return "Password tidak boleh kosong";
    }

    if (password.length < 8) {
      return "Password harus memiliki minimal 8 karakter";
    }

    return null;
  }

  loginValidator(String username, String password) {
    if (username.isEmpty) {
      return "Username tidak boleh kosong";
    }

    if (password.isEmpty) {
      return "Password tidak boleh kosong";
    }

    if (password.length < 8) {
      return "Password harus memiliki minimal 8 karakter";
    }

    return null;
  }
}
