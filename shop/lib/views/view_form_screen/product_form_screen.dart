import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products_list.dart';
import 'package:shop/utils/screen_size.dart';

class ProductFormScreen extends StatefulWidget {
  ProductFormScreen({Key key}) : super(key: key);

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  bool _isLoading = false;

  

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
    final  Product product = ModalRoute.of(context).settings.arguments as Product;
      if (product != null) {
        print(product.isFavorite);

        _formData["id"] = product.id;
        _formData["title"] = product.title;
        _formData["description"] = product.description;
        _formData["price"] = product.price;
        _formData["imageUrl"] = product.imageUrl;
      }
      // _imageUrlController.text =
      //     "https://basmar.com.br/image/cache/data/doces%20típicos%20junina/30328_Detalhes-800x800.jpg";
      _imageUrlController.text = _formData["imageUrl"];
    }
    // print(_formData["price"]);
  }

  void _updateImageUrl() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool starValidProtocolHttp = url.toLowerCase().startsWith("http://");
    bool starValidProtocolHttps = url.toLowerCase().startsWith("https://");
    bool endValidProtocolPng = url.toLowerCase().endsWith(".png");
    bool endValidProtocolJpg = url.toLowerCase().endsWith(".jpg");
    bool endValidProtocolJpeg = url.toLowerCase().endsWith(".jpeg");

    return (starValidProtocolHttp || starValidProtocolHttps) &&
        (endValidProtocolJpeg || endValidProtocolPng || endValidProtocolJpg);
  }

  void _saveForm() {
    var isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    _form.currentState.save();
    final newProduct = Product(
      id: _formData["id"],
      title: _formData["title"],
      description: _formData["description"],
      price: _formData["price"],
      imageUrl: _formData["imageUrl"],
    );
    print(newProduct.isFavorite);

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Products>(context, listen: false);
    if (_formData["id"] == null) {
      products
          .addProduct(newProduct)
          .then((value) => Navigator.of(context).pop())
          .catchError(
        (error) {
          return showDialog<Null>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Ocorreu um error!"),
              content:
                  Text("Ops... Houve um probleminha em salvar seu produto!"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Entendido!"))
              ],
            ),
          );
        },
      ).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      products
          .updateProduct(newProduct)
          .then((value) => Navigator.of(context).pop())
          .catchError(
        (error) {
          return showDialog<Null>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Ocorreu um error!"),
              content:
                  Text("Ops... Houve um probleminha em salvar seu produto!"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Entendido!"))
              ],
            ),
          );
        },
      ).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);

    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(screenHeight(context));
    // print(screenWidth(context));
    // print((screenHeight(context) + screenHeight(context)) * 0.007);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Novo Item"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(
                (screenHeight(context) + screenHeight(context)) * 0.007,
              ),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData["title"],
                      decoration: InputDecoration(
                        labelText: "Titulo",
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(
                          _priceFocusNode,
                        );
                      },
                      onSaved: (value) => _formData["title"] = value,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Informe um titulo";
                        }
                        return null;
                      },
                    ),
                    //
                    //
                    TextFormField(
                      initialValue: (_formData["price"] == null
                          ? ""
                          : _formData["price"].toString()),
                      decoration: InputDecoration(
                        labelText: "Preço",
                      ),
                      focusNode: _priceFocusNode,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(
                          _descriptionFocusNode,
                        );
                      },
                      onSaved: (value) =>
                          _formData["price"] = double.parse(value),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        var newPrice = double.tryParse(value);
                        bool isInvalid = newPrice == null || newPrice <= 0;

                        if (isEmpty || isInvalid) {
                          return "Informe um Preço válido";
                        }
                        return null;
                      },
                    ),
                    //
                    //
                    TextFormField(
                      initialValue: _formData["description"],
                      decoration: InputDecoration(labelText: "Descrição"),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) => _formData["description"] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = value.trim().length < 10;

                        if (isEmpty) {
                          return "Informe uma descrição válida";
                        }
                        if (isInvalid) {
                          return "Informe uma descrição com 10 ou mais caracteres";
                        }
                        return null;
                      },
                    ),
                    //
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: "URL da Imagem"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocusNode,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) => _formData["imageUrl"] = value,
                            validator: (value) {
                              bool emptyUrl = value.trim().isEmpty;
                              bool invalidUrl = !isValidImageUrl(value);
                              if (emptyUrl || invalidUrl) {
                                return "Informe um URL válida";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenHeight(context) * 0.042,
                              left: screenWidth(context) * 0.042),
                          height: screenHeight(context) * 0.1,
                          width: screenWidth(context) * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: _imageUrlController.text.isEmpty
                                ? Text("Informe a URL")
                                : Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                    semanticLabel: _imageUrlController.text,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return loadingProgress == null
                                          ? child
                                          : FittedBox(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("Carregando..."),
                                                  Divider(),
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ],
                                              ),
                                            );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
