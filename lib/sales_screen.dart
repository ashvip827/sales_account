import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Themes: Black & White  /  Blue & White  (switch from the top bar)
// ---------------------------------------------------------------------------
class Palette {
  final String name;
  final Color pageBg;
  final Color sidebarTop;
  final Color sidebarBottom;
  final Color sidebarText;
  final Color sidebarMuted;
  final Color navActiveBg;
  final Color navActiveText;
  final Color primary;
  final Color textDark;
  final Color textMuted;
  final Color border;
  final Color fieldBorder;
  final Color tableHead;
  final Color readOnlyBg;
  final Color danger;
  final Color dangerBg;
  final Color rowSelected;
  final Color chipBg;
  final Color swatchA;
  final Color swatchB;

  const Palette({
    required this.name,
    required this.pageBg,
    required this.sidebarTop,
    required this.sidebarBottom,
    required this.sidebarText,
    required this.sidebarMuted,
    required this.navActiveBg,
    required this.navActiveText,
    required this.primary,
    required this.textDark,
    required this.textMuted,
    required this.border,
    required this.fieldBorder,
    required this.tableHead,
    required this.readOnlyBg,
    required this.danger,
    required this.dangerBg,
    required this.rowSelected,
    required this.chipBg,
    required this.swatchA,
    required this.swatchB,
  });

  static const blackWhite = Palette(
    name: 'Black & White',
    pageBg: Color(0xFFF3F3F3),
    sidebarTop: Color(0xFF050505),
    sidebarBottom: Color(0xFF232323),
    sidebarText: Colors.white,
    sidebarMuted: Color(0xFFB4B4B4),
    navActiveBg: Colors.white,
    navActiveText: Color(0xFF0A0A0A),
    primary: Color(0xFF0F0F0F),
    textDark: Color(0xFF111111),
    textMuted: Color(0xFF7A7A7A),
    border: Color(0xFFE3E3E3),
    fieldBorder: Color(0xFFD2D2D2),
    tableHead: Color(0xFF0F0F0F),
    readOnlyBg: Color(0xFFEEEEEE),
    danger: Color(0xFF111111),
    dangerBg: Color(0xFFECECEC),
    rowSelected: Color(0xFFEDEDED),
    chipBg: Color(0xFFEFEFEF),
    swatchA: Colors.black,
    swatchB: Colors.white,
  );

  static const blueWhite = Palette(
    name: 'Blue & White',
    pageBg: Color(0xFFF1F5FD),
    sidebarTop: Color(0xFF0A2A6E),
    sidebarBottom: Color(0xFF1B4EC8),
    sidebarText: Colors.white,
    sidebarMuted: Color(0xFFBBCBF0),
    navActiveBg: Colors.white,
    navActiveText: Color(0xFF1F5BE8),
    primary: Color(0xFF1F5BE8),
    textDark: Color(0xFF0F2350),
    textMuted: Color(0xFF6B7C9E),
    border: Color(0xFFDFE7F5),
    fieldBorder: Color(0xFFCCD8EE),
    tableHead: Color(0xFF14399B),
    readOnlyBg: Color(0xFFE9F0FC),
    danger: Color(0xFFD93A3A),
    dangerBg: Color(0xFFFDE8E8),
    rowSelected: Color(0xFFE6EEFD),
    chipBg: Color(0xFFEAF0FB),
    swatchA: Color(0xFF1F5BE8),
    swatchB: Colors.white,
  );
}

// ---------------------------------------------------------------------------
// Models & sample data (replace with your database later)
// ---------------------------------------------------------------------------
class Product {
  final String name;
  final String gujarati;
  final String purity;
  final double rate; // per gram
  final double stock; // grams
  const Product(this.name, this.gujarati, this.purity, this.rate, this.stock);
}

class InvoiceLine {
  final Product product;
  final double qty; // weight in grams
  final double rate; // per gram
  final double amount;
  const InvoiceLine({
    required this.product,
    required this.qty,
    required this.rate,
    required this.amount,
  });
}

