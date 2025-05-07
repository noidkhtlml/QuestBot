import flet as ft
import google.generativeai as genai
import plotly.graph_objs as go
from flet.plotly_chart import PlotlyChart
import asyncio
ai_responses = []  # memorie doar pentru răspunsurile AI-ului

# Configurare Gemini
genai.configure(api_key="AIzaSyBOJFkhhQrQG8x6s6AIzqTDa8uncVEwNmU")
model = genai.GenerativeModel(model_name="gemini-1.5-flash")

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

# Definire funcție pentru a obține răspunsuri de la AI
async def get_ai_response(prompt):
    try:
        response = model.generate_content(prompt)
        return response.text.strip()
    except Exception as e:
        return "Nu am putut obține un răspuns de la AI."

# Pagina de chat AI
def chat_ai_view(page: ft.Page):
    chat_column = ft.Column(scroll="auto", expand=True)
    input_field = ft.TextField(label="Scrie întrebarea ta...", expand=True)

    for q,a in ai_responses:
        chat_column.controls.append(
            ft.Container(
                content=ft.Text(f"{q}", color=ft.colors.BLACK, selectable=True),
                bgcolor=ft.colors.LIGHT_BLUE_100,
                border=ft.border.all(1, ft.colors.BLUE_300),
                border_radius=10,
                padding=10,
                margin=5,
                alignment=ft.alignment.center_left
            )
        )
        chat_column.controls.append(
            ft.Container(
                content=parse_bold(f"{a}"),
                bgcolor=ft.colors.PURPLE_100,
                border=ft.border.all(1, ft.colors.PURPLE_300),
                border_radius=10,
                padding=10,
                margin=5,
                alignment=ft.alignment.center_left
            )
        )

    async def on_send(e=None):
        question = input_field.value.strip()
        if not question:
            return
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
        ai_responses.append((question,answer))
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

    input_field.on_submit = on_send

    return ft.Column([
        ft.Text("💬 Chat AI Educațional", style="headlineMedium"),
        ft.Container(chat_column, expand=True, padding=10),
        ft.Container(
            content=ft.Row([input_field, ft.IconButton(icon=ft.icons.SEND, on_click=on_send)]),
            margin=ft.margin.only(top=5, bottom=20)  # Adăugăm margine pentru a evita eroarea
        ),
    ], expand=True)

def raspunsuri_view():
    return ft.Container(
        content=ft.Column([
            ft.Text("Răspunsuri AI salvate", style="headlineMedium"),
            ft.Divider(),
            *[ft.Container(
                content=parse_bold(f"**Intrebare: {q}**\n\t {a}"),
                bgcolor=ft.colors.PURPLE_100,
                padding=10,
                margin=5,
                border_radius=10
            ) for q,a in ai_responses]
        ],
        scroll="auto",
        expand=True,
        alignment=ft.MainAxisAlignment.START),
        alignment=ft.alignment.top_left,
        expand=True
    )

