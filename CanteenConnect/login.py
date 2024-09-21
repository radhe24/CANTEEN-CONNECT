import flet as ft
from flet import *
import json
import requests


def login(page,auth):
    
    

    def login(e):
        if len(input_fields.content.controls[0].content.controls[1].value) == 0:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Email Field is empty!",color="white",text_align=TextAlign.CENTER),duration=2000))
        elif len(input_fields.content.controls[1].content.controls[1].value) == 0:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Password Field is empty!",color="white",text_align=TextAlign.CENTER),duration=2000))
        else:
            try:
                user = auth.sign_in_with_email_and_password(input_fields.content.controls[0].content.controls[1].value,input_fields.content.controls[1].content.controls[1].value)
                page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text("Login Successful",color="white",text_align=TextAlign.CENTER),duration=2000))
                page.go("/browser")
            except requests.HTTPError as e:
                error_json = e.args[1]
                error = json.loads(error_json)['error']['message']
                print(error)
                if error == "EMAIL_EXISTS":
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Email already exists",color="white",text_align=TextAlign.CENTER),duration=2000))
                elif error == "INVALID_EMAIL":
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Email is invalid",color="white",text_align=TextAlign.CENTER),duration=2000))
                elif error == "INVALID_LOGIN_CREDENTIALS":
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Invalid Login Credentials",color="white",text_align=TextAlign.CENTER),duration=2000))
                elif "TOO_MANY_ATTEMPTS_TRY_LATER" in error:
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Too many attempts! Try again later",color="white",text_align=TextAlign.CENTER),duration=2000))
    

    logo_img = Container(height=150,width=page.width,alignment=ft.alignment.center,
        content=Text("Click and Collect",
                                   text_align="center",size=40,
                                   weight="w700")        )
                                 
    title = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Login",
                                   text_align="center",size=30,
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
            ])
                                                )
    

    
            

    body = Container(alignment=ft.alignment.center,
                     height=page.height,
                     width=page.width,
                     border_radius=20,
                     content=Column(controls=[logo_img,
                                              title,
                                              sub_titile,
                                              input_fields
                                              ]))
    return body