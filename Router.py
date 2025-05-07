from HomePage import acasa_view
from AI import chat_ai_view
from Raspunsuri import raspunsuri_view
from Statistici import statistici_view
from Matematica import matematica_view
from Astrofizica import astrofizica_view
from Lectii import lectie_view
import flet as ft

routes = {
    "/home":acasa_view,
    "/ai":chat_ai_view,
    "/raspunsuri":raspunsuri_view,
    "/stats":statistici_view,
    "/mate":matematica_view,
    "/astro":astrofizica_view,
    "/lectie":lectie_view
}

page = None

def init_router(p: ft.Page):
    global page
    page = p

def route_change(route: ft.RouteChangeEvent):
    address, args = route.route.split("?")
    args = args.split("&")
    page.content_area.content = routes[address](page,*args)
    print(address," ".join(args))
    page.update()
