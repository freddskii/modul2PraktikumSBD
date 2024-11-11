CREATE DATABASE bandaraHorizonAir

-- table
CREATE TABLE bagasi (
  id int,
  berat int,
  ukuran varchar(5),
  warna varchar(255),
  jenis varchar(255),
  PRIMARY KEY (id)
);

CREATE TABLE penumpang (
  NIK char(16),
  nama varchar(255),
  tanggalLahir date,
  alamat varchar(255),
  noTelepon varchar(13),
  jenisKelamin char(1),
  kewarganegaraan varchar(255),
  bagasiID int,
  PRIMARY KEY (NIK),
  FOREIGN KEY (bagasiID) REFERENCES bagasi (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bandara (
  id int,
  nama varchar(255),
  kota varchar(255),
  negara varchar(255),
  kodeIATA char(3),
  PRIMARY KEY (id)
);

CREATE TABLE maskapai (
id char(6), 
nama varchar(255),
negaraAsal varchar(255),
PRIMARY KEY (id)
);

CREATE TABLE pesawat (
  id char(6),
  model varchar(255),
  kapasitas int,
  tahunProduksi char(4),
  statusPesawat varchar(50),
  maskapaiID char(6),
  PRIMARY KEY (id),
  FOREIGN KEY (maskapaiID) REFERENCES maskapai(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE penerbangan (
  id char(6),
  waktuKeberangkatan datetime,
  waktuSampai datetime,
  statusPenerbangan varchar(50),
  pesawatID char(6),
  PRIMARY KEY (id),
  FOREIGN KEY (pesawatID) REFERENCES pesawat (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tiket(
  id char(6),
  nomorKursi char(3),
  harga int, 
  waktuPembelian datetime,
  kelasPenerbangan varchar(50),
  penumpangNIK char(16), 
  penerbanganID char(6),
  PRIMARY KEY (id),
  FOREIGN KEY (penumpangNIK) REFERENCES penumpang (NIK) ON UPDATE CASCADE ON DELETE CASCADE, 
  FOREIGN KEY (penerbanganID) REFERENCES penerbangan (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bandaraPenerbangan(
  bandaraID int,
  penerbanganID char(6),
  PRIMARY KEY (bandaraID, penerbanganID),
  FOREIGN KEY (bandaraID) REFERENCES bandara (id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (penerbanganID) REFERENCES penerbangan (id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- values
INSERT INTO bandara VALUE 
	(1, "Soekarno-Hatta", "Jakarta", "Indonesia", "CGK"),
	(2, "Ngurah Rai", "Denpasar", "Indonesia", "DPS"),
	(3, "Changi", "Singapore", "Singapore", "SIN"),
	(4, "Haneda", "Tokyo", "Japan", "HND");

INSERT INTO bagasi VALUE 
	(1, 20, "M", "Hitam", "Koper"),
	(2, 15, "S", "Merah", "Ransel"),
	(3, 25, "L", "Biru", "Koper"),
	(4, 10, "S", "Hijau", "Ransel");

INSERT INTO maskapai VALUE
	("GA123", "Garuda Indonesia", "Indonesia"),
	("SQ456", "Singapore Airlines", "Singapore"),
	("JL789", "Japan Airlines", "Japan"),
	("QZ987", "AirAsia", "Malaysia");

INSERT INTO penumpang VALUE
	(3201123456789012, "Budi Santoso", '1990-04-15', "Jl. Merdeka No.1", 081234567890, "L", "Indonesia", 1),
	(3302134567890123, "Siti Aminah", '1985-08-20', "Jl. Kebangsaan No.2", 081298765432, "P", "Indonesia", 2),
	(3403145678901234, "John Tanaka", '1993-12-05', "Shibuya, Tokyo", 080123456789, "L", "Japan", 3),
	(3504156789012345, "Li Wei", '1995-03-10', "Orchard Rd, Singapore", 0658123456789, "L", "Singapore", 4);

INSERT INTO pesawat  VALUE
	("PKABC1", "Boeing 737", 180, "2018", "Aktif", "GA123"),
	("PKDEF2", "Airbus A320", 150, "2020", "Aktif", "SQ456"),
	("PKGHI3", "Boeing", 250, "2019", "Dalam Perawatan", "JL789"),
	("PKJKL4", "Airbus A330", 280, "2021", "Aktif", "QZ987");

INSERT INTO penerbangan VALUE
	("FL0001", '2024-12-15 10:00:00', '2024-12-15 12:30:00', "Jadwal", "PKABC1"),
	("FL0002", '2024-12-16 08:00:00', '2024-12-16 10:45:00', "Jadwal", "PKDEF2"),
	("FL0003", '2024-12-17 14:00:00', '2024-12-17 16:30:00', "Ditunda", "PKGHI3"),
	("FL0004", '2024-12-18 18:00:00', '2024-12-18 20:30:00', "Jadwal", "PKJKL4");
	
INSERT INTO bandaraPenerbangan VALUES 
	(1, "FL0001"),
	(2, "FL0002"),
	(3, "FL0003"),
	(4, "FL0004");

INSERT INTO tiket VALUE
	("TIK001", "12A", 1200000, '2024-11-01 08:00:00', "Ekonomi", "3201123456789012", "FL0001"),
	("TIK002", "14B", 1500000, '2024-11-02 09:30:00', "Bisnis", "3302134567890123", "FL0002"),
	("TIK003", "16C", 2000000, '2024-11-03 10:15:00', "Ekonomi", "3403145678901234", "FL0003"),
	("TIK004", "18D", 1000000, '2024-11-04 11:45:00', "Ekonomi", "3504156789012345", "FL0004");

-- soal 1
ALTER TABLE penumpang
  ADD email varchar(255);
  
-- soal 2
ALTER TABLE bagasi
MODIFY COLUMN Jenis varchar(50);

-- soal 3 
ALTER TABLE bandara
DROP PRIMARY KEY,
ADD CONSTRAINT pkBandara PRIMARY KEY(id, kodeIATA);
  
-- soal 4
ALTER TABLE penumpang
DROP COLUMN email;

-- soal 5 
UPDATE penerbangan SET 
  waktuKeberangkatan = '2024-12-15 11:00:00',
  waktuSampai = '2024-12-15 13:30:00'
WHERE id = 'FL0001';

-- soal 6 
UPDATE penumpang SET
  noTelepon = 081223344556
WHERE NIK = 3302134567890123;

-- soal 7
UPDATE pesawat SET
  statusPesawat = 'Aktif'
WHERE id = 'PKGHI3';

-- soal 8 
DELETE FROM tiket WHERE
  penumpangNIK = 3504156789012345 and
  penerbanganID = 'FL0004';

-- soal 9 
DELETE FROM bagasi WHERE
  id = 2 and
  berat = 15 and
  ukuran = 's';
  
-- soal 10 
DELETE FROM penerbangan WHERE 
  statusPenerbangan = 'Ditunda';
  
  
