import flet as ft
import json

# Funcție apelată când un chenar e apăsat
def on_chenar_click(e):
    chenar_text = e.control.content.value
    e.page.dialog = ft.AlertDialog(
        title=ft.Text("Ai apăsat:"),
        content=ft.Text(chenar_text),
        actions=[ft.TextButton("OK", on_click=lambda _: e.page.dialog.close())]
    )
    e.page.dialog.open = True


# Funcție pentru a îngroșa textul de tip **cuvânt**
def parse_bold(text):
    parts = []
    split = text.split("**")
    for i, part in enumerate(split):
        if i % 2 == 0:
            parts.append(ft.TextSpan(part))
        else:
            parts.append(ft.TextSpan(part, style=ft.TextStyle(weight=ft.FontWeight.BOLD)))
    return ft.Text(spans=parts, selectable=True, color=ft.colors.BLACK)


 # Routing pentru fiecare lecție




def intoarcere_la_lectii(e):
    e.page.views.pop()  # elimină lecția curentă
    e.page.go("/")      # revine la pagina principală


def verifica_raspuns(e):
    valoare = selected_value.current.value

    if not hasattr(e.page, "score"):
        e.page.score = 0
    if not hasattr(e.page, "completed_questions"):
        e.page.completed_questions = set()

    if valoare == "2":
        if chenar_id not in e.page.completed_questions:
            e.page.score += 1
            e.page.completed_questions.add(chenar_id)
            rezultat_text.value = "✅ Răspuns corect!"
            rezultat_text.color = "green"
        else:
            rezultat_text.value = "✔️ Ai răspuns deja corect la această lecție."
            rezultat_text.color = "blue"
    else:
        rezultat_text.value = "❌ Răspuns greșit."
        rezultat_text.color = "red"

        scor_text.value = f"Scor: {e.page.score}"
    e.page.update()


def view_pop(e):
    page.views.pop()
    page.update()


# Încarcă o singură dată lectiile din JSON
with open("lectii.json", "r", encoding="utf-8") as file:
    LECTII = json.load(file)

def genereaza_pagina_lectie(lectie_id: str) -> ft.Column:
    if lectie_id not in LECTII:
        return ft.Column([
            ft.Text("Lecția nu a fost găsită.", size=20, color="red")
        ])

    titlu, continut = LECTII[lectie_id]

    paragrafe = continut.split("\n\n")
    blocuri_text = [
        ft.Container(
            content=ft.Text(
                p.strip(),
                size=18,
                weight=ft.FontWeight.NORMAL,
                text_align=ft.TextAlign.JUSTIFY,
            ),
            padding=ft.padding.only(left=20, bottom=10)
        )
        for p in paragrafe if p.strip()
    ]

    return ft.Column(
        controls=[
            ft.Text(titlu, size=30, weight=ft.FontWeight.BOLD),
            ft.Divider(thickness=2, color="blue"),
            *blocuri_text
        ],
        spacing=10,
        scroll=ft.ScrollMode.AUTO,
        expand=True
    )
