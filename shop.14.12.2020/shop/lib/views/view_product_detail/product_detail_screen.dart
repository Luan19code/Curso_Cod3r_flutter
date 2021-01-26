import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          product.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "R\$ ${product.price}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Container(
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(CounterProvider.of(context).state.value.toString()),
//             RaisedButton(
//               child: Text("+"),
//               onPressed: () {
//                 setState(() {
//                   CounterProvider.of(context).state.inc();
//                 });

//                 print(CounterProvider.of(context).state.value);
//               },
//             )
//           ],
//         ),
//       ),
