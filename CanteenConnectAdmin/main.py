import flet as ft
from flet import * 
from login import login
from home import home
from browser import browser , menu 
from loader import ring

def main(page: ft.Page):
    page.title = "Click and Collect"
    page.window.resizable = True
    page.adaptive = True



    login_page = login(page)
    home_page = home(page)
    browser_page = browser(page)


    def route_change(route):
        page.views.clear()
        page.views.append(
            View(route="/",controls=[login_page])
        )
        if page.route == "/home":
            page.views.append(View(route="/home",controls=[home_page]))
        if page.route == "/browser":
            page.views.append(
                View(route="/browser",controls=[browser_page])
            )

        if page.route == "/menu":
            page.views.append(
                View(route="/menu",controls=[menu(page)])
            )
        if page.route == "/shrimmer":
            page.views.append(
                View(route="/shrimmer",controls=[ring(page)])
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
