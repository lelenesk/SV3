import pypyodbc as odbc
import pprint

pp = pprint.PrettyPrinter(indent=4)

DRIVER_NAME = 'SQL SERVER'
SERVER_NAME = 'GEPHAZ\ELSO'
DATABASE_NAME = 'AdventureWorks2019'
connection_string = f"""
    DRIVER={{{DRIVER_NAME}}};
    SERVER={SERVER_NAME};
    DATABASE={DATABASE_NAME};
    Trust_Connection=yes
"""
conn = odbc.connect(connection_string)
c = conn.cursor()

# basic method
c.execute("select FirstName, MiddleName, LastName, rowguid from Person.Person where rowguid like ?", ('C63' + '%',))
for row in c.fetchall():
    print(f"Person Full name: " + str(row[0]) + " " + str(row[1]) + " " + row[2] + "\n" + "ROWGUID: " + row[3])

# make dict + pprint
c.execute("select FirstName, MiddleName, LastName, rowguid from Person.Person where rowguid like ?", ('C63E' + '%',))
columns = [column[0] for column in c.description]
for row in c.fetchall():
    pp.pprint(dict(zip(columns, row)))

# formatted string + multiple variables,list of dicts
param0 = "FirstName"
param1 = "LastName"
param2 = 'Tarzan'
param3 = 'Jane'
c.execute(f'''select {param0}, {param1} from Person.Person WHERE FirstName in {param2, param3}''')
results = [dict(zip([column[0] for column in c.description], row)) for row in c.fetchall()]
pp.pprint(results)

c.close()
conn.close()
