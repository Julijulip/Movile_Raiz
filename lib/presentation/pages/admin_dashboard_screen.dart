// lib/presentation/pages/admin_dashboard_screen.dart

import 'package:flutter/material.dart';
import '../../main.dart';
import '../widgets/profile_bottom_sheet.dart';
import 'admin_products_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Filtros para Gráfico 1 (Semana)
  String selectedDay = 'Todos';
  final List<String> daysList = [
    'Todos',
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  // Datos interactivos Gráfico 1 (Ingresos vs Costos por día)
  final Map<String, Map<String, double>> weeklyData = {
    'Lunes': {'income': 0.25, 'costs': 0.12},
    'Martes': {'income': 0.50, 'costs': 0.32},
    'Miércoles': {'income': 0.35, 'costs': 0.25},
    'Jueves': {'income': 0.65, 'costs': 0.48},
    'Viernes': {'income': 0.72, 'costs': 0.55},
    'Sábado': {'income': 0.90, 'costs': 0.72},
    'Domingo': {'income': 0.70, 'costs': 0.58},
  };

  // Filtros para Gráfico 2 (Meses)
  String selectedMonth = 'Todos';
  final List<String> monthsList = [
    'Todos',
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic',
  ];

  // Datos interactivos Gráfico 2 (Ganancias en millones por mes)
  final Map<String, double> monthlyEarningsData = {
    'Ene': 5.2,
    'Feb': 6.1,
    'Mar': 7.5,
    'Abr': 7.0,
    'May': 8.8,
    'Jun': 8.1,
    'Jul': 9.5,
    'Ago': 10.2,
    'Sep': 8.9,
    'Oct': 10.5,
    'Nov': 12.0,
    'Dic': 14.2,
  };

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: RaizUrbanaApp.themeNotifier,
      builder: (context, themeMode, child) {
        final isDark = themeMode == ThemeMode.dark;

        final scaffoldBg = isDark
            ? const Color(0xFF1A1C28)
            : const Color(0xFFF3ECE7);
        final cardBg = isDark ? const Color(0xFF242736) : Colors.white;
        final textPrimary = isDark ? Colors.white : const Color(0xFF2E3148);
        final iconCircleBg = isDark
            ? const Color(0xFF2E3148)
            : const Color(0xFFF3ECE7);
        final bannerBg = isDark
            ? const Color(0xFF242736)
            : const Color(0xFF2E3148);
        final chartLineColor = isDark
            ? const Color(0xFF8B92B0)
            : const Color(0xFF2E3148);

        // Cálculo dinámico de ganancias según el filtro de mes
        double displayedEarnings = 0;
        if (selectedMonth == 'Todos') {
          displayedEarnings = monthlyEarningsData.values.reduce(
            (a, b) => a + b,
          );
        } else {
          displayedEarnings = monthlyEarningsData[selectedMonth] ?? 0;
        }

        return Scaffold(
          backgroundColor: scaffoldBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Dashboard',
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              buildNotificationIconButton(context, isDark, textPrimary, () {
                setState(() {});
              }),
              GestureDetector(
                onTap: () => showAdminProfileModal(context),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E3148),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'AV',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Principal del Administrador
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: bannerBg,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -30,
                          top: -40,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    'RU',
                                    style: TextStyle(
                                      color: Color(0xFF2E3148),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'PANEL ADMINISTRADOR',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    Text(
                                      'RaízUrbana',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Hola, Adrian Villadiego',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Administrador · Resumen de hoy',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // INDICADORES CLAVE
                  const Text(
                    'INDICADORES CLAVE',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 12),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                    children: [
                      _buildMetricCard(
                        icon: Icons.shopping_bag_outlined,
                        trendText: '↑ +12% hoy',
                        trendColor: const Color(0xFF22C55E),
                        value: '\$9.200',
                        label: 'Ventas hoy',
                        cardBg: cardBg,
                        iconCircleBg: iconCircleBg,
                        textPrimary: textPrimary,
                      ),
                      _buildMetricCard(
                        icon: Icons.account_balance_wallet_outlined,
                        trendText: '↑ +9% mes',
                        trendColor: const Color(0xFF22C55E),
                        value: '\$48.250',
                        label: 'Ingresos totales',
                        cardBg: cardBg,
                        iconCircleBg: iconCircleBg,
                        textPrimary: textPrimary,
                      ),
                      _buildMetricCard(
                        icon: Icons.inventory_2_outlined,
                        trendText: '↓ 3 bajo stock',
                        trendColor: Colors.redAccent,
                        value: '54',
                        label: 'Productos',
                        cardBg: cardBg,
                        iconCircleBg: iconCircleBg,
                        textPrimary: textPrimary,
                      ),
                      _buildMetricCard(
                        icon: Icons.group_outlined,
                        trendText: '↑ Todos activos',
                        trendColor: const Color(0xFF22C55E),
                        value: '4',
                        label: 'Usuarios',
                        cardBg: cardBg,
                        iconCircleBg: iconCircleBg,
                        textPrimary: textPrimary,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 1. GRÁFICO CON FILTRO POR DÍA DE LA SEMANA
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ingresos vs Costos',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  selectedDay == 'Todos'
                                      ? 'Semana actual'
                                      : 'Filtro: $selectedDay',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            // Filtro de Día (Dropdown)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: iconCircleBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedDay,
                                  icon: Icon(
                                    Icons.filter_alt_outlined,
                                    size: 14,
                                    color: textPrimary,
                                  ),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                  dropdownColor: cardBg,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        selectedDay = newValue;
                                      });
                                    }
                                  },
                                  items: daysList.map((String day) {
                                    return DropdownMenuItem<String>(
                                      value: day,
                                      child: Text(day),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 110,
                          child: CustomPaint(
                            size: Size.infinite,
                            painter: IncomeCostsPainter(
                              incomeColor: chartLineColor,
                              costsColor: isDark
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400,
                              selectedDay: selectedDay,
                              data: weeklyData,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDayLabel('Lunes', 'L', textPrimary),
                            _buildDayLabel('Martes', 'M', textPrimary),
                            _buildDayLabel('Miércoles', 'X', textPrimary),
                            _buildDayLabel('Jueves', 'J', textPrimary),
                            _buildDayLabel('Viernes', 'V', textPrimary),
                            _buildDayLabel('Sábado', 'S', textPrimary),
                            _buildDayLabel('Domingo', 'D', textPrimary),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. GRÁFICO CON FILTRO POR MES
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ganancias mensuales',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  selectedMonth == 'Todos'
                                      ? 'Enero - Diciembre 2026'
                                      : 'Mes: $selectedMonth',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            // Filtro de Mes
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: iconCircleBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedMonth,
                                  icon: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 14,
                                    color: textPrimary,
                                  ),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                  dropdownColor: cardBg,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        selectedMonth = newValue;
                                      });
                                    }
                                  },
                                  items: monthsList.map((String month) {
                                    return DropdownMenuItem<String>(
                                      value: month,
                                      child: Text(month),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '\$${displayedEarnings.toStringAsFixed(1)}.000.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 120,
                          child: CustomPaint(
                            size: Size.infinite,
                            painter: MonthlyEarningsPainter(
                              lineColor: chartLineColor,
                              selectedMonth: selectedMonth,
                              earningsData: monthlyEarningsData,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDayLabel(String fullDay, String shortLabel, Color textPrimary) {
    final isSelected = selectedDay == fullDay;
    return Text(
      shortLabel,
      style: TextStyle(
        fontSize: 10,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? const Color(0xFF22C55E) : Colors.grey,
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String trendText,
    required Color trendColor,
    required String value,
    required String label,
    required Color cardBg,
    required Color iconCircleBg,
    required Color textPrimary,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: iconCircleBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: textPrimary),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      trendText,
                      style: TextStyle(
                        color: trendColor,
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Painter interactivo Ingresos vs Costos
class IncomeCostsPainter extends CustomPainter {
  final Color incomeColor;
  final Color costsColor;
  final String selectedDay;
  final Map<String, Map<String, double>> data;

  IncomeCostsPainter({
    required this.incomeColor,
    required this.costsColor,
    required this.selectedDay,
    required this.data,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final incomePaint = Paint()
      ..color = incomeColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final costsPaint = Paint()
      ..color = costsColor
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final highlightPaint = Paint()
      ..color = const Color(0xFF22C55E)
      ..style = PaintingStyle.fill;

    final days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];
    final incomePath = Path();
    final costsPath = Path();

    for (int i = 0; i < days.length; i++) {
      final x = (size.width / (days.length - 1)) * i;
      final dayData = data[days[i]]!;
      final yIncome = size.height * (1.0 - dayData['income']!);
      final yCosts = size.height * (1.0 - dayData['costs']!);

      if (i == 0) {
        incomePath.moveTo(x, yIncome);
        costsPath.moveTo(x, yCosts);
      } else {
        incomePath.lineTo(x, yIncome);
        costsPath.lineTo(x, yCosts);
      }

      // Si hay un día seleccionado, dibuja un indicador en el punto
      if (selectedDay == days[i]) {
        canvas.drawCircle(Offset(x, yIncome), 5, highlightPaint);
      }
    }

    canvas.drawPath(costsPath, costsPaint);
    canvas.drawPath(incomePath, incomePaint);
  }

  @override
  bool shouldRepaint(covariant IncomeCostsPainter oldDelegate) => true;
}

// Painter interactivo Ganancias Mensuales
class MonthlyEarningsPainter extends CustomPainter {
  final Color lineColor;
  final String selectedMonth;
  final Map<String, double> earningsData;

  MonthlyEarningsPainter({
    required this.lineColor,
    required this.selectedMonth,
    required this.earningsData,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = lineColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = selectedMonth == 'Todos' ? lineColor : const Color(0xFF22C55E)
      ..style = PaintingStyle.fill;

    final months = earningsData.keys.toList();
    final maxVal = 15.0; // Escala máxima

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < months.length; i++) {
      final x = (size.width / (months.length - 1)) * i;
      final val = earningsData[months[i]]!;
      final y = size.height * (1.0 - (val / maxVal));

      points.add(Offset(x, y));

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    for (int i = 0; i < months.length; i++) {
      if (selectedMonth == 'Todos' || selectedMonth == months[i]) {
        final radius = selectedMonth == months[i] ? 5.5 : 2.8;
        canvas.drawCircle(points[i], radius, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant MonthlyEarningsPainter oldDelegate) => true;
}
