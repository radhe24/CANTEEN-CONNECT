import flet as ft
from flet import *
import firebase_admin
from firebase_admin import credentials, firestore


def Menu(page:Page,name):

    cred = credentials.Certificate("credentials.json")
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    item = db.collection("FOOD").document(name).collection().get()
    print(item)
    title = Container(width=page.width,alignment=ft.alignment.center,padding=padding.only(top=80,bottom=50),
                  content=Text("Menu",
                                text_align="center",size=40,
                                weight="w700")        
                                )
    contents = Container(width=page.width,alignment=alignment.center,
                       content=Column(alignment=alignment.center,controls=[ElevatedButton(height=100,style=ButtonStyle(shape=RoundedRectangleBorder(radius=10),elevation=3),
                         content=Row(spacing=50,alignment=alignment.center,controls=[Image(src=i["image"],width=80,height=80,border_radius=10),
                          Text(i,text_align=TextAlign.CENTER,style=TextStyle(color=colors.WHITE,size=30
                       ))])) for i in item]))
    body = Container(alignment=ft.alignment.center,
                  height=page.height,
                  width=page.width,
                  border_radius=20,
                  content=Column(controls=[
                                          title,
                                        
                                          ]))
    return body