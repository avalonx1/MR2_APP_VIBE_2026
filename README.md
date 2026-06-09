# ?? MR2 - Muamalat Report Reminder App (VIBE V2)

> **Internal Report Tracking & Reminder System - Bank Muamalat Indonesia**

MR2 (Muamalat Report Reminder) adalah aplikasi web internal Bank Muamalat untuk **melacak, mengelola, dan mengingatkan** pengumpulan laporan secara terpusat. Dibangun di atas platform **Java EE 7** dengan **PostgreSQL** dan didesain dengan antarmuka **Gentelella Bootstrap Admin Template**.

Aplikasi ini mencakup modul **Report Upload/Download**, **CRM Leads Management**, **User & Group Administration**, **Role-Based Access Control**, serta integrasi dengan **LDAP Active Directory**, **SFTP**, **IBM DataStage**, dan **Email Notification**.

---

## ? Fitur Utama

### ?? Dashboard & Reporting
- Dashboard status laporan - lihat laporan yang sudah/belum di-submit
- DataTables server-side processing dengan filter dan pencarian
- JSON-driven data untuk dashboard real-time
- Tracking popularitas laporan berdasarkan jumlah download

### ?? Upload & Download Laporan
- Upload file laporan (PDF, Excel, etc.) dengan metadata (bulan, jenis laporan, NIK, tanggal)
- Multiple upload servlets dengan validasi akses
- Download tracking dan audit log
- PDF-to-SWF conversion untuk viewing di browser
- Konfigurasi?? ukuran file (default: 50 MB)

### ?? Autentikasi & Keamanan
- **LDAP Active Directory** integration (server: `10.55.60.223:389`)
- **Non-LDAP fallback login** dengan MD5 password hash
- Session management dengan 30 menit timeout
- Duplicate login detection (cross-IP)
- IP-based access logging
- **Maintenance mode** dengan admin IP bypass

### ?? Manajemen Pengguna & Akses
- **User CRUD** - username, nama, email, role, group, divisi, employee ID, foto
- **Group Management** - group code, name, description, type
- **Group Access Matrix** - mapping grup ke permission
- **Division Management** - divisi organisasi
- **Level/Role Management** - user levels

### ?? CRM - Leads Management
- **5-Step Smart Wizard** untuk sales leads pipeline:
  1. **Unqualified** - Lead source selection
  2. **New** - Company, website, industry
  3. **Working** - Contact details (email, phone)
  4. **Nurturing** - Rating & qualification
  5. **Convert to Opportunity** - Assign account, product, campaign
- Mengelola data leads, opportunities, accounts, products, campaigns

### ?? Notifikasi & Email
- In-app notifications (maintenance messages, running text)
- Email untuk reset password dan reminder laporan
- Konfigurasi via shell script (`SENDMAIL_SCRIPT_FULLPATH`)

### ?? Integrasi Eksternal
- **IBM DataStage** - trigger job ETL via SSH
- **SFTP** - transfer file ke remote server (JSch library)
- **FTP** - upload via Apache Commons Net
- **LDAP** - autentikasi Active Directory

---

## ??? Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| **Frontend** | HTML5, CSS3, JavaScript, JSP 2.3 | - |
| **CSS Framework** | Bootstrap 3 + Gentelella Admin Theme | 3.x |
| **JavaScript Libraries** | jQuery, DataTables, PNotify, Select2, Chart.js, Flot, ECharts, Moment.js, FullCalendar, Parsley.js, Smart Wizard, dll. (ñ69 vendor packages) | - |
| **Backend** | Java Servlet 3.1, Java EE 7 Web Profile | Java 1.8 |
| **App Server** | GlassFish 4.x | Java EE 7 |
| **Database** | PostgreSQL | - |
| **Build Tool** | Apache Ant (via NetBeans IDE) | ò 1.6.5 |
| **IDE** | NetBeans | 8.x / 12.x |
| **Version Control** | Git + GitHub | - |

### ?? Dependencies (Backend JARs)

| Library | Purpose |
|---------|---------|
| `javaee-api-7.0.jar` | Java EE 7 API |
| `gson-2.2.2.jar` | JSON serialization/deserialization |
| `commons-fileupload-1.3.1/1.3.2.jar` | File upload handling |
| `commons-io-2.5.jar` | I/O utilities |
| `jsch-0.1.54.jar` | SSH/SFTP client |
| `commons-net-3.3-ftp.jar` | FTP client |
| `cos.jar` | Legacy multipart upload |
| `jakarta-regexp-1.5.jar` | Regular expression support |
| `apache-logging-log4j.jar` | Logging framework |
| `apache-commons-lang.jar` | Commons Lang utilities |
| PostgreSQL JDBC Driver | Database connectivity (via GlassFish) |

