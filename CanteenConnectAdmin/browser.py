import firebase_admin.auth
from flet import *
import flet as ft
import time

from firebase_admin import credentials,firestore
import firebase_admin

cred = credentials.Certificate("credentials.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

Menu = []
Name = [] 

def browser(page:Page):


    
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
  
    
    bs = BottomSheet(maintain_bottom_view_insets_padding=True,enable_drag=True,show_drag_handle=True,content=Container(width=page.width,padding=padding.only(left=20,right=20,top=50),alignment=alignment.center,
                                        content=Column(width=page.width,spacing=30,alignment=alignment.center,controls=[
    Container(width=page.width//1.2,alignment=ft.alignment.center
                    ,content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[Text("Item Name",size=24),
                                                TextField(width=150,
                                                    focused_border_color=colors.ORANGE_200,
                                                    border_radius=10
                                                )]))
            ,
            Container(width=page.width//1.2,alignment=ft.alignment.center
                    ,content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[Text("Price",size=24),
                                                TextField(width=100,
                                                    focused_border_color=colors.ORANGE_200,
                                                    border_radius=10,keyboard_type=KeyboardType.NUMBER                                              
                                                    )])),
            Container(width=page.width//1.2,alignment=ft.alignment.center
                    ,content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[Text("Is Available",size=24),
                                                Switch(active_color=colors.GREEN,value=True)])),
            Container(width=page.width//1.2,alignment=ft.alignment.center,
                    content=TextButton("Save",width=page.width//1.3,height=50,
                                        style=ButtonStyle(
                                            color=colors.WHITE,
                                            bgcolor=colors.GREEN_900,
                                            shape = RoundedRectangleBorder(radius=30))))
    ])))


    bs2 = BottomSheet(maintain_bottom_view_insets_padding=True,enable_drag=True,show_drag_handle=True,content=Container(width=page.width,padding=padding.only(left=20,right=20),alignment=alignment.center,
                                        content=Column(width=page.width,spacing=20,alignment=alignment.center,controls=[
    Container(width=page.width//1.2,alignment=ft.alignment.center
                    ,content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[Text("Item Name",size=24),
                                                TextField(width=150,
                                                    focused_border_color=colors.ORANGE_200,
                                                    border_radius=10
                                                )]))
            ,
            Container(width=page.width//1.2,alignment=ft.alignment.center
                    ,content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[Text("Price",size=24),
                                                TextField(width=100,
                                                    focused_border_color=colors.ORANGE_200,
                                                    border_radius=10,keyboard_type=KeyboardType.NUMBER                                              
                                                    )])),
            Container(width=page.width//1.2,alignment=ft.alignment.center
                    ,content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[Text("Is Available",size=24),
                                                Switch(active_color=colors.GREEN,value=True)])),
            Container(width=page.width//1.2,alignment=ft.alignment.center
                    ,content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[Text("Image Address",size=24),
                                                TextField(width=150,
                                                    focused_border_color=colors.ORANGE_200,
                                                    border_radius=10
                                                )])),
            Container(width=page.width//1.2,alignment=ft.alignment.center,
                    content=TextButton("Save",width=page.width//1.3,height=50,
                                        style=ButtonStyle(
                                            color=colors.WHITE,
                                            bgcolor=colors.GREEN_900,
                                            shape = RoundedRectangleBorder(radius=30))))
    ])))
    

    changes = {}

    def openn(name):
        page.open(bs)
        bs.content.content.controls[3].content.on_click = lambda _ : updatedb(name)

    def updatedb(name):
        NAme = bs.content.content.controls[0].content.controls[1].value
        price = bs.content.content.controls[1].content.controls[1].value
        availability = "yes" if bs.content.content.controls[2].content.controls[1].value else "no"
        page.close(bs)
        if len(NAme) == 0:
            if len(price)==0:
                db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(name.id).update({"available": availability})
                page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text(f"Availablity turned to {True if availability == "yes" else False}",color="white",text_align=TextAlign.CENTER),duration=2000))
            else:
                db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(name.id).update({"price": price})
                db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(name.id).update({"available": availability})
                page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text(f"Price of the {name.id} has been updated",color="white",text_align=TextAlign.CENTER),duration=2000))
        else:
            if len(price)==0:
                db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(name.id).update({"name": NAme})
                db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(name.id).update({"available": availability})
                page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text(f"{name.id} is updated to {Name}",color="white",text_align=TextAlign.CENTER),duration=2000))  
            else: 
                db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(name.id).update({"name": NAme})
                db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(name.id).update({"price": price})
                db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(name.id).update({"available": availability})
                page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text(f"Data has been updated succesfully",color="white",text_align=TextAlign.CENTER),duration=2000))
                
        page.go("/shrimmer")
        del Menu[:]
        del Name[:]
        
        # need to work on page refresh / reload the data from databse !!!
    
    def add_btn1(name):
        btn = Container(height=100,bgcolor=colors.GREEN_500,border_radius=10,width=page.width,shadow=BoxShadow(blur_radius=3,offset=Offset(0,0),blur_style=ShadowBlurStyle.OUTER),
                            content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[
                                Container(padding=padding.only(left=20),content=Image(src=f"{name.to_dict()["image"]}",width=80,height=80,border_radius=10,fit=ImageFit.FILL,error_content=Text(name.id.title(),size=15))),
                                Container(padding=padding.only(top=10),width=100,content=Column(controls=[Text(name.to_dict()["name"].title(),text_align=TextAlign.LEFT,style=TextStyle(color=colors.WHITE,size=20
                            )),Text(f"price : {name.to_dict()["price"]} ₹",style=TextStyle(color=colors.WHITE,size=15),text_align=TextAlign.CENTER)])),
                            Container(content=ElevatedButton("Edit",style=ButtonStyle(color=colors.WHITE,shape=RoundedRectangleBorder(radius=10),
                                bgcolor=colors.ORANGE_500),on_click=lambda _ : openn(name)),padding=padding.only(right=10))
                                ])
                        )
        if name.to_dict()['available'] == "no": 
            btn.bgcolor = colors.GREY
            
        return btn
  
    def back(e):
        page.go("/browser")
        del Menu[:]
        del Name[:]

    def opennnnn(e):
        page.open(bs2)
        bs2.content.content.controls[4].content.on_click = lambda _ : add_element()

    def add_element():
        NAme = bs2.content.content.controls[0].content.controls[1].value
        price = bs2.content.content.controls[1].content.controls[1].value
        image = bs2.content.content.controls[3].content.controls[1].value
        page.close(bs2)
        availability = "yes" if bs.content.content.controls[2].content.controls[1].value else "no"
        db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(NAme).set({"name":NAme})
        db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(NAme).set({"price":price},merge=True)
        db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(NAme).set({"available":availability},merge=True)
        db.collection('FOOD').document(f"{Name[0]}").collection("Menu").document(NAme).set({"image":image},merge=True)
        page.open(SnackBar(bgcolor=colors.GREEN_500,content=Text(f"Data has been updated succesfully",color="white",text_align=TextAlign.CENTER),duration=2000))
        page.go("/shrimmer")
        del Menu[:]
        del Name[:]



    back_btn = Container(padding=padding.only(top=20),content=Row(alignment=MainAxisAlignment.SPACE_BETWEEN,controls=[
        IconButton(icon=icons.ARROW_BACK_IOS_NEW_OUTLINED,icon_size=30,padding=padding.only(top=80),alignment=alignment.top_left
                            ,on_click=back),
        Container(alignment=alignment.center,padding=padding.only(right=20,top=20),content=TextButton(text="ADD",style=ButtonStyle(
                    bgcolor=colors.GREEN_500,
                    color=colors.WHITE,
                    shape=RoundedRectangleBorder(radius=10),
                    
        ),on_click=opennnnn))
                    ]))
    
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
                                            contents,
                                            
                                            ]))
    
    pr = Container(visible=False,width=page.width,height=page.height,alignment=alignment.center,
                   content=ProgressRing(width=50,height=50,stroke_width=5))
    
    
        
    return Stack([body,pr])



