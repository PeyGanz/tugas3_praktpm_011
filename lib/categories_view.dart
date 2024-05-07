import 'package:flutter/material.dart';
import 'package:tugas3/categories_model.dart';
import 'package:tugas3/load_data_sc.dart';
import 'package:tugas3/meals_view.dart';

class PageListCategories extends StatefulWidget {
  const PageListCategories({super.key});
  @override
  State<PageListCategories> createState() => _PageListCategoriesState();
}

class _PageListCategoriesState extends State<PageListCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MEAL CATEGORIES",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: _buildListCategoriesBody(),
    );
  }

  Widget _buildListCategoriesBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadCategories(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          // Jika data ada error maka akan ditampilkan hasil error
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
          CategoriesModel categoriesModel =
              CategoriesModel.fromJson(snapshot.data);
          return _buildSuccessSection(categoriesModel);
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

  Widget _buildSuccessSection(CategoriesModel categories) {
    return ListView.builder(
      itemCount: categories.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCategories(categories.categories![index]);
      },
    );
  }

  Widget _buildItemCategories(Categories categoriesData) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PageListMeals(category: categoriesData.strCategory!,),));
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
              width: 150,
              child: Image.network(categoriesData.strCategoryThumb!),
            ),
            Text(
              categoriesData.strCategory!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                categoriesData.strCategoryDescription!,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
