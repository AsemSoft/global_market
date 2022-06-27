
//Widget _buildBody(BuildContext context) {return StreamBuilder<QuerySnapshot>(stream: databaseReference.collection('collectionPath').snapshots(), builder: (context, snapshot) {if (!snapshot.hasData) return LinearProgressIndicator(backgroundColor: Colors.black);return _buildList(context, snapshot.data.docs);});}
// Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {return ListView(padding: const EdgeInsets.only(top: 20), children: snapshot.map((data) => _buildListItem(context, data)).toList(),);}
//Widget _buildListItem(BuildContext context, DocumentSnapshot data) {final record = Record.fromSnapshot(data);return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), key: ValueKey(record.location), child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent),borderRadius: BorderRadius.circular(5)), child: ListTile(title: Column(children: <Widget>[Padding(padding: const EdgeInsets.all(10), child: Text(record.location,),), Image.network(record.url),],),),),);}
//Future<void> _upLoadingImageToFirebase(File image) async {try {int randNum = Random().nextInt(100000);String imageLocation = 'images/image${randNum}.jpg';final Reference ref = FirebaseStorage.instance.ref().child(imageLocation);final UploadTask uploadTask = ref.putFile(image);await uploadTask.whenComplete(() => null);_addPathToDatabase(imageLocation);} catch (e) {print(e.message);}}
//Future<void> _addPathToDatabase(String text) async {try { final ref = FirebaseStorage.instance.ref().child(text);var imageString = await ref.getDownloadURL();await databaseReference.collection('collectionPath').doc().set({'url': imageString, 'location': text});} catch (e) {print(e.message);showDialog(context: context, builder: (context) {return AlertDialog(content: Text(e.message),);});}}
//class Record {final String location;final String url;final DocumentReference reference;Record.fromMap(Map<String, dynamic> map, {this.reference}): assert(map['location'] != null), assert(map['url'] != null), location = (map['location']), url = map['url'];Record.fromSnapshot(DocumentSnapshot snapshot): this.fromMap(snapshot.data(), reference: snapshot.reference);@override String toString() => "Record<$location:$url>";}

//flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
//flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys