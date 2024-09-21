import firebase_admin.auth
from flet import *
import flet as ft

from firebase_admin import credentials,firestore
import firebase_admin

Menu = []
Name = [] 

def browser(page:Page):


  cred = credentials.Certificate("credentials.json")
  firebase_admin.initialize_app(cred)
  db = firestore.client()
  food = db.collection("FOOD").get()
  

  def add_btn(name):
    btn = ElevatedButton(height=100,style=ButtonStyle(shape=RoundedRectangleBorder(radius=10),elevation=3,bgcolor=colors.GREEN_500),
                        on_click=lambda _:show_items(name.id),content=Row(spacing=50,alignment=alignment.center,controls=[Image(src=f"{name.to_dict()["image"]}",width=80,height=80,border_radius=10),
                          Text(name.id,text_align=TextAlign.CENTER,style=TextStyle(color=colors.WHITE,size=30
                       ))]))

    return btn
  
  def show_items(name):

    menu = db.collection("FOOD").document(name).collection("Menu").get()
    for i in menu:Menu.append(i)
    Name.append(name)
    page.go("/menu")

   
    
              
  title = Container(width=page.width,alignment=ft.alignment.center,padding=padding.only(top=80,bottom=50),
                  content=Text("Menu",
                                text_align="center",size=40,
                                weight="w700")        
                                )
  contents = ListView(width=page.width,spacing=10,auto_scroll=True,expand=1,
                       controls=[add_btn(i) for i in food])
  body = Container(alignment=ft.alignment.center,
                  height=page.height,
                  width=page.width,
                  border_radius=20,
                  content=Column(controls=[
                                          title,
                                          contents
                                          ]))
  
  return body



def menu(page):
  def cart_slide(e):
    # bs = BottomSheet(bgcolor=colors.RED_500,content=Row(controls=[
    #     Container(height=100,alignment=alignment.center,content=Text("View Cart",size=50,color=colors.WHITE)),IconButton(icon=icons.ARROW_FORWARD_IOS_ROUNDED,icon_size=50)
    #  ]))
    # page.open(bs)
    page.open(SnackBar(bgcolor=colors.RED_500,content=Container(height=50,alignment=alignment.center,content=Row(alignment=MainAxisAlignment.SPACE_AROUND,controls=[
      Text("View Cart",color="white",text_align=TextAlign.CENTER,size=50),
      IconButton(icon=icons.ARROW_FORWARD_IOS_ROUNDED,icon_size=40)])),duration=2000))
  def add_btn1(name):
      btn = Container(height=100,bgcolor=colors.GREEN_500,border_radius=10,width=page.width,shadow=BoxShadow(blur_radius=3,offset=Offset(0,0),blur_style=ShadowBlurStyle.OUTER),
                          content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[
                             Container(padding=padding.only(left=20),content=Image(src=f"{name.to_dict()["image"]}",width=80,height=80,border_radius=10,fit=ImageFit.FILL)),
                            Container(padding=padding.only(top=10),width=100,content=Column(controls=[Text(name.id.title(),text_align=TextAlign.LEFT,style=TextStyle(color=colors.WHITE,size=20
                        )),Text(f"price : {name.to_dict()["price"]} ₹",style=TextStyle(color=colors.WHITE,size=15),text_align=TextAlign.CENTER)])),
                        Container(content=ElevatedButton("ADD +",style=ButtonStyle(color=colors.WHITE,shape=RoundedRectangleBorder(radius=10),
                            bgcolor=colors.ORANGE_500),on_click=cart_slide),padding=padding.only(right=10))
                            ])
                      )
      if name.to_dict()['available'] == "yes":
        btn.content.controls[2].content.disabled = False
      else: 
        btn.content.controls[2].content.disabled = True
        btn.bgcolor = colors.GREY
        btn.content.controls[2].content.bgcolor = colors.GREY
      return btn
  
  def back(e):
      page.go("/browser")
      del Menu[:]
  back_btn = Container(padding=padding.only(top=20),content=IconButton(icon=icons.ARROW_BACK_IOS_NEW_OUTLINED,icon_size=30,padding=padding.only(top=80),alignment=alignment.top_left
                        ,on_click=back))
  
  title = Container(width=page.width,alignment=ft.alignment.center,padding=padding.only(top=20,bottom=50),
                  content=Text(f"{Name[0]} Menu",
                                text_align="center",size=40,
                                weight="w700")        
                                )
  
  contents = ListView(width=page.width,spacing=10,expand=1,padding=padding.only(bottom=50),
                       controls=[add_btn1(i) for i in Menu])
  
  body = Container(alignment=ft.alignment.center,
                  height=page.height,
                  width=page.width,
                  border_radius=20,
                  content=Column(controls=[back_btn,
                                          title,
                                          contents
                                          ]))
  
  return body