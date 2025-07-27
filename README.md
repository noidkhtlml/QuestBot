# Questbot

## Introducere

Aplicația **Questbot** este o platformă educațională dezvoltată pentru laptop, destinată atât elevilor, cât și părinților, cu scopul de a sprijini învățarea interactivă și monitorizarea progresului.

Aceasta oferă lecții din domenii variate precum **neuroștiință**, **electronică**, **inteligență artificială** și **astronomie**, explicate într-un mod accesibil și însoțite de întrebări la finalul fiecărui modul, pentru a consolida cunoștințele.

Elevii beneficiază de un **chatbot AI integrat**, care răspunde la întrebări și oferă suport pe parcursul lecțiilor, iar părinții au la dispoziție un panou cu **statistici** privind activitatea și progresul copilului.

---

## Arhitectură

Aplicația este dezvoltată în **Flutter** și rulează pe sistemele de operare desktop (**Windows/Linux/macOS**). Arhitectura urmează un model **client-cloud**, în care aplicația rulează local, iar datele sunt gestionate în timp real prin **Firebase**.

### Componentele principale:

#### Client (Flutter Desktop App):
- Rulează local pe laptop
- Interfață grafică + logică de interacțiune
- Comunică cu Firebase prin pachetele oficiale

#### Firebase Firestore:
- Bază de date NoSQL în cloud
- Documente JSON în colecții

#### Firebase Authentication:
- Autentificare prin email/parolă sau Google

#### Firebase Storage:
- Utilizat pentru fișiere (imagini, documente etc.)

### Flux de date:

```
[Utilizator pe laptop]
        ↓
[Aplicație Flutter Desktop]
        ↓↑
[Firebase Firestore / Auth / Storage (cloud)]
```

---

## Modul de utilizare

### Pornirea aplicației:
- După instalare, deschideți aplicația executabilă pe laptop.
- Este necesară conexiune la internet pentru sincronizarea cu Firebase.

### Autentificare:
Utilizatorii se pot conecta cu unul dintre tipurile de cont:

- **Cont elev**: acces la lecții, chatbot AI, evaluări.
- **Cont părinte**: acces la statistici privind progresul copilului.

---

### Pentru elevi:
- Acces la lecții din: neuroștiință, electronică, AI, astronomie.
- Lecții cu conținut multimedia și explicații detaliate.
- Întrebări la finalul fiecărei lecții.
- Acces la chatbot AI pentru suport.

### Pentru părinți:
- Statistici detaliate despre progresul copilului.
- Scoruri, activitate și rapoarte actualizate în timp real.

---

## Funcționalități suplimentare:
- Sincronizare automată între client și Firebase.
- Acces la cele mai recente date.

---

## Structura codului

Proiectul este organizat modular pentru mentenanță și scalabilitate.

### Descrierea directorilor principali:

#### `lib/models/`
- `Lectie.dart`: model pentru lecții.

#### `lib/pages/`
- `ai.dart`, `astronomie.dart`, `chatbot.dart`, `electronica.dart`, `home_page.dart`, `home_screen.dart`, `istoric.dart`, `login_page.dart`, `neurostiinte.dart`, `signup_page.dart`, `statistici.dart`

#### `lib/utils/`
- `auth_service.dart`: autentificare
- `chat_service.dart`: funcționalitate chat
- `chenare.dart`: componente UI
- `firebase_options.dart`: config Firebase
- `json.dart`: utilitare JSON
- `main_layout.dart`: layout aplicație
- `route_change.dart`: navigare

#### `lib/widgets/`
- Widget-uri UI reutilizabile

#### Fișiere în `lib/`:
- `main.dart`: punctul de intrare
- `firebase_options.dart`: configurație Firebase

---

## Tehnologii folosite

- **Flutter** – interfață multiplatformă
- **Firebase** – backend cloud: baze de date, autentificare, sincronizare
- **JSON** – schimb de date
- **Canva** – elemente grafice UI

---

## Testarea aplicației

### Testare manuală:

#### Scenarii testate:
- Autentificare și conturi
- Navigare în lecții și multimedia
- Evaluări finale
- Chatbot AI
- Statistici părinte
- Sincronizare cu Firebase

Testarea a confirmat funcționalitatea completă, cu probleme minore corectate.

---

## Roadmap

- ✅ Sisteme de recompense pentru elevi  
- ✅ Sistem de feedback  
- ✅ Întrebări cu niveluri de dificultate  
- ✅ Conturi pentru profesori  
- ✅ Domenii noi: genetică, chimie, matematică  

---

## Changelog

### v1 (20.05.2025)
- ✅ Lecții completate pentru electronică
- ✅ Întrebări grilă
- ✅ Chatbot integrat
- ✅ Bară de meniu

### v1.5 (7.06.2025)
- ✅ Bază de date pentru autentificare
- ✅ Lecții completate pentru AI, astronomie, electronică
- ✅ Grile complete
- 🔧 Pagini login + homepage redesign
- 🔧 Cont părinte
- 🛠️ Firebase storage implementat

### v2 (15.07.2025)
- ✅ Statistici elev
- ✅ Explicații pentru întrebări
- 🔧 Rescris în Dart
- 🔧 Redesign chatbot
- 🛠️ Conexiune Firebase stabilizată

---

## Flux de lucru

1. **Planificare** – domenii lecții, funcționalități (chatbot, statistici, evaluare)
2. **Design UI** – machete în Canva
3. **Dezvoltare** – Flutter + Firebase
4. **Testare** – manuală, pe mai multe rezoluții

---

## Colaborarea în echipă

- 🔧 Dezvoltare: Flutter, Firebase
- 🎨 Design: Canva
- 📝 Documentație: Google Docs
- 💬 Comunicare: WhatsApp, Discord

---

## Instrumente folosite

### Dezvoltare
- **Flutter**, **Dart**
- **Firebase**
- **IntelliJ IDEA**

### Design
- **Canva**

### Testare
- **Manuală**

### Organizare
- **Google Docs**
- **WhatsApp / Discord / Instagram**

### AI
- **ChatGPT** – traduceri, explicații

---

## Resurse educaționale utilizate

- 📘 [Fundamental Neuroscience (2008)](https://www.hse.ru/data/2013/10/09/1280379806/Fundamental%20Neuroscience%20(3rd%20edition)%202008.pdf) – neuroștiință  
- 📘 [Introduction to Machine Learning with Python](https://www.nrigroupindia.com/e-book/Introduction%20to%20Machine%20Learning%20with%20Python%20(%20PDFDrive.com%20)-min.pdf) – inteligență artificială  
- 📘 [Essential Astrophysics (2013)](https://eprints.ukh.ac.id/id/eprint/281/1/2013_Book_EssentialAstrophysics.pdf) – astronomie  
- 📘 [Electronics (VK Mehta)](https://biapatna.org/wp-content/uploads/2021/06/Electronics-VK-Mehta.pdf) – electronică  

---

## Autentificare

Autentificarea este gestionată prin **Firebase Authentication**.

Tipuri de conturi:
- **Elev** – acces la lecții, evaluări, chatbot, progres personal
- **Părinte** – panou cu statistici, scoruri, activitate copil

---

## Resurse externe utile

- 📺 [Add Firebase to Flutter (YouTube)](https://www.youtube.com/watch?v=FkFvQ0SaT1I&t=25s)
- 📺 [What is Firebase for Flutter?](https://www.youtube.com/watch?v=f_O0FSjAWM0&list=PL3vTvg37dBB2CZjmtjMk59DqHidQ_RJDa)
