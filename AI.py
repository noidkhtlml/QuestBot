import flet as ft
import google.generativeai as genai
import plotly.graph_objs as go
from flet.plotly_chart import PlotlyChart
import asyncio

# memorie doar pentru răspunsurile AI-ului
ai_responses = []

# Configurare Gemini
genai.configure(api_key="AIzaSyBOJFkhhQrQG8x6s6AIzqTDa8uncVEwNmU")
model = genai.GenerativeModel(model_name="gemini-1.5-flash")

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
