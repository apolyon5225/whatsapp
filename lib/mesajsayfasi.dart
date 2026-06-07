import 'package:flutter/material.dart';

// Sohbet detay ekranı
class ChatDetailScreen extends StatefulWidget {
  final String kisiIsmi;

  const ChatDetailScreen({super.key, required this.kisiIsmi});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
    final TextEditingController _mesajDenetleyici = TextEditingController();
  final List<Map<String, dynamic>> _mesajlar = [
    {'metin': 'Selam kanka ödev ne durumda?', 'gonderenBenim': false, 'saat': '14:30'},
    {'metin': 'Valla kanka başladım flutter ile yazmaya.', 'gonderenBenim': true, 'saat': '14:32'},
    {'metin': 'Sadece gördüğümüz temel widgetları kullanıyorum ha.', 'gonderenBenim': true, 'saat': '14:32'},
    {'metin': 'Harika, hoca çakmasın başka yerden aldığımızı :D', 'gonderenBenim': false, 'saat': '14:35'},
  ];

  @override
  void dispose() {
    // Bellek sızıntısını önlemek için temizliyoruz.
    _mesajDenetleyici.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color whatsappYesili = Color(0xFF075E54);
    const Color sohbetArkaPlani = Color(0xFFECE5DD); // beyaz rengi arka plan

    return Scaffold(
      backgroundColor: sohbetArkaPlani,
      // AppBar
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: whatsappYesili, size: 24),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.kisiIsmi,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: whatsappYesili,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam), 
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call), 
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert), 
            onPressed: () {},
          ),
        ],
      ),

      // Column ile mesaj alanını ve alttaki yazma alanını dikeyde hizalıyo
      body: Column(
        children: [
          // Mesajların listelendiği alandır
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _mesajlar.length,
              itemBuilder: (context, index) {
                final mesaj = _mesajlar[index];
                final bool benGonderdim = mesaj['gonderenBenim'];

                return Align(
                  alignment: benGonderdim ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    // Stil: Padding ve Container dekorasyonları
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: benGonderdim ? const Color(0xFFDCF8C6) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: benGonderdim ? const Radius.circular(12) : const Radius.circular(0),
                        bottomRight: benGonderdim ? const Radius.circular(0) : const Radius.circular(12),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 1),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          mesaj['metin'] ?? '',
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          mesaj['saat'] ?? '',
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          //  mesaj yazma ve gönderme alanıdır
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.insert_emoticon, color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _mesajDenetleyici,
                            decoration: const InputDecoration(
                              hintText: 'Mesaj yazın...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Icon(Icons.attach_file, color: Colors.grey),
                        const SizedBox(width: 10),
                        const Icon(Icons.camera_alt, color: Colors.grey),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                //Gönder butonu yeşil yuvarlak olan
                ElevatedButton(
                  onPressed: () {
                    if (_mesajDenetleyici.text.trim().isNotEmpty) {
                      setState(() {
                        _mesajlar.add({
                          'metin': _mesajDenetleyici.text,
                          'gonderenBenim': true,
                          'saat': 'Şimdi',
                        });
                        _mesajDenetleyici.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: whatsappYesili,
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}