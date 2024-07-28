import flet as ft
from flet import *
from signup import signup
from login import login
from passwrod_reset import rtpss



def main(page:Page):
    page.title = "Canteen Connect"
    page.window.resizable = True
    page.adaptive = True
    
    # page.theme_mode = ft.ThemeMode.LIGHT
    # page.vertical_alignment = MainAxisAlignment.CENTER
    # page.horizontal_alignment = MainAxisAlignment.CENTER

    rtpss_page = rtpss(page)
    signup_page = signup(page)
    login_page = login(page)

    def route_change(route):
        page.views.clear()
        page.views.append(
            View(route="/",controls=[login_page])
        )
        if page.route == "/signup":
            page.views.append(
                View(route="/signup",controls=[signup_page])
            )
        if page.route == "/rtpss":
            page.views.append(
                View(route="/rtpss",controls=[rtpss_page])
            )
        page.update()

    def view_pop(e:ViewPopEvent):   
        page.views.pop()
        top_view = page.views[-1]
        page.go(top_view.route)

    

    page.on_route_change = route_change
    page.on_view_pop = view_pop
    page.go(page.route)

    


ft.app(target=main,assets_dir="assets")