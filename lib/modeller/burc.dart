class Burc {
  final String _burcAdi;
  final String _burcTarihi;
  final String _burcDetay;
  final String _burcKucukResim;
  final String _buyukResim;
  get burcAdi => _burcAdi;

  set burcAdi(value) => _burcAdi;

  get burcTarihi => _burcTarihi;

  get burcDetay => _burcDetay;

  get burcKucukResim => _burcKucukResim;

  get buyukResim => _buyukResim;

  Burc(this._burcAdi, this._burcTarihi, this._burcDetay, this._burcKucukResim,
      this._buyukResim);

  @override
  String toString() {
    return '$_burcAdi -$_burcKucukResim';
  }
}
