import flet as ft

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



def electronica_view(page: ft.Page):

    # 20 de chenare (5 rânduri x 4 coloane)
    chenare = []
    for i in range(21, 42):
        chenare.append(
            Chenar(f"{i}",page)
        )

    chenar_grid = ft.GridView(
        expand=True,
        runs_count=4,  # număr de coloane dorit pe ecrane mai mari
        max_extent=150,  # lățime maximă per item – se ajustează automat
        child_aspect_ratio=1,  # păstrează pătrățele (sau ajustează la nevoie)
        spacing=20,
        run_spacing=20,
        controls=chenare,
    )

    return ft.Column(
        controls=[
            # Titlu + cercuri în colțul dreapta jos
            ft.Stack(
                controls=[
                    ft.Container(
                        content=ft.Text("Electronică", size=70, weight="bold", text_align="center"),
                        height=250,
                        bgcolor="#54A0F8",
                        alignment=ft.alignment.center,
                        border_radius=15,
                        border=ft.border.all(1, "black"),
                        expand=True,
                    ),

                ],
                expand = True,
                height = 250,
                clip_behavior = ft.ClipBehavior.NONE
            ),

            # Chenarele tematice (roz + verde)
            ft.Row(
                controls=[
                    ft.Container(
                        content=ft.Text("Understanding\nscale drawing", text_align="center"),
                        width=180,
                        height=140,
                        bgcolor="#F9A8D4",
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
                        bgcolor="#6EE7B7",
                        border_radius=15,
                        border=ft.border.all(1, "black"),
                        alignment=ft.alignment.center,
                        ink=True,
                        on_click=lambda e: page.go("/scale-examples"),
                    ),
                ],
                alignment=ft.MainAxisAlignment.START,
                spacing=30,
                expand = True,
            ),

            ft.Divider(height=30, color="transparent"),

            chenar_grid,
        ],
        alignment=ft.MainAxisAlignment.START,
        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
        scroll="auto",
        expand=True,
    )


