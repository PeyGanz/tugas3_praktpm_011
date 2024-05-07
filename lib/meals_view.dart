import 'package:flutter/material.dart';
import 'package:tugas3/details_view.dart';
import 'package:tugas3/load_data_sc.dart';
import 'package:tugas3/meals_model.dart';

class PageListMeals extends StatefulWidget {
  final String category;
  const PageListMeals({super.key, required this.category});

  @override
  State<PageListMeals> createState() => _PageListMealsState();
}

class _PageListMealsState extends State<PageListMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category.toUpperCase()} MEALS",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: _buildListMealsBody(),
    );
  }

  Widget _buildListMealsBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadMeals(widget.category),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          // Jika data ada error maka akan ditampilkan hasil error
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
          MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
          return _buildSuccessSection(mealsModel);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return const Text("Error");
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealsModel meals) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
      itemCount: meals.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemMeals(meals.meals![index]);
      },
    );
  }

  Widget _buildItemMeals(Meals mealsData) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetails(idmeal: mealsData.idMeal!),));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        borderOnForeground: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Image.network(mealsData.strMealThumb!),
            ),
            Text(
              mealsData.strMeal!,
              style: const TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
