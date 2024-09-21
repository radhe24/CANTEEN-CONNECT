import flet as ft
from flet import *


def login(page):


    def login(e):
        username = input_fields.content.controls[0].content.controls[1].value
        password = input_fields.content.controls[1].content.controls[1].value
        if len(username) == 0:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Username Field is empty!",color="white",text_align=TextAlign.CENTER),duration=2000))
        elif len(password) == 0:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Password Field is empty!",color="white",text_align=TextAlign.CENTER),duration=2000))
        else:
            if username == "Admin":
                if password == "083025":
                    page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text("Login Successful",color="white",text_align=TextAlign.CENTER),duration=2000))
                    page.go("/home")
                else:
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Password Incorrect!",color="white",text_align=TextAlign.CENTER),duration=2000))
            else:
                    page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Username Incorrect!",color="white",text_align=TextAlign.CENTER),duration=2000))


    logo_img = Container(height=150,width=page.width,alignment=ft.alignment.center,
        content=Text("Click and Collect",
                                   text_align="center",size=40,
                                   weight="w700")        )
                                 
    title = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Admin Login",
                                   text_align="center",size=30,
                                   weight="w700")        
                                   )
    sub_titile = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Please enter Admin Credentials below to login as an Admin",
                                   text_align="center",size=14,
                                   weight="w300")        
                                   )
    
    input_fields = Container(
        width=page.width,alignment=ft.alignment.center,padding=padding.only(top=80,left=30,right=30),
        content=Column(controls=[
            Container(width=page.width//1.2,alignment=ft.alignment.center
                      ,content=Column(controls=[Text("Username",size=14),
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
            Container(width=page.width//1.2,alignment=ft.alignment.center,padding=padding.only(top=50),
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