import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'favorites.dart';

class NumberDetailsPage extends StatefulWidget {
  const NumberDetailsPage(this.number, {Key? key}) : super(key: key);

  final int number;

  @override
  State<NumberDetailsPage> createState() => _NumberDetailsPageState();
}

class _NumberDetailsPageState extends State<NumberDetailsPage> {
  String? _fact;

  @override
  void initState() {
    super.initState();
    _fetchFact();
  }

  void _fetchFact() async {
    final url = Uri.parse('http://numbersapi.com/${widget.number}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(_fact);
      setState(() {
        _fact = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<Favorites>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Facts about ${widget.number}')),
      body: Center(
        child: Column(
          children: [
            Text('${widget.number}', style: TextStyle(fontSize: 300)),
            Text(
              _fact ?? 'Loading…',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            if (_fact != null)
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: _fetchFact,
                    child: Text("New fact"),
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(
                      favorites.facts.contains(_fact)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      setState(() {
                        favorites.toggle(_fact!);
                      });
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
