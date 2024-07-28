from flet import *
import flet as ft
from pyrebase.pyrebase import initialize_app

def rtpss(page:Page):

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

    

    def send_email(e):
        firbase = initialize_app(firebaseConfig)
        auth = firbase.auth()
        email = input_fields.content.controls[0].content.controls[1].value
        user = auth.send_email_verification(email)
        page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text("Email Field is empty!",color="white"),duration=2000))

    logo_img = Container(height=150,width=page.width,alignment=ft.alignment.center,
        content=Column(alignment=MainAxisAlignment.CENTER,controls=[Container(padding=padding.only(top=20),alignment=ft.alignment.center,
                                    content=Text("Password reset",
                                   text_align="center",size=30,
                                   weight="w700")        )
                                   ]))
    title = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Canteen Connect",
                                   text_align="center",size=40,
                                   weight="w700")        
                                   )
    
    input_fields = Container(
        width=page.width,alignment=ft.alignment.center,padding=padding.only(top=30,left=30,right=30),
        content=Column(spacing=20,controls=[
            Container(width=page.width//1.2,alignment=ft.alignment.center
                      ,content=Column(controls=[Text("Enter Email",size=14),
                                                TextField(
                                                    focused_border_color=colors.BLUE_200,
                                                    border_radius=10
                                                )])),
            Container(width=page.width//1.1,alignment=ft.alignment.center,
                      content=TextButton("Send Verification Email",width=page.width//1.1,height=50,
                                         style=ButtonStyle(
                                             color=colors.WHITE,
                                             bgcolor=colors.GREEN_900,
                                             shape = RoundedRectangleBorder(radius=10) 
                                         ),on_click=send_email))]))
    back_button = Container(width=page.width//1.2,alignment=ft.alignment.bottom_left,padding=padding.only(left=30,top=20),
                      content=TextButton("Back",on_click=lambda _ : page.go("/login"),style=ButtonStyle(
                          shape=RoundedRectangleBorder(radius=10),bgcolor=colors.BLUE,color=colors.WHITE
                      )))
    
    body = Container(alignment=ft.alignment.center,
                     height=page.height,
                     width=page.width,
                     border_radius=20,
                     content=Column(controls=[logo_img,
                                              title,
                                              input_fields,
                                              back_button]))
    return body