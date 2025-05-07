import flet as ft
from Lectii import lectie_view

def on_chenar_click(page,key):
    page.go(f"/lectie?{key}")

class Chenar(ft.Container):
    def __init__(self,key: str,page: ft.Page):
        super().__init__()
        self.key = key
        self.page = page
        self.content = ft.Container(
            content=ft.Text(f"Chenar {self.key}", text_align="center"),
            width=120,
            height=100,
            bgcolor="#E0F2FE",
            border_radius=10,
            border=ft.border.all(1, "black"),
            alignment=ft.alignment.center,
            on_click=lambda _: on_chenar_click(self.page,self.key),
            ink=True,
        )



def astrofizica_view(page: ft.Page):

    # 20 de chenare (5 rânduri x 4 coloane)
    chenare = []
    for i in range(1, 21):
        chenare.append(
            Chenar(f"{i}",page)
        )

    chenar_grid = ft.Column([
        ft.Row(controls=chenare[i:i+4], alignment=ft.MainAxisAlignment.CENTER, spacing=20)
        for i in range(0, 20, 4)
    ])

    return ft.Column(
        controls=[
            ft.Stack(
                controls=[
                    ft.Container(
                        content=ft.Text("Astrofizică", size=40, weight="bold", text_align="center"),
                        width=800,
                        height=180,
                        bgcolor="#2B6EBD",
                        alignment=ft.alignment.center,
                        border_radius=15,
                        border=ft.border.all(1, "black"),
                    ),
                    ft.Image(
                        src="https://cdn-icons-png.flaticon.com/512/3336/3336008.png",  # Saturn
                        width=80,
                        height=80,
                        left=700,
                        top=150,
                        fit=ft.ImageFit.CONTAIN,
                    ),
                    ft.Image(
                        src="https://cdn-icons-png.flaticon.com/512/6699/6699864.png",  # Pluto
                        width=45,
                        height=45,
                        left=500,
                        top=220,
                        fit=ft.ImageFit.CONTAIN,
                    ),
                    ft.Image(
                        src="https://cdn-icons-png.flaticon.com/512/9985/9985721.png",  # Terra
                        width=70,
                        height=70,
                        left=585,
                        top=250,
                        fit=ft.ImageFit.CONTAIN,
                    ),
                ],
                width=800,
                height=180,
                clip_behavior=ft.ClipBehavior.NONE,
            ),

            ft.Row(
                controls=[
                    ft.Container(
                        content=ft.Text("Understanding\nscale drawing", text_align="center"),
                        width=180,
                        height=140,
                        bgcolor="#5CE1E6",
                        border_radius=15,
                        border=ft.border.all(1, "black"),
                        alignment=ft.alignment.center,
                        ink=True,
                        on_click=lambda e: page.go("/scale-understanding"),
                    ),
                    ft.Container(
                        content=ft.Text("Scale drawing\nexamples", text_align="center"),
                        width=180,
                        height=140,
                        bgcolor="#CB6CE6",
                        border_radius=15,
                        border=ft.border.all(1, "black"),
                        alignment=ft.alignment.center,
                        ink=True,
                        on_click=lambda e: page.go("/scale-examples"),
                    ),
                ],
                alignment=ft.MainAxisAlignment.START,
                spacing=30,
                width=600,
            ),

            ft.Divider(height=30, color="transparent"),

            chenar_grid,
        ],
        alignment=ft.MainAxisAlignment.START,
        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
        scroll="auto",
        expand=True,
    )
