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
