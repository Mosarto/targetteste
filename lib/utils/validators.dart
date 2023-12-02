String? senhaValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Senha obrigatória';
  }
  if (value.length < 2) {
    return 'Senha deve ter mais de 2 caracteres';
  }
  if (!RegExp(r'^[a-zA-Z0-9]{2,}$').hasMatch(value)) {
    return 'Senha deve ter apenas letras e números';
  }
  if (value.length > 20) {
    return 'Senha deve ter menos de 20 caracteres';
  }
  if (value.endsWith(' ')) {
    return 'Senha não pode terminar com espaço';
  }
  return null;
}

String? usuarioValidador(String? value) {
  if (value == null || value.isEmpty) {
    return 'Usuário obrigatório';
  }
  if (value.length > 20) {
    return 'Usuário deve ter menos de 20 caracteres';
  }
  if (value.endsWith(' ')) {
    return 'Usuário não pode terminar com espaço';
  }
  return null;
}

String? tituloValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Título obrigatório';
  }
  if (value.length > 20) {
    return 'Título deve ter menos de 20 caracteres';
  }
  if (value.endsWith(' ')) {
    return 'Título não pode terminar com espaço';
  }
  return null;
}
