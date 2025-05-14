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



def matematica_view(page: ft.Page):

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
            # Titlu + cercuri în colțul dreapta jos
            ft.Stack(
                controls=[
                    ft.Container(
                        content=ft.Text("Matematică", size=40, weight="bold", text_align="center"),
                        width=800,
                        height=180,
                        bgcolor="#54A0F8",
                        alignment=ft.alignment.center,
                        border_radius=15,
                        border=ft.border.all(1, "black"),
                    ),
                    # Cerc galben
                    ft.Container(
                        width=60,
                        height=60,
                        bgcolor="#F6CD46",
                        shape=ft.BoxShape.CIRCLE,
                        border=ft.border.all(1, "black"),
                        left=600,
                        top=230,
                    ),
                    # Cerc alb
                    ft.Container(
                        width=40,
                        height=40,
                        bgcolor="white",
                        shape=ft.BoxShape.CIRCLE,
                        border=ft.border.all(1, "black"),
                        left=530,
                        top=200,
                    ),

                    # Cerc mare cu "VIII"
                    ft.Container(
                        width=90,
                        height=90,
                        bgcolor="#FDBA74",
                        shape=ft.BoxShape.CIRCLE,
                        border=ft.border.all(1, "black"),
                        alignment=ft.alignment.center,
                        content=ft.Text("VIII", weight="bold"),
                        bottom=-50,
                        right=0,
                    ),
                ],
                width=800,
                height=180,
                clip_behavior=ft.ClipBehavior.NONE
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


