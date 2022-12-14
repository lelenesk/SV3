from examples import *

root = Tk()
root.title("SQL Mastering Application")
root.geometry("400x300")

frm_student = Frame(root)
frm_student.grid(column=1, row=1)
frm_school1 = Frame(root)
frm_school1.grid(column=2, row=1)
frm_school2 = Frame(root)
frm_school2.grid(column=3, row=1)

Label(frm_student, text="Csoport példái").grid(column=0, row=0, rowspan=2, columnspan=2)
Button(frm_student, text="Joc feladata", command=joc_page).grid(column=0, row=4)
Button(frm_student, text="Tomi feladata", command=tomi_page).grid(column=0, row=5)
Button(frm_student, text="Vercsi feladata", command=joc_page).grid(column=0, row=6)
Button(frm_student, text="Gábor feladata", command=joc_page).grid(column=0, row=7)
Button(frm_student, text="Tomasz feladata", command=root.destroy).grid(column=0, row=8)
Button(frm_student, text="Csaba Feladata", command=joc_page).grid(column=0, row=9)
Button(frm_student, text="ZID feladata", command=joc_page).grid(column=0, row=10)
Button(frm_student, text="Kornél feladata", command=root.destroy).grid(column=0, row=11)

Label(frm_school1, text="Haladó Oktatási példák").grid(column=0, row=0, rowspan=2, columnspan=2)
Button(frm_school1, text="többszörös select", command=joc_page).grid(column=0, row=4)
Button(frm_school1, text="csoportosító lekérdezések", command=joc_page).grid(column=0, row=5)
Button(frm_school1, text="null kezelés 1", command=joc_page).grid(column=0, row=6)
Button(frm_school1, text="null kezelés 2", command=joc_page).grid(column=0, row=7)
Button(frm_school1, text="null kezelés 3", command=joc_page).grid(column=0, row=8)
Button(frm_school1, text="ranking 1. módszer", command=joc_page).grid(column=0, row=9)
Button(frm_school1, text="ranking 2. módszer", command=joc_page).grid(column=0, row=10)
Button(frm_school1, text="Windowing", command=joc_page).grid(column=0, row=11)

Label(frm_school2, text="Órai feladatok").grid(column=0, row=0, rowspan=2, columnspan=2)
Button(frm_school2, text="gyakorlás 1", command=joc_page).grid(column=0, row=4)
Button(frm_school2, text="gyakorlás 2", command=joc_page).grid(column=0, row=5)
Button(frm_school2, text="gyakorlás 3", command=joc_page).grid(column=0, row=6)
Button(frm_school2, text="Név formázása", command=joc_page).grid(column=0, row=7)
Button(frm_school2, text="gyakorlás 4", command=joc_page).grid(column=0, row=8)
Button(frm_school2, text="gyakorlás 5", command=joc_page).grid(column=0, row=9)
Button(frm_school2, text="gyakorlás 6", command=joc_page).grid(column=0, row=10)
Button(frm_school2, text="gyakorlás 7", command=joc_page).grid(column=0, row=11)
Button(frm_school2, text="gyakorlás 8", command=joc_page).grid(column=0, row=10)
Button(frm_school2, text="gyakorlás 9", command=joc_page).grid(column=0, row=11)

Button(root, text="Alkalmazás bezárása", command=root.destroy).grid(column=0, row=0, columnspan=6)

mainloop()