// Sample rates - type the real rate of the day in the Rate box.
const List<Product> kProducts = [
  Product('GOLD RING', 'સોનાની વીંટી', '22K', 7800, 125.400),
  Product('GOLD CHAIN', 'સોનાની ચેઈન', '22K', 7800, 210.750),
  Product('MANGALSUTRA', 'મંગળસૂત્ર', '22K', 7800, 88.300),
  Product('GOLD BANGLES', 'સોનાની બંગડી', '22K', 7800, 154.900),
  Product('JHUMKA', 'ઝુમકા', '22K', 7800, 64.250),
  Product('SILVER PAYAL', 'ચાંદીની પાયલ', '925', 95, 1420.000),
  Product('DIAMOND PENDANT', 'હીરાનું પેન્ડન્ટ', '18K', 6400, 22.500),
];

const Map<String, double> kAccounts = {
  'BHARAT BHAI': 13470,
  'CASH': 0,
};

const List<String> kSaleTypes = ['Cash Sale', 'Credit Sale'];
const List<String> kPayments = ['Round Off Account', 'Cash', 'Bank / UPI'];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
String fmt(double v, {int decimals = 2}) {
  final neg = v < 0;
  final parts = v.abs().toStringAsFixed(decimals).split('.');
  final digits = parts[0];
  final buf = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buf.write(',');
    buf.write(digits[i]);
  }
  final res = decimals > 0 ? '$buf.${parts[1]}' : buf.toString();
  return neg ? '-$res' : res;
}

String fmtSmart(double v) => fmt(v, decimals: v == v.roundToDouble() ? 0 : 2);

String plain(double v) {
  final s = v.toStringAsFixed(3).replaceFirst(RegExp(r'\.?0+$'), '');
  return s.isEmpty ? '0' : s;
}

String two(int n) => n.toString().padLeft(2, '0');

final _decimalFmt = FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}'));
final _signedDecimalFmt =
FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d{0,3}'));

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------
class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

class _SalesScreenState extends State<SalesScreen> {
  static const double gstRate = 0.03; // 3% GST on gold / silver

  static const _navItems = [
    _NavItem(Icons.home_rounded, 'Home'),
    _NavItem(Icons.receipt_long_outlined, 'Transactions'),
    _NavItem(Icons.bar_chart_rounded, 'Report'),
    _NavItem(Icons.build_outlined, 'Tools'),
    _NavItem(Icons.settings_outlined, 'Setting'),
    _NavItem(Icons.help_outline_rounded, 'Help'),
    _NavItem(Icons.logout_rounded, 'Exit'),
  ];

  Palette p = Palette.blueWhite;

  int _navIndex = 0;
  int _selectedRow = 4;
  DateTime _date = DateTime.now();
  final DateTime _time = DateTime.now();
  String _account = 'BHARAT BHAI';
  String _saleType = 'Cash Sale';
  String _payment = 'Round Off Account';
  Product? _selectedProduct;

  final _noCtrl = TextEditingController(text: '0040');
  final _searchCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _discountCtrl = TextEditingController();
  final _roundOffCtrl = TextEditingController();
  final _remarksCtrl = TextEditingController();

  final _searchFocus = FocusNode();
  final _qtyFocus = FocusNode();
  final _rateFocus = FocusNode();

  final List<InvoiceLine> _lines = [];

  @override
  void initState() {
    super.initState();
    // Sample rows so the screen looks full. Delete them with the bin buttons.
    final weights = [5.2, 12.5, 8.75, 20.0, 6.4, 250.0, 3.2];
    for (int i = 0; i < weights.length; i++) {
      final pr = kProducts[i];
      _lines.add(InvoiceLine(
        product: pr,
        qty: weights[i],
        rate: pr.rate,
        amount: weights[i] * pr.rate,
      ));
    }
  }

  @override
  void dispose() {
    for (final c in [
      _noCtrl,
      _searchCtrl,
      _qtyCtrl,
      _rateCtrl,
      _amountCtrl,
      _discountCtrl,
      _roundOffCtrl,
      _remarksCtrl,
    ]) {
      c.dispose();
    }
    _searchFocus.dispose();
    _qtyFocus.dispose();
    _rateFocus.dispose();
    super.dispose();
  }

