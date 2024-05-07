import 'package:flutter/material.dart';
import 'package:tugas3/details_model.dart';
import 'package:tugas3/load_data_sc.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDetails extends StatefulWidget {
  final String idmeal;
  const PageDetails({super.key, required this.idmeal});

  @override
  State<PageDetails> createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MEAL DETAIL",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: _buildDetailsMealBody(),
    );
  }

  Widget _buildDetailsMealBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadDetails(widget.idmeal),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          // Jika data ada error maka akan ditampilkan hasil error
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
          DetailsModel detailsModel = DetailsModel.fromJson(snapshot.data);
          return _buildSuccessSection(detailsModel);
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

  Widget _buildSuccessSection(DetailsModel detailsmeal) {
    return ListView.builder(
      itemCount: detailsmeal.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildDetailsMeals(detailsmeal.meals![index]);
      },
    );
  }

  Widget _buildDetailsMeals(Meals detailsData) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              child: Image.network(detailsData.strMealThumb!),
            ),
          ),
          Center(
            child: Text(
              detailsData.strMeal!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Category: ${detailsData.strCategory!}"),
              Text("Area: ${detailsData.strArea}"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Ingredients",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(detailsData.strIngredient1!),
          Text(detailsData.strIngredient2!),
          Text(detailsData.strIngredient3!),
          Text(detailsData.strIngredient4!),
          Text(detailsData.strIngredient5!),
          Text(detailsData.strIngredient6!),
          Text(detailsData.strIngredient7!),
          Text(detailsData.strIngredient8!),
          Text(detailsData.strIngredient9!),
          Text(detailsData.strIngredient10!),
          SizedBox(
            height: 20,
          ),
          Text(
            "Instructions",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            detailsData.strInstructions!,
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                launchURL(detailsData.strYoutube!);
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.brown,
                  minimumSize: Size(double.infinity, 0),
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_circle), // Ikon
                  SizedBox(width: 8), // Jarak antara ikon dan teks
                  Text("Watch Tutorial"), // Teks
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Fungsi untuk masuk ke URL
Future<void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw "Couldn't launch url";
  }
}
