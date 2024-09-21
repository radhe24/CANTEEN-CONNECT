import flet as ft
from flet import *


def home(page):



    logo_img = Container(height=150,width=page.width,alignment=ft.alignment.center,
        content=Text("Click and Collect",
                                   text_align="center",size=40,
                                   weight="w700")        )
                                 
    title = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Home",
                                   text_align="center",size=30,
                                   weight="w700")        
                                   )
    
    contents = Container(width=page.width,alignment=alignment.center,padding=padding.only(top=50),
                         content=Column(spacing=30,
        controls=[ElevatedButton(content=Text("Update Menu",size=30),height=100,width=page.width//1.2,style=ButtonStyle(color=colors.WHITE,shape=RoundedRectangleBorder(radius=10),elevation=3,bgcolor=colors.GREEN_500),on_click=lambda _ : page.go("/browser")),
                  ElevatedButton(content=Text("View Orders",size=30),height=100,width=page.width//1.2,style=ButtonStyle(color=colors.WHITE,shape=RoundedRectangleBorder(radius=10),elevation=3,bgcolor=colors.GREEN_500)),
                  
    ]))
    
    body = Container(alignment=ft.alignment.center,
                     height=page.height,
                     width=page.width,
                     border_radius=20,
                     content=Column(controls=[logo_img,
                                              title,
                                              contents
                                              ]))
    return body