---

## ??? Struktur Proyek

```
MR2_VIBE_V2/
ÃÄÄ build.xml                     # Ant build script
ÃÄÄ .gitignore                    # Git ignore rules
ÃÄÄ build/                        # Build output (compiled classes, generated)
ÃÄÄ build_bkp/                    # Build backup
ÃÄÄ dist/                         # Distribution (WAR output)
ÃÄÄ jar/                          # Local JAR dependencies
ÃÄÄ nbproject/                    # NetBeans project config
³   ÃÄÄ project.properties        # Build properties
³   ÃÄÄ project.xml               # NetBeans project descriptor
³   ÀÄÄ private/                  # IDE user settings (gitignored)
ÃÄÄ setup/
³   ÀÄÄ sun-resources.xml         # GlassFish JDBC Connection Pool & JNDI config
ÃÄÄ src/
³   ÀÄÄ java/
³       ÃÄÄ Database/
³       ³   ÀÄÄ Database.java     # Core DB connection (JNDI lookup)
³       ÀÄÄ Engines/
³           ÃÄÄ auth.java         # Auth, params, maintenance, utilities
³           ÃÄÄ ldapActiveDirectory.java  # LDAP authentication
³           ÃÄÄ notification.java # In-app notifications
³           ÃÄÄ ReportTracking.java      # Report download tracking
³           ÃÄÄ sessioncounter.java      # Active session counter
³           ÃÄÄ UploadServlet.java       # Annotated file upload servlet
³           ÃÄÄ DownloadServlet.java     # Annotated file download servlet
³           ÀÄÄ ...                # Additional utility servlets
ÃÄÄ test/                         # Test sources
ÀÄÄ web/                          # Web application root
    ÃÄÄ index.jsp                 # Entry point / redirect
    ÃÄÄ WEB-INF/
    ³   ÃÄÄ web.xml               # Deployment descriptor (Servlet 3.1)
    ³   ÀÄÄ glassfish-web.xml     # GlassFish-specific config
    ÃÄÄ build/                    # Compiled CSS/JS (Gentelella)
    ÃÄÄ images/                   # Application images (logos, backgrounds)
    ÃÄÄ includes/                 # JSP includes (CSS, JS, auth layers)
    ÃÄÄ vendors/                  # 69 frontend vendor libraries
    ÀÄÄ views/
        ÃÄÄ index.jsp             # Main app shell (sidebar, topnav, footer)
        ÃÄÄ login.jsp             # LDAP login page
        ÃÄÄ login_nonldap.jsp     # Non-LDAP login fallback
        ÃÄÄ home.jsp              # Dashboard
        ÃÄÄ upload_list.jsp       # Upload list table
        ÃÄÄ maintenance.jsp       # Maintenance mode page
        ÃÄÄ forget_password.jsp   # Password reset
        ÀÄÄ module/               # Feature modules
            ÃÄÄ leads_list_wizard_main.jsp    # CRM Leads wizard
            ÃÄÄ json_dashboard/              # JSON data feeds
            ÃÄÄ user/                        # User management
            ÃÄÄ user_access/                 # User-group mapping
            ÃÄÄ group/                       # Group management
            ÃÄÄ group_access/                # Group permissions
            ÃÄÄ divisi/                      # Division management
            ÃÄÄ product/                     # Product management
            ÃÄÄ acc/                         # Account management
            ÀÄÄ upload/                      # Upload sub-pages
```

---

## ?? Prasyarat

- **JDK 8** (Java 1.8)
- **GlassFish 4.x** (Java EE 7 Web Profile)
- **PostgreSQL** (dengan database `rptrack`)
- **NetBeans IDE** (direkomendasikan 8.2 / 12.x+)
- **Apache Ant** ò 1.6.5 (built-in NetBeans)
- **Git** (untuk version control)

---

## ?? Setup & Instalasi

### 1. Clone Repository

```bash
git clone https://github.com/avalonx1/MR2_APP_VIBE_2026.git
cd MR2_APP_VIBE_2026
```

### 2. Setup Database (PostgreSQL)

Buat database dan jalankan script DDL:

```sql
CREATE DATABASE rptrack;
-- Jalankan script DDL dari tim database
```

