import flet as ft
from flet import *
from signup import signup
from login import login
from passwrod_reset import rtpss
from browser import browser , menu
from pyrebase import initialize_app




def main(page:Page):
    page.title = "Click and Collect"
    page.window.resizable = True
    page.adaptive = True
    
    # page.theme_mode = ft.ThemeMode.LIGHT
    # page.vertical_alignment = MainAxisAlignment.CENTER
    # page.horizontal_alignment = MainAxisAlignment.CENTER
    firebaseConfig = {
            "apiKey": "AIzaSyDUg2qdrAungywEjwzp1auQdzZt4xazMJM",
            'authDomain': "canteen-connect-85f2a.firebaseapp.com",
            'projectId': "canteen-connect-85f2a",
            'storageBucket': "canteen-connect-85f2a.appspot.com",
            'messagingSenderId': "893219346794",
            'appId': "1:893219346794:web:b27a77c0f5eff78b66ad13",
            'measurementId': "G-LQ9QRGB310",
            "databaseURL" : ""
    }
    firbase = initialize_app(firebaseConfig)
    auth = firbase.auth()

    browser_page = browser(page)
    rtpss_page = rtpss(page,auth)
    signup_page = signup(page,auth)
    login_page = login(page,auth)

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

        if page.route == "/browser":
            page.views.append(
                View(route="/browser",controls=[browser_page])
            )

        if page.route == "/menu":
            
            page.views.append(
                View(route="/menu",controls=[menu(page)])
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