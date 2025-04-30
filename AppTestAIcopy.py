import flet as ft
import google.generativeai as genai

ai_responses = []  # memorie doar pentru răspunsurile AI-ului
conversation_history = [] #memorie interna ai

# Configurare Gemini
genai.configure(api_key="AIzaSyBOJFkhhQrQG8x6s6AIzqTDa8uncVEwNmU")
model = genai.GenerativeModel(model_name="gemini-1.5-flash")

#aici avem functie care face ca raspunsurile de la ai de tipul **cuvant** sa fie ingrosate
def parse_bold(text):
    parts = []
    split = text.split("**")
    for i, part in enumerate(split):
        if i % 2 == 0:
            parts.append(ft.TextSpan(part))
        else:
            parts.append(ft.TextSpan(part, style=ft.TextStyle(weight=ft.FontWeight.BOLD)))
    return ft.Text(spans=parts, selectable=True, color=ft.colors.BLACK)

#definire functie pentru a obtine raspunsuri de la ai
async def get_ai_response(prompt: str):
    context = "\n".join([f"User: {q}\nAI: {a}" for q, a in conversation_history[-5:]])  # ultimele 5
    full_prompt = f"{context}\nUser: {prompt}\nAI:"
    try:
        response = model.generate_content(prompt)
        return response.text.strip()
    except Exception as e:
        return "Nu am putut obține un răspuns de la AI."

#prima pagina din meniu
def chat_ai_view(page: ft.Page):
    chat_column = ft.Column(scroll="auto", expand=True)
    input_field = ft.TextField(label="Scrie întrebarea ta...", expand=True)
    async def on_send(e=None):
        question = input_field.value.strip()
        if not question:
            return

        #configurare a chenarului in care sunt scrise intrebarile
        chat_column.controls.append(
            ft.Container(
                content=ft.Text(f"{question}", color=ft.colors.BLACK, selectable=True),
                bgcolor=ft.colors.LIGHT_BLUE_100,
                border=ft.border.all(1, ft.colors.BLUE_300),
                border_radius=10,
                padding=10,
                margin=5,
                alignment=ft.alignment.center_left
            )
        )

        input_field.value = ""
        input_field.disabled = True
        page.update()

        answer = await get_ai_response(question)
        conversation_history.append((question, answer))  # Salvăm și întrebarea, și răspunsul

        #chenarul in care apar intrebarile dupa send
        chat_column.controls.append(
            ft.Container(
                content=parse_bold(f"{answer}"),
                bgcolor=ft.colors.PURPLE_100,
                border=ft.border.all(1, ft.colors.PURPLE_300),
                border_radius=10,
                padding=10,
                margin=5,
                alignment=ft.alignment.center_left
            )
        )

        input_field.disabled = False
        input_field.focus()
        page.update()

    input_field.on_submit = on_send  # Apelează on_send la Enter

    return ft.Column([
        ft.Text("💬 Chat AI Educațional", style="headlineMedium"),
        ft.Container(chat_column, expand=True, padding=10),
        ft.Row([
            input_field,
            # **Adaugă această linie pentru a face ca click pe Send să trimită întrebarea**
            ft.IconButton(icon=ft.Icons.SEND, on_click=on_send)  # Apelează on_send la click
        ]),
    ], expand=True)

#a doua pagina din meniu
def raspunsuri_view():
    return ft.Container(
        content=ft.Column([
            ft.Text("🧠 Răspunsuri AI salvate", style="headlineMedium"),
            ft.Divider(),
            *[ft.Container(
                content=ft.Text(f"- {rsp}", color=ft.colors.BLACK),
                bgcolor=ft.colors.PURPLE_100,
                padding=10,
                margin=5,
                border_radius=10
            ) for rsp in ai_responses]
        ],
        scroll="auto",
        expand=True,
        alignment=ft.MainAxisAlignment.START),
        alignment=ft.alignment.top_left,
        expand=True
    )



def statistici_view():
    return ft.Column([
        ft.Text("📊 Aici vei vedea statistici.")
    ], alignment=ft.MainAxisAlignment.START, expand=True)


def despre_view():
    return ft.Column([
        ft.Text("ℹ️ Aplicație educațională cu AI pentru STEM.")
    ], alignment=ft.MainAxisAlignment.START, expand=True)


async def main(page: ft.Page):
    page.title = "QuestBot App"
    page.bgcolor = ft.colors.GREY_100

    content_area = ft.Container(expand=True)

    def update_view(index):
        views = [
            chat_ai_view(page),
            raspunsuri_view(),
            statistici_view(),
            despre_view()
        ]
        content_area.content = views[index]
        page.update()

    rail = ft.NavigationRail(
        selected_index=0,
        label_type=ft.NavigationRailLabelType.ALL,
        destinations=[
            ft.NavigationRailDestination(icon=ft.Icons.CHAT, label="Chat AI"),
            ft.NavigationRailDestination(icon=ft.Icons.SAVE, label="Răspunsuri"),
            ft.NavigationRailDestination(icon=ft.Icons.BAR_CHART, label="Statistici"),
            ft.NavigationRailDestination(icon=ft.Icons.INFO, label="Despre"),
        ],
        on_change=lambda e: update_view(e.control.selected_index),
    )

    update_view(0)

    page.add(
        ft.Row(
            [rail, content_area],
            expand=True
        )
    )

ft.app(target=main)