### 3. Konfigurasi GlassFish

#### JDBC Connection Pool & JNDI Resource

Gunakan file `setup/sun-resources.xml` sebagai referensi, atau buat manual via Admin Console:

1. Buka **GlassFish Admin Console**  `http://localhost:4848`
2. **Resources  JDBC  Connection Pools  New**
   - Pool Name: `mr2_pool_dev`
   - Resource Type: `javax.sql.ConnectionPoolDataSource`
   - Datasource Class: `org.postgresql.ds.PGConnectionPoolDataSource`
   - Properties:
     - `serverName` = `10.55.108.49`
     - `portNumber` = `5432`
     - `databaseName` = `rptrack`
     - `user` = `rptrack`
     - `password` = `rptrack`
3. **Resources  JDBC  JDBC Resources  New**
   - JNDI Name: `MR2-APP`
   - Pool Name: `mr2_pool_dev`

> **Catatan:** Untuk production, ganti credentials dan host sesuai environment masing-masing.

### 4. Deploy Aplikasi

Via NetBeans:
- **Clean & Build**  klik kanan project  _Clean and Build_
- **Deploy**  klik kanan project  _Deploy_

Atau deploy WAR manual:
1. Build project  hasil WAR di `dist/MR2_VIBE_V2.war`
2. Buka GlassFish Admin Console  **Applications  Deploy**
3. Upload file WAR dan deploy

### 5. Akses Aplikasi

```
http://localhost:8080/MR2_VIBE_V2/
```

- **Login LDAP:** Gunakan credentials Active Directory Bank Muamalat
- **Login Non-LDAP:** Gunakan user yang terdaftar di database `t_user`

---

## ?? Konfigurasi Tambahan

### Parameter Aplikasi (`t_param` table)

| Parameter Key | Deskripsi |
|--------------|-----------|
| `DIR_FILE_UPLOAD` | Direktori penyimpanan file upload |
| `MAXSIZE_UPLOAD_MB` | Maksimum ukuran file upload (MB) |
| `FILE_FORMAT_UPLOAD` | Format file yang diizinkan |
| `DIR_FILE_DOWNLOAD` | Direktori file download |
| `SENDMAIL_SCRIPT_FULLPATH` | Path script sendmail |
| `RUNDSJOB_SCRIPT_*` | Path script DataStage job triggers |
| `msg_maintenance` | Pesan maintenance mode |

### Environment Variables / Paths (Hardcoded)

Beberapa path masih hardcoded di servlets:
- `D:\Adhoc_Muamalat_Briefcase\Upload_Form\uploadtest` - upload fallback
- `D:\MR2_2022\MR2_data\folder_uat_mr2` - UAT data folder
- External JAR references via `nbproject/project.properties`

---

## ?? Development

### Compile on Save
NetBeans "Compile on Save" diaktifkan untuk development cepat.

### JSP Keep Generated
`glassfish-web.xml` mengaktifkan `keepgenerated` untuk debugging JSP.

### Deploy on Save
Setiap perubahan file akan otomatis di-deploy ke GlassFish.

---

## ????? Kontribusi

1. Fork repository
2. Buat branch fitur: `git checkout -b feature/your-feature-name`
3. Commit perubahan: `git commit -m 'feat: add some feature'`
4. Push ke branch: `git push origin feature/your-feature-name`
5. Buat Pull Request

---

## ??? Versioning

Proyek ini menggunakan **Semantic Versioning 2.0.0**.

Versi saat ini: **VIBE V2** (Beta)

---

## ?? Known Issues

- Beberapa SQL query menggunakan string concatenation (rawan SQL injection - perlu refactor ke PreparedStatement)
- Terdapat beberapa varian servlet legacy (UploadFix, UploadFix2, DownloadFix, dll.) yang perlu dirapihkan
- Path file masih ada yang hardcoded dengan absolute path Windows
- Belum menggunakan framework ORM (JPA/Hibernate) - query ditulis manual

---

## ?? Lisensi

**Proprietary - Bank Muamalat Indonesia**

Aplikasi ini adalah aset internal Bank Muamalat. Tidak untuk didistribusikan ke pihak luar tanpa izin.

---

## ?? Tim Pengembang

Dikembangkan dan dikelola oleh **Divisi IT - Bank Muamalat Indonesia**.

---

*"Saya Rifa. Saya tahu semua angka dan pergerakan sebelum Bapak sempat menghitungnya."*
