import tkinter as tk 
import speech_recognition as sr
    
window = tk.Tk()

window.title("Speech Recognition")
window.geometry("440x420")
window.config(bg='#990027')

def get_inputan () :
    name = str(entry_field.get())
    return name 
 
def set_inputan () : 
    panggil = get_inputan()
    if panggil.lower() == "indonesia" :
        r = sr.Recognizer()
        with sr.Microphone() as source:
            audio = r.listen(source)
        try:
            text = r.recognize_google(audio,language="id-ID")
        except:
            text = "Sorry could not recognize your voice"
    elif panggil.lower() == "english" :
        r = sr.Recognizer()
        with sr.Microphone() as source:
            audio = r.listen(source)
        try:
            text = r.recognize_google(audio,language="en-EN")
        except:
            text = "Sorry could not recognize your voice"
    elif panggil.lower() == "mandarin" :
        r = sr.Recognizer()
        with sr.Microphone() as source:
            audio = r.listen(source)
        try:
            text = r.recognize_google(audio,language="zh-ZH")
        except:
            text = "Sorry could not recognize your voice"
    elif panggil.lower() == "java" :
        r = sr.Recognizer()
        with sr.Microphone() as source:
            audio = r.listen(source)
        try:
            text = r.recognize_google(audio,language="jv-JV")
        except:
            text = "Sorry could not recognize your voice"
    else :
        text = "Wrong Choice"
    label_nama.insert(tk.END, text)
    label_nama.insert(tk.END, " . ")

#LABEL
title = tk.Label(text = "SPEECH RECOGNITION PROGRAM", font = ("Adam.cg pro", 14), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 0)

title = tk.Label(text = "Artificial Intelligence Class", font = ("Ebrima", 12), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 1)

title = tk.Label(text = "Prof. Dr. techn. M. Isa Irawan, M.T.", font = ("Ebrima", 8), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 2)

title = tk.Label(text = "Venansius Ryan 06111540000043  |  Vira Diana 06111540000067", font = ("Ebrima", 8), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 3)

title = tk.Label(text = "", font = ("Ebrima", 8), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 4)

title = tk.Label(text = "We Provide a Language Services in English, Indonesia, Mandarin, and Java", font = ("Ebrima", 10), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 5)

title = tk.Label(text = "Please choose one", font = ("Ebrima", 10), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 6)

title = tk.Label(text = "", font = ("Ebrima", 8), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 7)

#entry field
entry_field = tk.Entry()
entry_field.grid(column = 1, row = 8)

button1 = tk.Button(text = "Click Here!", bg = "grey", command = set_inputan)
button1.grid(column = 1, row = 9)

title = tk.Label(text = "", font = ("Ebrima", 8), bg="#990027", fg = "#ffffff")
title.grid(column = 1, row = 10)

label_nama = tk.Text(master=window, height = 10, width = 30)
label_nama.grid(column = 1, row = 11)

window.mainloop()