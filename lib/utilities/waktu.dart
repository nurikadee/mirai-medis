import 'package:intl/intl.dart';

class Waktu {
  DateTime dateTime;

  static const List<String> _hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
  static const List<String> _bulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  static const List<String> _kuartal = [
    'pertama',
    'kedua',
    'ketiga',
    'keempat'
  ];

  Waktu([DateTime dateTime]) {
    this.dateTime = dateTime ?? DateTime.now();
  }

  String forE() => _hari[this.dateTime.weekday - 1].substring(0, 3);
  String forEEEE() => _hari[this.dateTime.weekday - 1];
  String forLLL() => _bulan[this.dateTime.month - 1].substring(0, 3);
  String forLLLL() => _bulan[this.dateTime.month - 1];
  String forMMM() => _bulan[this.dateTime.month - 1].substring(0, 3);
  String forMMMd() =>
      '${this.dateTime.day.toString()} ${_bulan[this.dateTime.month - 1].substring(0, 3)}';
  String forMMMEd() =>
      '${_hari[this.dateTime.weekday - 1].substring(0, 3)}, ${this.dateTime.day.toString()} ${_bulan[this.dateTime.month - 1].substring(0, 3)}';
  String forMMMM() => _bulan[this.dateTime.month - 1];
  String forMMMMd() =>
      '${this.dateTime.day.toString()} ${_bulan[this.dateTime.month - 1]}';
  String forMMMMEEEEd() =>
      '${_hari[this.dateTime.weekday - 1]}, ${this.dateTime.day.toString()} ${_bulan[this.dateTime.month - 1]}';
  String forQQQQ() =>
      'Kuartal ${_kuartal[((this.dateTime.month - 1) / 3).floor()]}';
  String foryMd() =>
      '${this.dateTime.day.toString()}/${this.dateTime.month.toString()}/${this.dateTime.year.toString()}';
  String foryMEd() =>
      '${_hari[this.dateTime.weekday - 1].substring(0, 3)}, ${this.dateTime.day.toString()}/${this.dateTime.month.toString()}/${this.dateTime.year.toString()}';
  String foryMMM() =>
      '${_bulan[this.dateTime.month - 1].substring(0, 3)} ${this.dateTime.year.toString()}';
  String foryMMMd() =>
      '${this.dateTime.day.toString()} ${_bulan[this.dateTime.month - 1].substring(0, 3)} ${this.dateTime.year.toString()}';
  String foryMMMEd() =>
      '${_hari[this.dateTime.weekday - 1].substring(0, 3)}, ${this.dateTime.day.toString()} ${_bulan[this.dateTime.month - 1].substring(0, 3)} ${this.dateTime.year.toString()}';
  String foryMMMM() =>
      '${_bulan[this.dateTime.month - 1]} ${this.dateTime.year.toString()}';
  String foryMMMMd() =>
      '${this.dateTime.day.toString()} ${_bulan[this.dateTime.month - 1]} ${this.dateTime.year.toString()}';
  String foryMMMMEEEEd() =>
      '${_hari[this.dateTime.weekday - 1]}, ${this.dateTime.day.toString()} ${_bulan[this.dateTime.month - 1]} ${this.dateTime.year.toString()}';

  String format(String format) {
    format = format.replaceAll('EEEE', "'${this.forEEEE()}'");
    format = format.replaceAll('E', "'${this.forE()}'");
    format = format.replaceAll('LLLL', "'${this.forLLLL()}'");
    format = format.replaceAll('LLL', "'${this.forLLL()}'");
    format = format.replaceAll('MMMM', "'${this.forMMMM()}'");
    format = format.replaceAll('MMM', "'${this.forMMM()}'");

    return DateFormat(format).format(this.dateTime);
  }
}

class Numerik {
  int number;

  static const List<String> _bilang = [
    '',
    'satu',
    'dua',
    'tiga',
    'empat',
    'lima',
    'enam',
    'tujuh',
    'delapan',
    'sembilan'
  ];

  Numerik(this.number);

  String _doTerbilang(int number) {
    if (number < 10) return _bilang[number];
    if (number < 20) {
      int modsepuluh = number % 10;
      if (modsepuluh == 0)
        return 'sepuluh';
      else if (modsepuluh == 1) return 'sebelas';
      return '${_bilang[modsepuluh]} belas';
    }
    if (number < 100) {
      int divsepuluh = number ~/ 10;
      int modsepuluh = number % 10;
      String result = '${_bilang[divsepuluh]} puluh';
      if (modsepuluh > 0) result = '$result ${_bilang[modsepuluh]}';
      return result;
    }
    if (number < 1000) {
      int divseratus = number ~/ 100;
      int modseratus = number % 100;
      String result = '';
      if (divseratus == 1)
        result = 'seratus';
      else
        result = '${_bilang[divseratus]} ratus';
      if (modseratus > 0) result = '$result ${_doTerbilang(modseratus)}';
      return result;
    }
    if (number < 1000000) {
      int divseribu = number ~/ 1000;
      int modseribu = number % 1000;
      String result = '';
      if (divseribu == 1)
        result = 'seribu';
      else
        result = '${_doTerbilang(divseribu)} ribu';
      if (modseribu > 0) result = '$result ${_doTerbilang(modseribu)}';
      return result;
    }
    if (number < 1000000000) {
      int divjuta = number ~/ 1000000;
      int modjuta = number % 1000000;
      String result = '${_doTerbilang(divjuta)} juta';
      if (modjuta > 0) result = '$result ${_doTerbilang(modjuta)}';
      return result;
    }
    if (number < 1000000000000) {
      int divm = number ~/ 1000000000;
      int modm = number % 1000000000;
      String result = '${_doTerbilang(divm)} milyar';
      if (modm > 0) result = '$result ${_doTerbilang(modm)}';
      return result;
    }
    if (number < 1000000000000000) {
      int divt = number ~/ 1000000000000;
      int modt = number % 1000000000000;
      String result = '${_doTerbilang(divt)} triliun';
      if (modt > 0) result = '$result ${_doTerbilang(modt)}';
      return result;
    }
    return '';
  }

  String terbilang() {
    if (this.number < 0) throw Exception('Not accept negative number');
    if (this.number >= 1000000000000000)
      throw Exception('Out of limit convertion');
    if (this.number == 0) return 'nol';
    return _doTerbilang(this.number);
  }
}
