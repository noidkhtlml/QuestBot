import flet as ft
import plotly.graph_objs as go
from flet.plotly_chart import PlotlyChart
import asyncio

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

    def route_change(route):
        page.views.clear()
        if page.route == "/raport":
            page.views.append(pagina_raport(page))  # ✅ corect
        else:
            page.views.append(pagina_start(page))  # și aici, ca să fim consecvenți
        page.update()

    page.on_route_change = route_change
    page.go(page.route)
