import flet as ft

from utils import intoarcere_la_lectii
from utils import parse_bold
from utils import verifica_raspuns


# Lecții disponibile (mapate după ID-ul chenarelor)
lectii = {
    1: ("Sistemul Solar", "Sistemul Solar este format din 8 planete și alte corpuri cerești..."),
    2: ("Soarele", "Soarele este steaua din centrul sistemului nostru solar..."),
    3: ("Pământul", "Pământul este a treia planetă de la Soare și singura cunoscută cu viață..."),
    4: ("Luna", "Luna este satelitul natural al Pământului..."),
    # Poți adăuga mai multe aici
}

# Funcția pentru afișarea unei lecții
def lectie_view(page: ft.Page,chenar_id: str):
    titlu, continut = lectii.get(chenar_id, ("Lecție indisponibilă", "Această lecție nu este încă definită."))

    rezultat_text = ft.Text("", size=16)
    scor_text = ft.Text("", size=16)

    selected_value = ft.Ref[ft.RadioGroup]()

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

    return ft.Column(
        controls=[
            ft.Text(titlu, size=30, weight="bold"),
            ft.Text(continut, size=16),
            ft.Divider(height=20),
            ft.Text("Test interactiv:", size=20, weight="bold"),
            ft.RadioGroup(
                ref=selected_value,
                content=ft.Column([
                    ft.Radio(label="Răspuns 1", value="1"),
                    ft.Radio(label="Răspuns corect", value="2"),
                    ft.Radio(label="Răspuns 3", value="3"),
                ])
            ),
            ft.ElevatedButton("Verifică răspunsul", on_click=verifica_raspuns),
            rezultat_text,
            scor_text,
            ft.Divider(height=20),
            ft.ElevatedButton("Înapoi la lecții", on_click=intoarcere_la_lectii),
        ],
        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
    )