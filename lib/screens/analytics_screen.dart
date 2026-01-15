import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/money_provider.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  // Color map for categories
  final Map<String, Color> _categoryColors = {
    'Food': const Color(0xFFFF6B6B),
    'Transport': const Color(0xFF4ECDC4),
    'Shopping': const Color(0xFFFFE66D),
    'Entertainment': const Color(0xFF95E1D3),
    'Bills': const Color(0xFFC7CEEA),
    'Salary': const Color(0xFF90EE90),
    'Freelance': const Color(0xFF87CEEB),
    'Gift': const Color(0xFFDDA0DD),
  };

  Color _getColorForCategory(String category) {
    return _categoryColors[category] ?? const Color(0xFFB19CD9);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoneyProvider>(
      builder: (context, moneyProvider, child) {
        final expensesByCategory = moneyProvider.getExpensesByCategory();
        final totalExpenses = moneyProvider.totalExpenses;

        if (expensesByCategory.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pie_chart,
                  size: 64,
                  color: Colors.white30,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No expense data yet',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        // Prepare pie chart sections
        final List<PieChartSectionData> sections = [];
        expensesByCategory.forEach((category, amount) {
          final percentage = (amount / totalExpenses * 100);
          sections.add(
            PieChartSectionData(
              value: amount,
              title: '${percentage.toStringAsFixed(1)}%',
              color: _getColorForCategory(category),
              radius: 100,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          );
        });

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Expense Breakdown',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: R${totalExpenses.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),

                // Pie Chart
                Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        centerSpaceRadius: 0,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Legend
                const Text(
                  'Category Breakdown',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: expensesByCategory.length,
                  itemBuilder: (context, index) {
                    final category =
                        expensesByCategory.keys.toList()[index];
                    final amount = expensesByCategory[category]!;
                    final percentage = (amount / totalExpenses * 100);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: _getColorForCategory(category),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'R${amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Text(
                                '${percentage.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
