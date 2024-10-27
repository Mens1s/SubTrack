import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/budgets_row.dart';
import 'package:trackizer/common_widget/custom_arc_180_painter.dart';
import 'package:trackizer/entities/Categories.dart';
import 'package:trackizer/generated//l10n.dart';
import 'package:trackizer/services/CategoriesService.dart';
import 'package:trackizer/view/package/category_add_view.dart';

class SpendingBudgetsView extends StatefulWidget {
  const SpendingBudgetsView({super.key});

  @override
  State<SpendingBudgetsView> createState() => _SpendingBudgetsViewState();
}

class CustomDialog extends StatelessWidget {
  CustomDialog({Key? key}) : super(key: key);

  final TextEditingController txtCategoryName = TextEditingController();
  final TextEditingController txtBudget = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: TColor.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).add_new_category,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtCategoryName,
              decoration: InputDecoration(
                labelText: S.of(context).category,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtBudget,
              decoration: InputDecoration(
                labelText: "Limit",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number, // Sayı girişi için
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String categoryName = txtCategoryName.text.trim();
                String budgetText = txtBudget.text.trim();

                // Bütçenin geçerli bir double değer olup olmadığını kontrol et
                double? budget = double.tryParse(budgetText);

                // Hata kontrolleri
                if (categoryName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).field_not_null),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (budget == null || budget <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text(S.of(context).budget_not_fit),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Kategori servisi örneği oluştur
                var categoryService = CategoriesService();

                // Kategori nesnesini oluştur
                Categories newCategory = Categories(
                  id: 1, // Gerekirse dinamik bir ID yönetimi ekleyebilirsiniz
                  name: categoryName,
                  icon: "",
                  budget: budget,
                  inUseBudget: 0,
                  color: Colors.white,
                    lastUpdatedTime: DateTime.now()
                );


                // Kategoriyi ekleme işlemi
                await categoryService.addCategories(newCategory);

                // Başarılı bir şekilde eklendiğinde kullanıcıya bildirim yap
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).success),
                    backgroundColor: Colors.green,
                  ),
                );

                // Dialog'u kapatma
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).save),
            ),
          ],
        ),
      ),
    );
  }
}


class _SpendingBudgetsViewState extends State<SpendingBudgetsView> {

  double usedBudget = 0;
  double totalBudget = 0;
  List<ArcValueModel> arcValueModelList = [];

  List<Categories> categoryList = [];
  Future<void> _getCategories() async {
    final categoryService = CategoriesService();
    List<ArcValueModel> tempArcValueModelList = [];


    // Fetch credit cards
    List<Categories> cats = await categoryService.getCategoriess();

    // Update the state with the fetched cards
    setState(() {
      categoryList = cats; // Assign the fetched cards to the list
    });

    for(var c in cats){
      setState(() {

        usedBudget += c.inUseBudget; // Assign the fetched cards to the list
        totalBudget += c.budget; // Assign the fetched cards to the list
      });
    }
    var tempVal = 190.0;
    for(var c in cats){
      tempVal = c.inUseBudget/totalBudget * 100;
      if(tempVal > 190){
        tempVal = 190;
      }
      tempArcValueModelList.add(ArcValueModel(color: c.color, value: tempVal));
    }

    setState(() {
      arcValueModelList = tempArcValueModelList;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories(); // Call the initialization method
  }
  List bs = [
    {
      "name": "Auto & Transport",
      "icon": "assets/img/auto_&_transport.png",
      "spend_amount": "25.99",
      "total_budget": "400",
      "left_amount": "374.01",
      "color": TColor.secondaryG
    },
    {
      "name": "Entertainment",
      "icon": "assets/img/entertainment.png",
      "spend_amount": "50.99",
      "total_budget": "600",
      "left_amount": "549.01",
      "color": TColor.secondary50
    },
    {
      "name": "Security",
      "icon": "assets/img/security.png",
      "spend_amount": "5.99",
      "total_budget": "600",
      "left_amount": "594.01",
      "color": TColor.primary10
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 64),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: media.width * 0.5,
                  height: media.width * 0.3,
                  child: CustomPaint(
                    painter: CustomArc180Painter(
                      drwArcs: arcValueModelList,
                      end: 50,
                      width: 12,
                      bgWidth: 8,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "${S.of(context).currency} $usedBudget",
                      style: TextStyle(
                        color: TColor.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "/ ${S.of(context).currency} $totalBudget " + S.of(context).budget,
                      style: TextStyle(
                        color: TColor.gray30,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.border.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).y_budget_on_tack + " 👍",
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                var bObj = categoryList[index] as Categories? ?? Categories(id: 1, name: "name", icon: "", color: Colors.white, budget: 1, inUseBudget: 1,lastUpdatedTime: DateTime.now());
                return BudgetsRow(category: bObj, onPressed: () {});
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CategoryAddView()
                  );
                },
                child: DottedBorder(
                  dashPattern: const [5, 4],
                  strokeWidth: 1,
                  radius: const Radius.circular(16),
                  borderType: BorderType.RRect,
                  color: TColor.border.withOpacity(0.1),
                  child: Container(
                    height: 64,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).add_new_category,
                          style: TextStyle(
                            color: TColor.gray30,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          "assets/img/add.png",
                          width: 12,
                          height: 12,
                          color: TColor.gray30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }
}
