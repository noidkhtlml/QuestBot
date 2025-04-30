import flet as ft


# Funcție apelată când un chenar e apăsat
def on_chenar_click(e):
    chenar_text = e.control.content.value
    page.dialog = ft.AlertDialog(
        title=ft.Text("Ai apăsat:"),
        content=ft.Text(chenar_text),
        actions=[ft.TextButton("OK", on_click=lambda _: page.dialog.close())]
    )
    page.dialog.open = True
    page.update()


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