import tkinter as tk
import cv2
import numpy as np
from PIL import ImageTk, Image
from tkinter import messagebox


def salirse():
    root.destroy()


# Ventana de inicio
class vt_principal():
    def __init__(self, master):
        self.master = master
        self.sobrante_x = 40
        self.sobrante_y = 20

        master.title("Controlador de Torreta")

        # Etiquetas
        self.lb_inicio = tk.Label(root, text="Seleccione Modo de Operación", font=("Arial", 15))
        self.lb_inicio.grid(row=0, column=0, columnspan=2, padx=self.sobrante_x, pady=self.sobrante_y )

        #Imagen
        self.imagen = tk.Canvas(master, width = 100 , height = 120)
        self.imagen.grid(row=1, column=0, columnspan=2)
        self.torreta_1 = Image.open("Torreta.PNG")
        self.torreta_1 = self.torreta_1.resize((100,110), Image.ANTIALIAS)
        self.torreta_png = ImageTk.PhotoImage(self.torreta_1)
        self.imagen.create_image(0, 0, image=self.torreta_png, anchor=tk.NW)

        # Botones
        self.bt_m_manual = tk.Button(root, text="Modo Manual", height=3, width=18)
        self.bt_m_programacion = tk.Button(root, text="Modo Progamación", height=3, width=18, command=self.abrir_m_progamacion)
        self.bt_m_busqueda = tk.Button(root, text="Modo Búsqueda", height=3, width=18)
        self.bt_m_watchdog = tk.Button(root, text="Modo Watchdog", height=3, width=18)
        self.bt_salir = tk.Button(root, text="Salir", command=salirse, height=3, width=18)

        self.bt_m_manual.grid(row=2, column=0, padx=self.sobrante_x, pady=self.sobrante_y )
        self.bt_m_programacion.grid(row=2, column=1, padx=self.sobrante_x, pady=self.sobrante_y )
        self.bt_m_busqueda.grid(row=3, column=0, padx=self.sobrante_x, pady=self.sobrante_y )
        self.bt_m_watchdog.grid(row=3, column=1, padx=self.sobrante_x, pady=self.sobrante_y )
        self.bt_salir.grid(row=4, column=0, columnspan=2, padx=self.sobrante_x, pady=self.sobrante_y )

    def salir_ventana(self):
        self.master.destroy()

    def ocultar_ventana(self):
        self.master.withdraw()

    def abrir_m_progamacion(self):
        self.ocultar_ventana()
        self.ventana_prog = vt_m_progamacion(self.master, self)

    def reactivar_ventana(self):
        self.master.deiconify()


#Ventana del modo programación
class vt_m_progamacion():
    def __init__(self, master, ventana):
        self.ventana = ventana
        self.top_progamacion = tk.Toplevel(master)
        self.top_progamacion.bind("<Destroy>", self.volver_vt_principal)
        self.top_progamacion.title("Modo Progamable")

        self.frame_dato = tk.Frame(self.top_progamacion)
        self.frame_dato.grid()

        self.mensaje_label = tk.Label(self.frame_dato, text="Inserte el nombre del archivo con su extensión .txt", font=("Arial", 15))
        self.mensaje_label.grid(row=0, padx=60, pady=30)

        self.archivo = tk.Entry(self.frame_dato, width=60)
        self.archivo.grid(row=1, padx=60, pady=30)

        self.bt_prueba = tk.Button(self.frame_dato, text="Prueba", height=3, width=18, command=self.buscar_archivo)
        self.bt_prueba.grid(row=2, padx=60, pady=30)

    def buscar_archivo(self):
        nombre = self.archivo.get()
        if ".txt" in nombre:
            Codigo_futuro = 5
        else:
            tk.messagebox.showerror("Error", "Error: Archivo no válido ingréselo nuevamente")

    def ventana_camara(self):
        self.frame_dato.grid_forget()
        self.etiqueta = tk.Label(self.top_progamacion, text="Funciono")

    def salir_ventana(self):
        self.top_progamacion.destroy()
        self.ventana.reactivar_ventana()

    def volver_vt_principal(self, event):
        self.ventana.reactivar_ventana()






if __name__ == '__main__':                        # Programa principal
    root = tk.Tk()
    Ventana = vt_principal(root)

    root.mainloop()
