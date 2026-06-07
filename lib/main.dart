import 'package:flutter/material.dart';
import 'mesajsayfasi.dart';

void main() {
 runApp(const MyApp());
}

// Uygulamamızın ana çatısıdır sadece gördüğümüz temel yapıları kulladım
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// Burasıda ana ekranımız sekme geçişlerini durum yönetimiyle yaptım
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Aktif sekmeyi tutan değişken (0: Sohbetler, 1: Aramalar)
  int _seciliSekme = 0;

  @override
  Widget build(BuildContext context) {
    // WhatsApp'ın yeşil tonları
    const Color whatsappYesili = Color(0xFF075E54);
    const Color whatsappAcikYesil = Color(0xFF128C7E);

    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text(
          'WhatsApp',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: whatsappYesili,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      //Drawer Yan Menü
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: whatsappYesili),
              accountName: Text('Benim Profilim', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('+90 555 123 45 67'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: whatsappYesili),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.key, color: whatsappAcikYesil),
              title: const Text('Hesap'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: whatsappAcikYesil),
              title: const Text('Sohbetler'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: whatsappAcikYesil),
              title: const Text('Bildirimler'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help, color: whatsappAcikYesil),
              title: const Text('Yardım'),
              onTap: () {},
            ),
          ],
        ),
      ),

      // Sekme seçimine göre farklı görünüm yaptım
      body: Column(
        children: [
          // Özel Sekme 
          Container(
            color: whatsappYesili,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _seciliSekme == 0 ? Colors.white : Colors.transparent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _seciliSekme = 0;
                        });
                      },
                      child: const Text(
                        'SOHBETLER',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _seciliSekme == 1 ? Colors.white : Colors.transparent,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _seciliSekme = 1;
                        });
                      },
                      child: const Text(
                        'ARAMALAR',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // İçerik Alanı
          Expanded(
            child: _seciliSekme == 0
                ? _sohbetlerListesi(context) // Sohbetler Sayfası
                : _aramalarListesi(),        // Aramalar Sayfası
          ),
        ],
      ),

      // Alt gezinti çubuğu
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF128C7E),
        unselectedItemColor: Colors.grey,
      
        onTap: (index) {
          setState(() {
            _seciliSekme = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Sohbetler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Aramalar',
          ),
        ],
      ),
    );
  }

  // sohbetler listesi
  Widget _sohbetlerListesi(BuildContext context) {
    final List<Map<String, String>> sohbetler = [
      {'isim': 'Efe akarsu', 'mesaj': 'Kanka Orduya ne zaman gidiyoruz', 'saat': '22:34', 'harf': 'B'},
      {'isim': 'Mami', 'mesaj': 'Kanka akşam dışarı çıkalım', 'saat': '18:12', 'harf': 'M'},
      {'isim': 'Musa', 'mesaj': 'Ödevimiz varmı kanka ', 'saat': '15:45', 'harf': 'M'},
      {'isim': 'Enes', 'mesaj': 'Yarın maç var kanka', 'saat': '12:30', 'harf': 'E'},
      {'isim': 'Buğra', 'mesaj': 'Yarın ders saat kaçta', 'saat': 'Dün', 'harf': 'B'},
      {'isim': 'Kadir', 'mesaj': 'Yarın tribünde pankart asılacak erken gel.', 'saat': 'Dün', 'harf': 'K'},
    ];

    return ListView.builder(
      itemCount: sohbetler.length,
      itemBuilder: (context, index) {
        final sohbet = sohbetler[index];
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF128C7E),
                child: Text(
                  sohbet['harf']!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                sohbet['isim']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                sohbet['mesaj']!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                sohbet['saat']!,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              onTap: () {
                // Navigator.push mesaj sayfasına çağrılıyo
             
              },
            ),
            const Divider(height: 1, indent: 70), //  İnce çizgidir
          ],
        );
      },
    );
  }

  // ARAMALAR LİSTESİ
  Widget _aramalarListesi() {
    final List<Map<String, dynamic>> aramalar = [
      {'isim': 'Efe AKARSU', 'zaman': 'Bugün, 14:22', 'gelen': true, 'kabul': true},
      {'isim': 'Mami', 'zaman': 'Dün, 19:40', 'gelen': false, 'kabul': true},
      {'isim': 'Dodo', 'zaman': '3 Haziran, 11:15', 'gelen': true, 'kabul': false},
      {'isim': 'Annem', 'zaman': '1 Haziran, 09:30', 'gelen': true, 'kabul': true},
    ];


    return ListView.builder(
      itemCount: aramalar.length,
      itemBuilder: (context, index) {
        final arama = aramalar[index];
        return Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                arama['isim'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  Icon(
                    arama['gelen'] ? Icons.call_received : Icons.call_made,
                    size: 16,
                    color: arama['kabul'] ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 5), // Stil: Boşluk kutusu
                  Text(arama['zaman']),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Color(0xFF075E54)),
                onPressed: () {},
              ),
            ),
            const Divider(height: 1, indent: 70),
          ],
        );
      },
    );
  }
}
//Bu uygulama mobil proglamlama dersi kapsamında geliştirilmiştir.