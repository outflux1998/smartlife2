import 'package:flutter/material.dart';
import 'package:smartlife/auth.dart';
import 'package:smartlife/pages/addmeal.dart';
import 'package:smartlife/pages/personal_info.dart';

class ReceiptDetailsPage extends StatefulWidget {
  const ReceiptDetailsPage({super.key, required this.selectedReceipted});

  final selectedReceipted;

  @override
  State<ReceiptDetailsPage> createState() => _ReceiptDetailsPageState();
}

class _ReceiptDetailsPageState extends State<ReceiptDetailsPage> {
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          'SMARTLIFE',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.energy_savings_leaf,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Logout'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: Container(
        //   color: Colors.white,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        //     child: GNav(
        //       gap: 8,
        //       backgroundColor: Colors.white,
        //       color: Colors.black,
        //       activeColor: Colors.green,
        //       tabBackgroundColor: Colors.grey.shade300,
        //       padding: const EdgeInsets.all(16),
        //       tabs: [
        //         const GButton(
        //           icon: Icons.home,
        //           text: 'Home',
        //         ),
        //         // GButton(
        //         //   icon: Icons.favorite_border,
        //         //   text: 'Dieta',
        //         // ),
        //         GButton(
        //           icon: Icons.person,
        //           text: 'Conta',
        //           onPressed: () {
        //             Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (_) => personal_info(),
        //               ),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => addmeal(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          title: _title(),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => personal_info(),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/fotos-gratis/foto-interna-de-uma-jovem-alegre-mulher-de-cabelos-escuros-mantendo-a-mao-levantada-sobre-o-peito-e-rindo-alegremente-com-os-olhos-fechados-isolada-sobre-uma-parede-azul_295783-11258.jpg?w=900&t=st=1664675420~exp=1664676020~hmac=ebc7b87a6407a4567e87db1bec85309777fa53503b28e8d8eca16b7889f1a570"),
                  ),
                ))
            // TextButton(onPressed: _signOutButton, child: _signOutButton())
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.selectedReceipted['image'],
                    )
                  ])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.selectedReceipted['name']}',
                          style: const TextStyle(
                              fontSize: 30,
                              fontFamily: 'Quicksand',
                              color: Color.fromRGBO(0, 33, 64, 1),
                              fontWeight: FontWeight.bold))
                    ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('KCAL',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          )),
                      Text('${widget.selectedReceipted['calories']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          )),
                    ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tempo',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          )),
                      Text('${widget.selectedReceipted['time']} MIN',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          )),
                    ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Preparo',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Quicksand',
                              color: Color.fromRGBO(0, 33, 64, 1),
                              fontWeight: FontWeight.w900)),
                      Text(
                        textAlign: TextAlign.justify,
                        '${widget.selectedReceipted['description']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ]),
              ),
            ]),
          ),
        ]));
  }
}
