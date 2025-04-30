import flet as ft
import google.generativeai as genai
import plotly.graph_objs as go
from flet.plotly_chart import PlotlyChart
import asyncio
from HomePage import acasa_view
from AI import chat_ai_view
from Raspunsuri import raspunsuri_view
from Statistici import statistici_view

ai_responses = []  # memorie doar pentru răspunsurile AI-ului


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
ft.app(target=main, assets_dir="assets")

