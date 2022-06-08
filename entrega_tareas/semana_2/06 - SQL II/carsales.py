from flask import Flask, render_template, request, redirect
import pyodbc

carsales = Flask(__name__)

def connection():   #Conexion con la base de datos, s=host, d=nombrebasededatos, u = nombreusario p=contraseña
    s = 's488' 
    d = 'demstalf_upgrade' 
    u = 'demstalf_hub'
    p = '002310AZza!' 
    cstr = 'DRIVER={ODBC Driver 17 for SQL Server};SERVER='+s+';DATABASE='+d+';UID='+u+';PWD='+ p #Evita errores al conectar con la base de datos
    conn = pyodbc.connect(cstr)
    return conn

@carsales.route("/")

def main():  #Selecciona y muestra los coches y los renderiza en carlist.html
    cars = []
    conn = connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM dbo.coches") 
    for row in cursor.fetchall():
        cars.append({"id": row[0], "nombre": row[1], "año": row[2], "precio": row[3]})
    conn.close()
    return render_template("carslist.html", cars = cars)



@carsales.route("/addcar", methods = ['GET','POST'])

def addcar(): #Selecciona y renderiza añadir coches para insertar id,nombre,edad,año y precio
    if request.method == 'GET':
        return render_template("addcar.html", car = {})
    if request.method == 'POST':
        id = int(request.form["id"])
        name = request.form["nombre"]
        year = int(request.form["año"])
        price = float(request.form["precio"])
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("INSERT INTO dbo.coches (id, nombre, año, precio) VALUES (?, ?, ?, ?)", id, name, year, price)
        conn.commit()
        conn.close()
        return redirect('/')


@carsales.route('/updatecar/<int:id>',methods = ['GET','POST'])

def updatecar(id): #Esta funcion se usa para actualizar
    cr = []
    conn = connection()
    cursor = conn.cursor()
    if request.method == 'GET':
        cursor.execute("SELECT * FROM dbo.coches WHERE id = ?", id)
        for row in cursor.fetchall():
            cr.append({"id": row[0], "nombre": row[1], "año": row[2], "precio": row[3]})
        conn.close()
        return render_template("addcar.html", car = cr[0])
    if request.method == 'POST':
        name = str(request.form["nombre"])
        year = int(request.form["año"])
        price = float(request.form["precio"])
        cursor.execute("UPDATE dbo.coches SET nombre = ?, año = ?, precio = ? WHERE id = ?", name, year, price, id)
        conn.commit()
        conn.close()
        return redirect('/')



@carsales.route('/deletecar/<int:id>')

def deletecar(id): #Con esto borramos
    conn = connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM dbo.coches WHERE id = ?", id)
    conn.commit()
    conn.close()
    return redirect('/')

if(__name__ == "__main__"):
    carsales.run()