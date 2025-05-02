import flet as ft
import plotly.graph_objs as go
from flet.plotly_chart import PlotlyChart
from utils import parse_bold
import asyncio

from storage import ai_responses

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