# Pagina de pornire cu chenare
def acasa_view(page: ft.Page):
    fig = go.Figure(
        data=[
            go.Scatter(
                x=["Ian", "Feb", "Mar"],
                y=[10, 15, 7],
                mode="lines+markers",
                line=dict(color="#8B5CF6", width=3),
                marker=dict(size=8, color="#C084FC"),
            )
        ]
    )
    fig.update_layout(
        plot_bgcolor="#FFFFFF",
        paper_bgcolor="#FFFFFF",
        margin=dict(l=20, r=20, t=20, b=20),
    )

    grafic_card = ft.Container(
        content=PlotlyChart(fig, expand=True),
        bgcolor="#E9D5FF",
        border_radius=15,
        padding=15,
        width=400,
        height=250,
    )

    tabel_card = ft.Container(
        content=ft.Column([
            ft.Text("📋 Tabel Mini", size=16, weight="bold"),
            ft.Text("Aici vei pune rânduri dintr-un tabel..."),
        ]),
        bgcolor="#F3E8FF",
        border_radius=15,
        padding=15,
        width=300,
        height=250,
    )

    extra_cards = ft.Row([
        ft.Container(
            content=ft.Image(),
            bgcolor="#DDD6FE",
            border_radius=12,
            padding=10,
            width=180,
            height=120

        ),
        ft.Container(
            content=ft.Text("Chenar 2"),
            bgcolor="#E0E7FF",
            border_radius=12,
            padding=10,
            width=180,
            height=120
        ),
        ft.Container(
            content=ft.Text("Chenar 3"),
            bgcolor="#DBEAFE",
            border_radius=12,
            padding=10,
            width=180,
            height=120
        ),
    ], spacing=15)

    return ft.Column([
        ft.Text("Pagina principală", size=26, weight="bold", color="#7C3AED"),
        ft.Row([grafic_card, tabel_card], spacing=20),
        ft.Divider(height=30, color="transparent"),
        extra_cards
    ], expand=True)


    def pagina_raport():
        return ft.View(
            "/raport",
            controls=[
                ft.Text("Raport Detaliat", size=24, weight="bold"),
                ft.ElevatedButton("← Înapoi", on_click=lambda e: page.go("/")),
            ],
        )
    page.on_route_change = route_change
    page.go(page.route)

# Pagina de statistici
def statistici_view():
    return ft.Column(
        [
            # Titlul cu margine pentru a-l alinia sus
            ft.Container(
                content=ft.Text("Statistici Vizuale", size=26, weight="bold", color="#7C3AED"),
                margin=ft.margin.only(top=0),  # Eliminăm marginea de sus pentru a-l împinge la început
            ),

            # Restul conținutului
            ft.Text("Aici vor apărea statisticile și graficele..."),
        ],
        alignment=ft.MainAxisAlignment.START,  # Aliniere sus
        expand=True,  # Folosim expand pentru a umple toată înălțimea disponibilă
        scroll="auto",  # Permite derularea pe verticală dacă conținutul este prea lung
    )


# Pagina Despre
def despre_view():
    return ft.Column([
        ft.Text("ℹ️ Aplicație educațională cu AI pentru STEM.")
    ], alignment=ft.MainAxisAlignment.START, expand=True)

# Pagini goale pentru chenare și grafice
def pagina_grafic():
    return ft.Container(content=ft.Text("📈 Pagina detalii grafic"), alignment=ft.alignment.center, expand=True)

def pagina_tabel():
    return ft.Container(content=ft.Text("📋 Pagina detalii tabel"), alignment=ft.alignment.center, expand=True)

def pagina_chenar_1():
    return ft.Container(content=ft.Text("🔍 Detalii Chenar 1"), alignment=ft.alignment.center, expand=True)

def pagina_chenar_2():
    return ft.Container(content=ft.Text("🔍 Detalii Chenar 2"), alignment=ft.alignment.center, expand=True)

def pagina_chenar_3():
    return ft.Container(content=ft.Text("🔍 Detalii Chenar 3"), alignment=ft.alignment.center, expand=True)

# Funcția principală
async def main(page: ft.Page):
    page.title = "QuestBot App"
    page.bgcolor = ft.colors.GREY_100

    content_area = ft.Container(expand=True)

    def update_view(index):
        views = [
            acasa_view(page),  # Pagina de pornire cu chenare
            chat_ai_view(page),  # Pagina de chat AI
            statistici_view(),  # Pagina de statistici
            raspunsuri_view(),
            despre_view(),
            pagina_grafic(),
            pagina_tabel(),
            pagina_chenar_1(),
            pagina_chenar_2(),
            pagina_chenar_3()
        ]
        content_area.content = views[index]
        page.update()

    rail = ft.NavigationRail(
        selected_index=0,
        label_type=ft.NavigationRailLabelType.ALL,
        destinations=[
            ft.NavigationRailDestination(icon=ft.Icons.HOME, label="Acasă"),
            ft.NavigationRailDestination(icon=ft.Icons.CHAT, label="Chat AI"),
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

# Lansează aplicația


