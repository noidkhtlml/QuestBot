import flet as ft
import google.generativeai as genai
import plotly.graph_objs as go
from flet.plotly_chart import PlotlyChart
import asyncio

from Electronica import electronica_view
from HomePage import acasa_view
from AI import chat_ai_view
from Raspunsuri import raspunsuri_view
from Statistici import statistici_view
from Matematica import matematica_view
from Astrofizica import astrofizica_view
import Router
from utils import on_chenar_click
ai_responses = []  # memorie doar pentru răspunsurile AI-ului


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
def main(page: ft.Page):
    page.title = "QuestBot App"
    page.bgcolor = ft.Colors.GREY_100

    page.content_area = ft.Container(expand=True,expand_loose=True)

    Router.init_router(page)

    def update_view(index):
        views = [
            acasa_view(page),  # Pagina de pornire cu chenare
            chat_ai_view(page),  # Pagina de chat AI
            statistici_view(page),  # Pagina de statistici
            matematica_view(page),
            astrofizica_view(page),
            electronica_view(page),
            raspunsuri_view(page),
            despre_view(),
            pagina_grafic(),
            pagina_tabel(),
            pagina_chenar_1(),
            pagina_chenar_2(),
            pagina_chenar_3(),

        ]
        page.content_area.content = views[index]
        page.update()

    def open_view(view):
        page.content_area.content = view
        page.update()

    rail = ft.NavigationRail(
        selected_index=0,
        label_type=ft.NavigationRailLabelType.ALL,
        destinations=[
            ft.NavigationRailDestination(icon=ft.Icons.HOME, label="Acasă"),
            ft.NavigationRailDestination(icon=ft.Icons.CHAT, label="Chat AI"),
            ft.NavigationRailDestination(icon=ft.Icons.BAR_CHART, label="Statistici"),
            ft.NavigationRailDestination(icon=ft.Icons.CALCULATE, label="Matematică"),
            ft.NavigationRailDestination(icon=ft.Icons.CALCULATE, label="Astronomie"),
            ft.NavigationRailDestination(icon=ft.Icons.CALCULATE, label="Electronică"),
            ft.NavigationRailDestination(icon=ft.Icons.INFO, label="Istoric"),
        ],
        on_change=lambda e: update_view(e.control.selected_index),
    )

    update_view(0)

    page.open_view = open_view

    page.on_route_change = Router.route_change

    page.add(
        ft.Row(
            [rail, page.content_area],
            expand=True
        )
    )



# Lansează aplicația
ft.app(target=main, assets_dir="assets")

