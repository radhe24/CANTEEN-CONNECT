from flet import *
import flet as ft
import requests
import json

def rtpss(page,auth):


    def send_email(e):
        if len(input_fields.content.controls[0].content.controls[1].value) == 0:
            page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Email Field is empty!",color="white",text_align=TextAlign.CENTER),duration=2000))
        else:
            try:
                email = input_fields.content.controls[0].content.controls[1].value
                user = auth.send_password_reset_email(email)
                page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text(f"Password reset mail has been sent to {email}",color="white",text_align=TextAlign.CENTER),duration=2000))
            except requests.HTTPError as e:
                    error_json = e.args[1]
                    error = json.loads(error_json)['error']['message']
                    print(error)
                    if error == "INVALID_ID_TOKEN":
                        page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Email has not registered",color="white",text_align=TextAlign.CENTER),duration=2000))
                    elif error == "INVALID_EMAIL":
                        page.open(SnackBar(bgcolor=colors.RED_500,content=Text("Invalid Email",color="white",text_align=TextAlign.CENTER),duration=2000))
                    print(error)

    back_btn = Container(padding=padding.only(top=20),content=IconButton(icon=icons.ARROW_BACK_IOS_NEW_OUTLINED,icon_size=30,alignment=alignment.top_left
                        ,on_click=lambda _ : page.go("/login")))

    logo_img = Container(padding=padding.only(top=50,bottom=50),width=page.width,alignment=ft.alignment.center,
        content=Text("Click and Collect",
                                   text_align="center",size=40,
                                   weight="w700")        )
                            
    title = Container(width=page.width,alignment=ft.alignment.center,
                      content=Text("Password Reset",
                                   text_align="center",size=30,
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
    
    body = Container(alignment=ft.alignment.center,
                     height=page.height,
                     width=page.width,
                     border_radius=20,
                     content=Column(controls=[back_btn,
                                              logo_img,
                                              title,
                                              input_fields
                                              ]))
    return body