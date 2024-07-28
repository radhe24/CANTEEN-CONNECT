import flet as ft
from flet import *
from pyrebase.pyrebase import initialize_app

def login(page:Page):
    
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
    
    def login(e):
        firbase = initialize_app(firebaseConfig)
        auth = firbase.auth()
        user = auth.sign_in_with_email_and_password(input_fields.content.controls[0].content.controls[1].value,input_fields.content.controls[1].content.controls[1].value)

    

    logo_img = Container(height=150,width=page.width,alignment=ft.alignment.center,
        content=Column(alignment=MainAxisAlignment.CENTER,controls=[Container(padding=padding.only(top=20),alignment=ft.alignment.center,
                                    content=Text("Login",
                                   text_align="center",size=30,
                                   weight="w700")        )
                                   ]))
    title = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Canteen Connect",
                                   text_align="center",size=40,
                                   weight="w700")        
                                   )
    sub_titile = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Please enter your information below inorder to login to your account",
                                   text_align="center",size=14,
                                   weight="w300")        
                                   )
    
    input_fields = Container(
        width=page.width,alignment=ft.alignment.center,padding=padding.only(top=30,left=30,right=30),
        content=Column(controls=[
            Container(width=page.width//1.2,alignment=ft.alignment.center
                      ,content=Column(controls=[Text("Email",size=14),
                                                TextField(
                                                    focused_border_color=colors.BLUE_200,
                                                    border_radius=10
                                                )]))
            ,
            Container(width=page.width//1.2,alignment=ft.alignment.center
                      ,content=Column(controls=[Text("Password",size=14),
                                                TextField(
                                                    focused_border_color=colors.BLUE_200,
                                                    border_radius=10,password=True,
                                                    can_reveal_password=True                                               
                                                    )])),
            Container(width=page.width//1.2,alignment=ft.alignment.center,
                      content=Row(alignment=ft.alignment.center,spacing=50,controls=[
                        TextButton("Forget Password?",on_click=lambda _ : page.go("/rtpss")
                                     ),
                        TextButton("Create Account",on_click= lambda _ : page.go("/signup")
                                     )
                      ])),
            Container(width=page.width//1.2,alignment=ft.alignment.center,
                      content=TextButton("Login",width=page.width//1.3,on_click=login,height=50,
                                         style=ButtonStyle(
                                             color=colors.WHITE,
                                             bgcolor=colors.GREEN_900,
                                             shape = RoundedRectangleBorder(radius=10)
                                             
                                            
                                         ))),
            Container(width=page.width//1.2,alignment=ft.alignment.center,content=Text("or",size=16),padding=padding.only(top=10))
            ])
                                                )
    

    buttons = Container(alignment=ft.alignment.center,padding=0,
                        content=Column(alignment=MainAxisAlignment.CENTER,spacing=20,
                            controls=[
                                ElevatedButton(width=page.width//1.3,content=Row(alignment=MainAxisAlignment.CENTER,controls=[Image(src="https://cdn-icons-png.flaticon.com/512/720/720255.png",width=20,height=20),
                                                                     Text("Continue with Google")]),style=ButtonStyle(
                                                                         color=colors.WHITE,
                                                                         bgcolor=colors.ORANGE_900,
                                                                         shape=RoundedRectangleBorder(radius=10)
                                                                     ),height=50),
                                
                                ElevatedButton(icon=icons.FACEBOOK,text="Continue with Facebook",width=page.width//1.3,style=ButtonStyle(
                                                                         color=colors.WHITE,
                                                                         bgcolor=colors.BLUE_900,
                                                                         shape=RoundedRectangleBorder(radius=10)
                                                                     ),height=50)]
                        ))

    body = Container(alignment=ft.alignment.center,
                     height=page.height,
                     width=page.width,
                     border_radius=20,
                     content=Column(controls=[logo_img,
                                              title,
                                              sub_titile,
                                              input_fields,
                                              buttons]))
    return body