  // ---------------- calculations ----------------
  double _num(TextEditingController c) => double.tryParse(c.text.trim()) ?? 0;

  double get _itemTotal => _lines.fold(0.0, (s, l) => s + l.amount);
  double get _totalQty => _lines.fold(0.0, (s, l) => s + l.qty);
  double get _gst => (_itemTotal - _num(_discountCtrl)) * gstRate;
  double get _net => _itemTotal - _num(_discountCtrl) + _gst;
  double get _roundTotal => _net + _num(_roundOffCtrl);
  double get _balance => kAccounts[_account] ?? 0;

  void _calcAmount() {
    setState(() {
      final a = _num(_qtyCtrl) * _num(_rateCtrl);
      _amountCtrl.text = a == 0 ? '' : a.toStringAsFixed(2);
    });
  }

  // ---------------- actions ----------------
  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  Product? _resolveProduct() {
    final text = _searchCtrl.text.trim().toLowerCase();
    if (text.isEmpty) return null;
    if (_selectedProduct != null &&
        _selectedProduct!.name.toLowerCase() == text) {
      return _selectedProduct;
    }
    final matches = kProducts
        .where((x) =>
    x.name.toLowerCase().contains(text) ||
        x.gujarati.contains(_searchCtrl.text.trim()))
        .toList();
    for (final x in matches) {
      if (x.name.toLowerCase() == text) return x;
    }
    return matches.length == 1 ? matches.first : null;
  }

  void _addLine() {
    final pr = _resolveProduct();
    if (pr == null) {
      _snack('Select an ornament from the list');
      _searchFocus.requestFocus();
      return;
    }
    final qty = _num(_qtyCtrl);
    if (qty <= 0) {
      _snack('Enter weight (gm)');
      _qtyFocus.requestFocus();
      return;
    }
    final rate = _num(_rateCtrl);
    setState(() {
      _lines.add(
          InvoiceLine(product: pr, qty: qty, rate: rate, amount: qty * rate));
      _selectedRow = _lines.length - 1;
      _selectedProduct = null;
      _searchCtrl.clear();
      _qtyCtrl.clear();
      _rateCtrl.clear();
      _amountCtrl.clear();
    });
    _searchFocus.requestFocus();
  }

  void _modifySelected() {
    if (_selectedRow < 0 || _selectedRow >= _lines.length) {
      _snack('Select a row to modify');
      return;
    }
    final l = _lines[_selectedRow];
    setState(() {
      _selectedProduct = l.product;
      _searchCtrl.text = l.product.name;
      _qtyCtrl.text = plain(l.qty);
      _rateCtrl.text = plain(l.rate);
      _amountCtrl.text = l.amount.toStringAsFixed(2);
      _lines.removeAt(_selectedRow);
      _selectedRow = -1;
    });
    _qtyFocus.requestFocus();
  }

  void _deleteLine(int i) {
    setState(() {
      _lines.removeAt(i);
      if (_selectedRow == i) {
        _selectedRow = -1;
      } else if (_selectedRow > i) {
        _selectedRow--;
      }
    });
  }

  void _resetForm({required bool nextNumber}) {
    setState(() {
      _lines.clear();
      _selectedRow = -1;
      _selectedProduct = null;
      for (final c in [
        _searchCtrl,
        _qtyCtrl,
        _rateCtrl,
        _amountCtrl,
        _discountCtrl,
        _roundOffCtrl,
        _remarksCtrl,
      ]) {
        c.clear();
      }
      if (nextNumber) {
        final n = int.tryParse(_noCtrl.text.trim()) ?? 0;
        _noCtrl.text = (n + 1).toString().padLeft(4, '0');
      }
      _date = DateTime.now();
    });
  }

