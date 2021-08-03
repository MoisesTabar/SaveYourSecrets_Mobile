import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_your_secrets/src/pages/detail_page.dart';
import 'package:save_your_secrets/src/providers/creation_form_provider.dart';
import 'package:save_your_secrets/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final creationProvider = Provider.of<CreationFormProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Save your secrets', 
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.grey[200],
          actions: [
            IconButton(
              iconSize: 30.5,
              onPressed: () async {
                await showDialog(
                  context: context, 
                  builder: (_) => Dialogs(
                    dialogTitle: 'Esta seguro?', 
                    dialogContent: 'Quiere borrar todos sus secretos?', 
                    dialogIcon: Icons.warning, 
                    dialogHeaderColor: Colors.amber.shade600,
                    buttonContent: 'Si!!',
                    onButtonPressed: () async { 
                      await creationProvider.deleteAllSecrets();
                      await showDialog(
                        context: context, 
                        builder: (_) => Dialogs(
                          dialogContent: 'Secretos borrados exitosamente', 
                          dialogHeaderColor: Colors.red, 
                          dialogIcon: Icons.delete, 
                          dialogTitle: 'Secretos borrados',
                          buttonContent: 'Volver',
                          onButtonPressed: () => Navigator.of(context).pop(),
                        ) 
                      );
                      Navigator.of(context).pop();
                    },
                  )
                );
              },
              icon: Icon(Icons.delete, color: Colors.black,)
            )
          ], 
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('secrets').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData) return Center(child: Text("No hay datos, registre un secreto por favor"));

                if(snapshot.connectionState == ConnectionState.waiting)
                  return LinearProgressIndicator(color: Colors.indigo);

                return Column(
                  children: snapshot.data!.docs.map((doc) => GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(
                        cod: doc["name"],
                        tituloDetalle: doc["name"], 
                        fechaDetalle: doc["date"], 
                        descripcionDetalle: doc["description"],
                        imageDetalle: doc["imageUrl"],
                        audioDetalle: doc["audioUrl"],
                      )
                    )),
                    child: SecretsList(
                      name: doc["name"], 
                      description: 'Fecha de creación: ${doc["date"]}' 
                    ),
                  )).toList(),
                );
              } 
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, 'creation'),
          backgroundColor: Colors.indigo.shade600,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}