import flet as ft
import plotly.graph_objs as go
from flet.plotly_chart import PlotlyChart
import asyncio

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