  void _save() {
    if (_lines.isEmpty) {
      _snack('Add at least one ornament');
      return;
    }
    _snack('Invoice ${_noCtrl.text} saved  |  Total ${fmtSmart(_roundTotal)}');
    _resetForm(nextNumber: true);
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _date = d);
  }

  String get _dateText => '${two(_date.day)}/${two(_date.month)}/${_date.year}';
  String get _timeText {
    final h = _time.hour % 12 == 0 ? 12 : _time.hour % 12;
    return '${two(h)}:${two(_time.minute)} ${_time.hour >= 12 ? 'PM' : 'AM'}';
  }

  // ---------------- small UI helpers ----------------
  Widget _card({required Widget child, EdgeInsets? padding}) => Container(
    width: double.infinity,
    padding: padding ?? const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: p.border),
      boxShadow: const [
        BoxShadow(
            color: Color(0x12000000), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: child,
  );

  Widget _heading(IconData icon, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 20, color: p.primary),
      const SizedBox(width: 10),
      Text(text,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: p.textDark)),
    ],
  );

  Widget _label(String text, {double size = 13.5}) => Text(text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: size, fontWeight: FontWeight.w600, color: p.textDark));

  Widget _labeled(String label, Widget child, {double size = 13.5}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      _label(label, size: size),
      const SizedBox(height: 5),
      child,
    ],
  );

  Widget _box({
    required Widget child,
    IconData? icon,
    Color? color,
    double height = 38,
    double hpad = 12,
  }) =>
      Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: hpad),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: p.fieldBorder),
        ),
        child: Row(children: [
          if (icon != null) ...[
            Icon(icon, size: 17, color: p.primary),
            const SizedBox(width: 8),
          ],
          Expanded(child: child),
        ]),
      );

  /// A real, typeable text box.
  Widget _field({
    required TextEditingController controller,
    FocusNode? focusNode,
    String hint = '',
    IconData? icon,
    bool numeric = false,
    bool signed = false,
    bool readOnly = false,
    double height = 38,
    double fontSize = 13.5,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
  }) {
    return _box(
      icon: icon,
      height: height,
      color: readOnly ? p.readOnlyBg : null,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        cursorColor: p.primary,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: numeric
            ? const TextInputType.numberWithOptions(
            decimal: true, signed: true)
            : TextInputType.text,
        inputFormatters:
        numeric ? [signed ? _signedDecimalFmt : _decimalFmt] : null,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: p.textDark),
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: hint,
          hintStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: p.textMuted),
        ),
      ),
    );
  }

  Widget _dropdown(
      String value, List<String> items, ValueChanged<String> onChanged,
      {double fontSize = 13}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        isDense: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(9),
        icon: Icon(Icons.keyboard_arrow_down_rounded,
            size: 17, color: p.textDark),
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: p.textDark),
        items: items
            .map((e) => DropdownMenuItem(
            value: e, child: Text(e, overflow: TextOverflow.ellipsis)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  Widget _chip(String text,
      {Color? bg, Color? fg, double fontSize = 13, double height = 30}) =>
      Container(
        height: height,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: bg ?? p.chipBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
                color: fg ?? p.textDark)),
      );

  // ---------------- build ----------------
  // Real responsive layout: every box uses Expanded/Flexible, nothing is a
  // fixed pixel size drawn on a fake canvas, so it can never overflow and it
  // always fills exactly the laptop window it is running in.
  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.f3): _addLine,
        const SingleActivator(LogicalKeyboardKey.f4): _modifySelected,
      },
      child: Scaffold(
        backgroundColor: p.pageBg,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sidebar(),
            Expanded(
              child: Column(
                children: [
                  _topHeader(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _metaCard(),
                          const SizedBox(height: 14),
                          Expanded(child: _productCard()),
                          const SizedBox(height: 14),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(child: _remarksCard()),
                                const SizedBox(width: 14),
                                Expanded(child: _paymentCard()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- sidebar ----------------
  Widget _sidebar() {
    return Container(
      width: 232,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [p.sidebarTop, p.sidebarBottom],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11)),
                child: Icon(Icons.diamond_outlined,
                    color: p.navActiveText, size: 23),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jewel Accounts',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            color: p.sidebarText)),
                    Text('Sales & Billing',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: p.sidebarMuted)),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 22),
          for (int i = 0; i < _navItems.length; i++) _navTile(i),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withAlpha(20),
                    border: Border.all(color: Colors.white.withAlpha(60)),
                  ),
                  child: Icon(Icons.diamond_outlined,
                      size: 46, color: p.sidebarText),
                ),
                const SizedBox(height: 14),
                Text('Pure Gold  |  Pure Trust',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: p.sidebarMuted)),
                const SizedBox(height: 3),
                Text('Better Records, Better Business',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: p.sidebarMuted)),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _navTile(int i) {
    final item = _navItems[i];
    final selected = _navIndex == i;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 3),
      child: Material(
        color: selected ? p.navActiveBg : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => setState(() => _navIndex = i),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
            child: Row(children: [
              Icon(item.icon,
                  size: 20,
                  color: selected ? p.navActiveText : p.sidebarText),
              const SizedBox(width: 14),
              Expanded(
                child: Text(item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.5,
                        fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500,
                        color: selected ? p.navActiveText : p.sidebarText)),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // ---------------- header ----------------
  Widget _themeOption(Palette pal) {
    final sel = p.name == pal.name;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => setState(() => p = pal),
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: sel ? p.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pal.swatchA,
              border: Border.all(color: sel ? Colors.white : pal.swatchA),
            ),
          ),
          const SizedBox(width: 7),
          Text(pal.name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: sel ? Colors.white : p.textDark)),
        ]),
      ),
    );
  }

  Widget _topHeader() {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: p.border)),
      ),
      child: Row(children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
              color: p.primary, borderRadius: BorderRadius.circular(9)),
          child: const Icon(Icons.note_add_outlined,
              size: 18, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text('Sales Invoice Addition',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: p.textDark)),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: p.chipBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            _themeOption(Palette.blackWhite),
            _themeOption(Palette.blueWhite),
          ]),
        ),
        const SizedBox(width: 18),
        CircleAvatar(
          radius: 14,
          backgroundColor: p.primary,
          child: const Icon(Icons.person, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Text('Bharat Bhai',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14.5, color: p.textDark)),
        const SizedBox(width: 4),
        Icon(Icons.keyboard_arrow_down_rounded, size: 17, color: p.textDark),
      ]),
    );
  }

  // ---------------- Date / No / Account (auto-height, full width) ----------------
  Widget _metaCard() {
    final dateField = _labeled(
      'Date',
      InkWell(
        onTap: _pickDate,
        borderRadius: BorderRadius.circular(9),
        child: _box(
          icon: Icons.calendar_month_outlined,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(_dateText,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: p.textDark)),
              ),
              Icon(Icons.keyboard_arrow_down_rounded,
                  size: 17, color: p.textDark),
            ],
          ),
        ),
      ),
    );
    final noField = _labeled(
      'No.',
      _field(
        controller: _noCtrl,
        icon: Icons.description_outlined,
        hint: '0000',
        numeric: true,
      ),
    );
    final accountField = _labeled(
      'Account',
      _box(
        icon: Icons.person_outline_rounded,
        child: _dropdown(_account, kAccounts.keys.toList(),
                (v) => setState(() => _account = v)),
      ),
    );
    final chips = FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerRight,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _chip('Balance: ${fmtSmart(_balance)} Dr',
            bg: p.dangerBg, fg: p.danger),
        const SizedBox(width: 10),
        _chip('Gold 22K : ${fmtSmart(kProducts[0].rate)}', fg: p.primary),
        const SizedBox(width: 10),
        _chip('Silver : ${fmtSmart(kProducts[5].rate)}', fg: p.primary),
      ]),
    );

    return _card(
      child: LayoutBuilder(builder: (context, c) {
        if (c.maxWidth < 900) {
          // Narrow window: stack in two neat rows instead of one tight row.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(flex: 3, child: dateField),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: noField),
                const SizedBox(width: 16),
                Expanded(flex: 4, child: accountField),
              ]),
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerRight, child: chips),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(flex: 3, child: dateField),
            const SizedBox(width: 18),
            Expanded(flex: 2, child: noField),
            const SizedBox(width: 18),
            Expanded(flex: 4, child: accountField),
            const SizedBox(width: 18),
            chips,
          ],
        );
      }),
    );
  }

  // ---------------- Ornament entry (fills the remaining vertical space) ----------------
  Widget _searchField() {
    return RawAutocomplete<Product>(
      textEditingController: _searchCtrl,
      focusNode: _searchFocus,
      displayStringForOption: (x) => x.name,
      optionsBuilder: (TextEditingValue v) {
        final q = v.text.trim().toLowerCase();
        if (q.isEmpty) return kProducts;
        return kProducts.where((x) =>
        x.name.toLowerCase().contains(q) ||
            x.gujarati.contains(v.text.trim()));
      },
      onSelected: (x) {
        setState(() {
          _selectedProduct = x;
          _rateCtrl.text = x.rate > 0 ? plain(x.rate) : '';
        });
        _qtyFocus.requestFocus();
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return _field(
          controller: controller,
          focusNode: focusNode,
          icon: Icons.search_rounded,
          hint: 'Select or type ornament...',
          onSubmitted: (_) => onFieldSubmitted(),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(9),
            color: Colors.white,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260, maxWidth: 400),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, i) {
                  final o = options.elementAt(i);
                  return InkWell(
                    onTap: () => onSelected(o),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text('${o.name}  (${o.purity})',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: p.textDark)),
                          ),
                          const SizedBox(width: 8),
                          Text(o.gujarati,
                              style: TextStyle(
                                  fontSize: 13.5, color: p.textMuted)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _productCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _heading(Icons.diamond_outlined, 'Ornament Entry'),
          const SizedBox(height: 14),
          LayoutBuilder(builder: (context, c) {
            final narrow = c.maxWidth < 760;
            final fields = <Widget>[
              SizedBox(
                width: narrow ? double.infinity : null,
                child: narrow
                    ? _searchField()
                    : ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 220),
                    child: _searchField()),
              ),
              SizedBox(
                width: 130,
                child: _labeled(
                  'Weight (gm)',
                  _field(
                    controller: _qtyCtrl,
                    focusNode: _qtyFocus,
                    hint: '0.000',
                    numeric: true,
                    onChanged: (_) => _calcAmount(),
                    onSubmitted: (_) => _rateFocus.requestFocus(),
                  ),
                ),
              ),
              SizedBox(
                width: 130,
                child: _labeled(
                  'Rate / gm',
                  _field(
                    controller: _rateCtrl,
                    focusNode: _rateFocus,
                    hint: '0.00',
                    numeric: true,
                    onChanged: (_) => _calcAmount(),
                    onSubmitted: (_) => _addLine(),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: _labeled(
                  'Amount',
                  _field(
                      controller: _amountCtrl, hint: '0.00', readOnly: true),
                ),
              ),
              SizedBox(
                width: 100,
                height: 38,
                child: ElevatedButton.icon(
                  onPressed: _addLine,
                  icon: const Icon(Icons.add_rounded, size: 19),
                  label: const Text('Add',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: p.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                  ),
                ),
              ),
            ];
            if (narrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  fields[0],
                  const SizedBox(height: 10),
                  Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: fields.sublist(1)),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: fields[0]),
                const SizedBox(width: 14),
                fields[1],
                const SizedBox(width: 12),
                fields[2],
                const SizedBox(width: 12),
                fields[3],
                const SizedBox(width: 14),
                fields[4],
              ],
            );
          }),
          const SizedBox(height: 14),
          Expanded(child: _table()),
        ],
      ),
    );
  }

  Widget _cell(Widget child,
      {int flex = 1,
        Alignment align = Alignment.centerLeft,
        EdgeInsets pad = const EdgeInsets.only(left: 12),
        Color? dividerColor,
        bool divider = true}) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: align,
        padding: pad,
        decoration: BoxDecoration(
          border: divider
              ? Border(right: BorderSide(color: dividerColor ?? p.border))
              : null,
        ),
        child: child,
      ),
    );
  }

  Widget _headText(String t) => Text(t,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white));

  Widget _table() {
    final dv = Colors.white.withAlpha(45);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Container(
          height: 34,
          color: p.tableHead,
          child: Row(children: [
            _cell(_headText('Name'), flex: 3, dividerColor: dv),
            _cell(_headText('Name(Gujarati)'), flex: 3, dividerColor: dv),
            _cell(_headText('Description'), flex: 3, dividerColor: dv),
            _cell(_headText('Rate / gm'),
                flex: 2,
                dividerColor: dv,
                align: Alignment.centerRight,
                pad: const EdgeInsets.only(right: 14)),
            _cell(_headText('Stock (gm)'),
                flex: 2,
                dividerColor: dv,
                align: Alignment.centerRight,
                pad: const EdgeInsets.only(right: 16)),
            _cell(_headText('Action'),
                flex: 1,
                align: Alignment.center,
                pad: EdgeInsets.zero,
                divider: false),
          ]),
        ),
        Expanded(
          child: _lines.isEmpty
              ? Center(
              child: Text('No ornaments added yet',
                  style: TextStyle(fontSize: 13.5, color: p.textMuted)))
              : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _lines.length,
            itemBuilder: (context, i) => _lineRow(i),
          ),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 46),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: p.border)),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 8,
            spacing: 18,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text('F3 = Add',
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: p.textDark)),
                const SizedBox(width: 16),
                Container(width: 1, height: 14, color: p.fieldBorder),
                const SizedBox(width: 16),
                Text('F4 = Modify',
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: p.textDark)),
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text('Total Weight',
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: p.textDark)),
                const SizedBox(width: 8),
                _chip(fmt(_totalQty, decimals: 3), fontSize: 13),
                const SizedBox(width: 20),
                Text('Total Amount',
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: p.textDark)),
                const SizedBox(width: 8),
                _chip(fmtSmart(_itemTotal), fontSize: 13),
              ]),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _lineRow(int i) {
    final l = _lines[i];
    final selected = i == _selectedRow;
    final nameColor = selected ? p.primary : p.textDark;
    return InkWell(
      onTap: () => setState(() => _selectedRow = i),
      onDoubleTap: () {
        setState(() => _selectedRow = i);
        _modifySelected();
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 38),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: selected ? p.rowSelected : Colors.white,
          border: Border(bottom: BorderSide(color: p.border)),
        ),
        child: Row(children: [
          _cell(
              Text(l.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: nameColor)),
              flex: 3),
          _cell(
              Text(l.product.gujarati,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.5, color: nameColor)),
              flex: 3),
          _cell(
              Text('${l.product.purity}  |  ${plain(l.qty)} g',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.5, color: p.textDark)),
              flex: 3),
          _cell(
              Text(fmt(l.rate),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.5, color: p.textDark)),
              flex: 2,
              align: Alignment.centerRight,
              pad: const EdgeInsets.only(right: 14)),
          _cell(
              Text(fmt(l.product.stock, decimals: 3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: l.product.stock < 0 ? p.danger : p.textDark)),
              flex: 2,
              align: Alignment.centerRight,
              pad: const EdgeInsets.only(right: 16)),
          _cell(
            InkWell(
              borderRadius: BorderRadius.circular(7),
              onTap: () => _deleteLine(i),
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: p.dangerBg, borderRadius: BorderRadius.circular(7)),
                child: Icon(Icons.delete_outline_rounded,
                    size: 14, color: p.danger),
              ),
            ),
            flex: 1,
            align: Alignment.center,
            pad: EdgeInsets.zero,
            divider: false,
          ),
        ]),
      ),
    );
  }

  // ---------------- Remarks (left half of the bottom row) ----------------
  Widget _remarksCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _heading(Icons.chat_outlined, 'Remarks'),
          const SizedBox(height: 10),
          Container(
            height: 62,
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: p.fieldBorder),
            ),
            child: TextField(
              controller: _remarksCtrl,
              maxLines: 2,
              cursorColor: p.primary,
              style: TextStyle(fontSize: 13.5, color: p.textDark),
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: 'Enter remarks here...',
                hintStyle: TextStyle(fontSize: 13.5, color: p.textMuted),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 8,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.schedule_rounded, size: 18, color: p.textDark),
                const SizedBox(width: 8),
                Text('Time :',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: p.textDark)),
                const SizedBox(width: 10),
                _chip(_timeText),
              ]),
              _chip('Net Balance : ${fmtSmart(_balance + _roundTotal)} Dr',
                  bg: p.dangerBg, fg: p.danger),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- Sale type / payment / totals (right half) ----------------
  Widget _paymentCard() {
    final saleTypeField = _labeled(
      'Sale Type',
      _box(
        height: 32,
        hpad: 9,
        child: _dropdown(_saleType, kSaleTypes,
                (v) => setState(() => _saleType = v),
            fontSize: 11.5),
      ),
      size: 12,
    );
    final paymentField = _labeled(
      'Payment',
      _box(
        height: 32,
        hpad: 9,
        child: _dropdown(_payment, kPayments,
                (v) => setState(() => _payment = v),
            fontSize: 11),
      ),
      size: 12,
    );
    final discountField = _labeled(
      'Discount',
      _field(
        controller: _discountCtrl,
        height: 32,
        fontSize: 12,
        hint: '0.00',
        numeric: true,
        onChanged: (_) => setState(() {}),
      ),
      size: 12,
    );
    final gstField = _labeled(
      'GST (3%)',
      _box(
        height: 32,
        hpad: 9,
        color: p.readOnlyBg,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(fmt(_gst),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: p.textDark)),
        ),
      ),
      size: 12,
    );
    final roundOffField = _labeled(
      'Round Off',
      _field(
        controller: _roundOffCtrl,
        height: 32,
        fontSize: 12,
        hint: '0.00',
        numeric: true,
        signed: true,
        onChanged: (_) => setState(() {}),
      ),
      size: 12,
    );

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(builder: (context, c) {
            if (c.maxWidth < 480) {
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 12,
                runSpacing: 10,
                children: [
                  SizedBox(width: 100, child: saleTypeField),
                  SizedBox(width: 128, child: paymentField),
                  SizedBox(width: 86, child: discountField),
                  SizedBox(width: 86, child: gstField),
                  SizedBox(width: 86, child: roundOffField),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 20, child: saleTypeField),
                const SizedBox(width: 10),
                Expanded(flex: 24, child: paymentField),
                const SizedBox(width: 10),
                Expanded(flex: 17, child: discountField),
                const SizedBox(width: 10),
                Expanded(flex: 17, child: gstField),
                const SizedBox(width: 10),
                Expanded(flex: 17, child: roundOffField),
              ],
            );
          }),
          const SizedBox(height: 16),
          Row(children: [
            Text('Net Total',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: p.textDark)),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 32,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    color: p.chipBg, borderRadius: BorderRadius.circular(9)),
                child: Text(fmt(_net),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: p.textDark)),
              ),
            ),
            const SizedBox(width: 14),
            Text('Round Total',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: p.textDark)),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 32,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    color: p.primary, borderRadius: BorderRadius.circular(9)),
                child: Text(fmtSmart(_roundTotal),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 104,
                height: 40,
                child: OutlinedButton.icon(
                  onPressed: () => _resetForm(nextNumber: false),
                  icon: Icon(Icons.note_add_outlined,
                      size: 18, color: p.primary),
                  label: Text('New',
                      style: TextStyle(
                          fontSize: 13.5,
                          color: p.primary,
                          fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: p.primary, width: 1.2),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              SizedBox(
                width: 104,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save_outlined, size: 18),
                  label: const Text('Save',
                      style: TextStyle(
                          fontSize: 13.5, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: p.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}