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

  updateValidator(String username, String fullname, String email, String noTelp,
      String? gender) {
    if (username.isEmpty) {
      return "Username tidak boleh kosong";
    }

    if (fullname.isEmpty) {
      return "Nama lengkap tidak boleh kosong";
    }

    if (email.isEmpty) {
      return "Email tidak boleh kosong";
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return "Email tidak valid";
    }

    if (noTelp.isEmpty) {
      return "Nomor telepon tidak boleh kosong";
    }

    if (!RegExp(r'^\+?\d+$').hasMatch(noTelp)) {
      return "Nomor telepon tidak valid";
    }

    if (gender == null) {
      return "Jenis kelamin tidak boleh kosong";
    }

    return null;
  }

  changePasswordValidator(
      String oldPassword, String newPassword, String validateNewPassword) {
    if (oldPassword.isEmpty) {
      return "Password lama tidak boleh kosong";
    }

    if (oldPassword.length < 8) {
      return "Password lama harus memiliki minimal 8 karakter";
    }

    if (newPassword.isEmpty) {
      return "Password baru tidak boleh kosong";
    }

    if (validateNewPassword.isEmpty) {
      return "Konfirmasi password baru tidak boleh kosong";
    }

    if (newPassword.length < 8) {
      return "Password baru harus memiliki minimal 8 karakter";
    }

    if (newPassword != validateNewPassword) {
      return "Password baru dan konfirmasi password baru tidak sama";
    }

    return null;
  }
}
