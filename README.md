# tugas3

Tugas 3 https

## Alur Program

1. Tambahkan pada dependencies .yaml: http: ^0.13.4
2. Tambahkan permission pada AndoridManifest.xml (android/app/src/main) : <uses-permission android:name="android.permission.INTERNET" />
3. Membuat BaseNetwork untuk link request dari API
4. Membuat api data source sebagai controller untung masing-masing endpoint : loadCategories(), loadMeals(String category), loadDetails(String idmeal) 
5. Membuat model dengan bantuan https://tiendung01023.github.io/json_to_dart/ : CategoriesModel(), MealsModel(), DetailsModel()
6. Membuat Tampilan : PageListCategories, PageListMeals, PageDetails
7. Pada bagian detail terdapat launch URL, sehingga perlu : flutter pub add url_launcher

