import 'package:flutter/material.dart';
import '../../services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {

  final namaController =
      TextEditingController();

  final hpController =
      TextEditingController();

  final alamatController =
      TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {

    final profile =
        await ProfileService().getProfile();

    if (profile != null) {

      namaController.text =
          profile['nama_lengkap'] ?? '';

      hpController.text =
          profile['no_hp'] ?? '';

      alamatController.text =
          profile['alamat'] ?? '';
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> simpan() async {

    await ProfileService().saveProfile(
      nama: namaController.text,
      hp: hpController.text,
      alamat: alamatController.text,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Profile berhasil disimpan",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF6F7FB),

      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : SingleChildScrollView(

              child: Column(
                children: [

                  // HEADER
                  Container(

                    width: double.infinity,
                    height: 260,

                    decoration:
                        const BoxDecoration(

                      gradient:
                          LinearGradient(

                        colors: [
                          Color(0xff5EDAE5),
                          Color(0xff34C8D6),
                        ],

                        begin:
                            Alignment.topLeft,

                        end:
                            Alignment.bottomRight,
                      ),

                      borderRadius:
                          BorderRadius.only(

                        bottomLeft:
                            Radius.circular(
                          35,
                        ),

                        bottomRight:
                            Radius.circular(
                          35,
                        ),
                      ),
                    ),

                    child: SafeArea(
                      child: Column(

                        children: [

                          const SizedBox(
                            height: 20,
                          ),

                          const Text(
                            "My Profile",
                            style: TextStyle(
                              color:
                                  Colors.white,
                              fontSize: 24,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Container(
                            padding:
                                const EdgeInsets.all(
                              4,
                            ),

                            decoration:
                                BoxDecoration(
                              shape:
                                  BoxShape.circle,
                              border:
                                  Border.all(
                                color:
                                    Colors.white,
                                width: 3,
                              ),
                            ),

                            child:
                                const CircleAvatar(
                              radius: 55,
                              backgroundColor:
                                  Colors.white,

                              child: Icon(
                                Icons.person,
                                size: 60,
                                color:
                                    Color(
                                  0xff5EDAE5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Transform.translate(
                    offset:
                        const Offset(0, -25),

                    child: Container(

                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),

                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      decoration:
                          BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          25,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withValues(
                              alpha: 0.08,
                            ),
                            blurRadius:
                                15,
                          ),
                        ],
                      ),

                      child: Column(
                        children: [

                          buildField(
                            "Nama Lengkap",
                            Icons.person,
                            namaController,
                          ),

                          const SizedBox(
                              height: 15),

                          buildField(
                            "Nomor HP",
                            Icons.phone,
                            hpController,
                          ),

                          const SizedBox(
                              height: 15),

                          buildField(
                            "Alamat",
                            Icons.location_on,
                            alamatController,
                            maxLines: 3,
                          ),

                          const SizedBox(
                              height: 25),

                          SizedBox(
                            width:
                                double.infinity,
                            height: 55,

                            child:
                                ElevatedButton(

                              style:
                                  ElevatedButton.styleFrom(

                                backgroundColor:
                                    const Color(
                                  0xff5EDAE5,
                                ),

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                ),
                              ),
                            
                              onPressed:
                                  simpan,

                              child:
                                  const Text(
                                "Simpan Profile",
                                style:
                                    TextStyle(
                                  color:
                                      Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize:
                                      16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }


  Widget buildField(
    String label,
    IconData icon,
    TextEditingController controller, {
    int maxLines = 1,
  }) {

    return TextField(

      controller: controller,

      maxLines: maxLines,

      decoration: InputDecoration(

        labelText: label,

        prefixIcon: Icon(
          icon,
          color:
              const Color(0xff5EDAE5),
        ),

        filled: true,

        fillColor:
            const Color(0xffF6F7FB),

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}