String convertJenisSidang(String jenisSidang) {
  switch (jenisSidang.toLowerCase()) {
    case 'p1':
      return 'Proyek 1';
    case 'p2':
      return 'Proyek 2';
    case 'p3':
      return 'Proyek 3';
    case 'i1':
      return 'Internship 1';
    case 'i2':
      return 'Internship 2';
    case 'ta':
      return 'Tugas Akhir';
    default:
      return jenisSidang;
  }
}
