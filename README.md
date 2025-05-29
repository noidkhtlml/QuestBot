# 🤖 Questbot

**Questbot** este o aplicație desktop interactivă dezvoltată cu [Flet](https://flet.dev), care poate rula pe orice sistem de operare ce suportă Python (Windows, macOS, Linux). Este accesibilă atât ca aplicație desktop, cât și din browser de pe alte dispozitive din rețea (telefon, laptop etc.).

> Acest proiect a fost realizat pentru participarea în cadrul Infoeducație
---

## 🎯 Descriere

Questbot este o aplicație cu interfață grafică destinată învățării interactive, într-un mod inovativ, a materiilor STEM.

---

## ✅ Cerințe

- Python 3.7 sau versiune mai nouă
- pip (inclus în instalarea standard de Python)
- Acces la internet (pentru instalarea pachetelor)
- Sistem de operare: Windows / macOS / Linux

---

## ⚙️ Instalare – Pas cu pas

### 1. Descarcă sau clonează proiectul
Dacă aplicația este pe GitHub:
```bash
git clone https://github.com/noidkhtlml/questbot.git
cd questbot
### 2. Creează un mediu virtual(recomandat)
Windows:
	python -m venv venv
venv\Scripts\activate
MacOS/Linux:
	python3 -m venv venv
source venv/bin/activate
###3.Instalează dependențele
pip install flet
###4.Rulare
python app.py
```

## 1. Introducere
Questbot este o solutie educationala care integreaza o platforma software interactiva cu un robot fizic, pentru a sustine invatarea practica in domeniile STEM (stiinta, tehnologie, inginerie si matematica). Acest document detaliaza tehnologiile utilizate in dezvoltarea celor doua componente majore: software-ul educational si robotul fizic.
Proiectul a pornit de la nevoia stringenta de a oferi elevilor din Romania acces la uneltele practice necesare pentru aprofundarea cunostintelor tehnice, adesea ignorate in programa scolara traditionala.
## 2. Arhitectura generala
Questbot este construit pe o arhitectura modulara care permite scalabilitate si personalizare usoara. Cele doua componente majore sunt:
Platforma software educativa: destinata livrarii de continut interactiv, urmaririi progresului elevului si asistarii invatarii printr-un chatbot AI.
Robot fizic educational: servește ca interfata tangibila pentru experimente electronice si invatarea aplicata a conceptelor.
Platforma poate functiona independent sau in mod sincronizat cu robotul, in functie de scopul pedagogic urmarit.
## 3. Tehnologii software
### 3.1. Limbaj de programare: Python
Python a fost ales pentru:
Simplitatea sintaxei si usurinta in invatare,
Suport extins pentru AI, data science si dezvoltare web,
Comunitate mare si numeroase librarii open-source.
### 3.2. Framework UI: Flet
Flet este un framework modern care permite scrierea interfetei grafice in Python, fara a fi necesare cunostinte de HTML/CSS/JavaScript.
Avantaje:
Rulare multiplatforma (Windows, MacOS, Linux),
Actualizare automata a interfetei fara refresh,
Design responsive si modern.
### 3.3. Inteligenta Artificiala
Gemini 1.5 Flash API: folosit in versiunea curenta pentru chatbot-ul integrat.
Limitari observate:
Unele raspunsuri pot fi eronate sau irelevante,
Dependenta de conexiune la internet.
Model AI propriu (in dezvoltare):
Baza de date: manuale scolare, lucrari stiintifice, articole educationale,
Obiectiv: generare precisa de intrebari, rezumate si explicatii contextuale.
### 3.4. Vizualizare date: Plotly
Permite generarea de grafice interactive precum:
Progresul per materie,
Corectitudinea raspunsurilor,
Timpul mediu petrecut pe lectie.
### 3.5. Stocare si comunicare date
JSON:
Format preferat pentru structura intrebari, rezultate, configurari,
Ușor de serializat/de-serializat in Python,
Compatibil cu aproape orice limbaj modern.
### 3.6. Control versiuni: GitHub
Folosit pentru:
Managementul codului sursa,
Colaborare asincrona,
Publicare documentatie in format Wiki,
Urmarire issue-uri si milestones.
## 4. Tehnologii hardware
### 4.1. Microcontroler: Raspberry PI 5
Compatibil cu majoritatea senzorilor educationali,
Cost redus si disponibilitate mare,
Suport extins in comunitate si numeroase tutoriale.
### 4.2. Modelare si printare 3D
Modelare 3D: Onshape
Slicing:BambuSlicer
Materiale folosite: PLA, ecologic si sigur pentru medii educationale


## 5. Functionalitati majore dezvoltate
Chatbot STEM bazat pe AI
Modul de teste cu intrebari generate aleatoriu
Sistem de statistici grafice
Lectii de astronomie si electronica cu elemente vizuale si interactive
Asistenta vocala planificata pentru viitorul apropiat
## 6. Provocari si solutii
Problema: API AI poate genera raspunsuri gresite
Solutie: dezvoltare model propriu si introducere sistem de corectitudine semantica
Problema: extragerea din PDF nu este mereu precisa
Solutie: curatare text, eliminare artefacte si antrenare NLP pe structuri romanesti
## 7. Perspective de dezvoltare
Introducerea suportului multi-elev cu conturi personalizate
Integrare cu Google Classroom / EduApps
Lansarea unei aplicatii mobile dedicate
Modul de programare robot in blocuri (similar cu Scratch)
## 8. Concluzie
Questbot imbina inteligent teoria, aplicatia software si experienta practica prin robot. Tehnologiile alese permit un echilibru intre accesibilitate si functionalitate avansata, iar proiectul isi propune sa evolueze intr-o platforma scalabila si complet adaptabila pentru invatarea moderna in domeniul STEM.
Acest document ofera doar o privire generala asupra complexitatii tehnice din spatele proiectului, demonstrand ca inovarea in educatie este posibila chiar si cu resurse limitate, atata timp cat exista pasiune si o abordare structurata.
