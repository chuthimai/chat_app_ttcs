class ProcessName {
  String _name;
  String? _standForName;


  String get name => _name;

  String get standForName => _standForName!;

  ProcessName(this._name) {
    _name = normalizeName(_name);
    _standForName = setStandForName(_name);
  }

  //TODO: chuan hoa ten
   normalizeName(String name) {
    // Chuyển tất cả các ký tự thành chữ thường
    String normalized = name.toLowerCase();

    // Chuyển ký tự đầu tiên thành chữ hoa
    normalized = normalized.substring(0, 1).toUpperCase() + normalized.substring(1);

    // Loại bỏ khoảng trắng ở đầu và cuối chuỗi
    normalized = normalized.trim();

    // Tách các từ và chuẩn hóa mỗi từ
    List<String> words = normalized.split(' ');
    normalized = '';
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (word.isNotEmpty) {
        if (i > 0) {
          normalized += ' ';
        }
        normalized += word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
      }
    }

    return normalized;
  }

  //TODO: viet tat ten (VD: Nguyen Van An => annt)
  String setStandForName(name) {
    List<String> words = name.toLowerCase().split(" ");
    String standForName = words[words.length - 1];
    for (var i = 0; i < words.length - 1; i++) {
      standForName += words[i][0];
    }

    return standForName;
  }
}