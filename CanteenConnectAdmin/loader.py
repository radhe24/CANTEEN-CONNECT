from flet import *
from time import sleep,time
import threading

def ring(page):

    def up():
        start = time()
        while True:
            if (time() - start) > 2:
                print('stop')
                page.go("/browser")
            
                break

    pr = Container(width=page.width,height=page.height,alignment=alignment.center,
                   content=ProgressRing(width=50,height=50,stroke_width=5))
    
    t1 = threading.Thread(target=up)
    t1.start()

    return pr
    
