import flet as ft
from flet import *
import json
import requests

def signup(page,auth):



    

    def signup(email,password):
        user = auth.create_user_with_email_and_password(email,password)


    def validate(e):
        if len(input_fields.content.controls[0].content.controls[1].value) == 0:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Email Field is empty!",color="white",text_align=TextAlign.CENTER),duration=2000))
        elif len(input_fields.content.controls[1].content.controls[1].value) == 0:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Password Field is empty!",color="white",text_align=TextAlign.CENTER),duration=2000))
        elif len(input_fields.content.controls[2].content.controls[1].value) == 0:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Please confirm the password",color="white",text_align=TextAlign.CENTER),duration=2000))
        elif input_fields.content.controls[1].content.controls[1].value != input_fields.content.controls[2].content.controls[1].value:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Password doesn't match",color="white",text_align=TextAlign.CENTER),duration=2000))
        else:
            try:
                signup(input_fields.content.controls[0].content.controls[1].value,input_fields.content.controls[1].content.controls[1].value)
                page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text("Registration Successful",color="white",text_align=TextAlign.CENTER),duration=2000))
                page.go("/login")
            except requests.HTTPError as e:
                error_json = e.args[1]
                error = json.loads(error_json)['error']['message']
                print(error)
                if error == "EMAIL_EXISTS":
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Email already exists in database",color="white",text_align=TextAlign.CENTER),duration=2000))
                elif error == "WEAK_PASSWORD : Password should be at least 6 characters":
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Password should be at least 6 characters",color="white",text_align=TextAlign.CENTER),duration=2000))
                elif error == "INVALID_EMAIL":
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Email is invalid",color="white",text_align=TextAlign.CENTER),duration=2000))



    logo_img = Container(padding=padding.only(top=20),width=page.width,alignment=ft.alignment.center,
        content=Text("Click and Collect",
                                   text_align="center",size=40,
                                   weight="w700")        )
    title = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Signup",
                                   text_align="center",size=30,
                                   weight="w700")        
                                   )
    sub_titile = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Please enter your information below inorder to register your account",
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
            Container(width=page.width//1.2,alignment=ft.alignment.center
                      ,content=Column(controls=[Text("Confirm Password",size=14),
                                                TextField(
                                                    focused_border_color=colors.BLUE_200,
                                                    border_radius=10,password=True,
                                                    can_reveal_password=True                                               
                                                    )])),
            Container(width=page.width//1.2,alignment=ft.alignment.center,
                      content=Row(alignment=ft.alignment.center,spacing=50,controls=[
                        TextButton("Already Have a account?",on_click=lambda _ : page.go("/login")
                                     )
                      ])),
            Container(width=page.width//1.2,alignment=ft.alignment.center,
                      content=TextButton("Signup",width=page.width//1.3,height=50,
                                         style=ButtonStyle(
                                             color=colors.WHITE,
                                             bgcolor=colors.GREEN_900,
                                             shape = RoundedRectangleBorder(radius=10)
                                             
                                            
                                         ),on_click=validate)),
            
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


