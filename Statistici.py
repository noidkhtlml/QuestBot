import flet as ft
import plotly.graph_objs as go
from flet.plotly_chart import PlotlyChart
import asyncio

from uritemplate import expand


# Pagina de statistici
def statistici_view():
    return ft.Container(
        content=ft.Column([
            # Titlul cu margine pentru a-l alinia sus
            ft.Container(
                content=ft.Text("Statistici Vizuale", size=26, weight="bold", color="#7C3AED"),
                margin=ft.margin.only(top=0),  # Eliminăm marginea de sus pentru a-l împinge la început
            ),


            # Restul conținutului
            ft.Text("Aici vor apărea statisticile și graficele..."),
        ],
            scroll="auto",
            expand=True,
            alignment=ft.MainAxisAlignment.START),
        alignment=ft.alignment.top_left,
        expand=True
    )
