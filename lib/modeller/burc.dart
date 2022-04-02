class Burc {
  final String _burcAdi;
  final String _burcTarihi;
  final String _burcDetay;
  final String _burcKucukResim;
  final String _buyukResim;
  get burcAdi => this._burcAdi;

  set burcAdi(value) => this._burcAdi;

  get burcTarihi => this._burcTarihi;

  get burcDetay => this._burcDetay;

  get burcKucukResim => this._burcKucukResim;

  get buyukResim => this._buyukResim;

  Burc(this._burcAdi, this._burcTarihi, this._burcDetay, this._burcKucukResim,
      this._buyukResim);

  @override
  String toString() {
    return '$_burcAdi -$_burcKucukResim';
  }
}
