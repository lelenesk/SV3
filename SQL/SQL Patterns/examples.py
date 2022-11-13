from tkinter import *
from tkinter import ttk
import pandas as pd
import pypyodbc as odbc
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
#import sqlalchemy

#engine = sqlalchemy.create_engine('postgresql://root@localhost:5432/GEPHAZ/ELSO')
#df = pd.read_sql_table("AdventureWorks2019",engine)
#print(df)

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

table_sales_salesorderheader = "SELECT * FROM Sales.SalesOrderHeader;"
df_sales_salesorderheader = pd.read_sql(table_sales_salesorderheader, conn)

table_sales_salesorderdetail = "SELECT * FROM Sales.SalesOrderDetail;"
df_sales_salesorderdetail = pd.read_sql(table_sales_salesorderdetail, conn)

table_sales_customer = "SELECT * FROM Sales.Customer;"
df_sales_customer = pd.read_sql(table_sales_customer, conn)

table_production_product = "SELECT * FROM Production.Product;"
df_production_product = pd.read_sql(table_production_product, conn)

table_person_person = "SELECT * FROM Person.Person;"
df_person_person = pd.read_sql(table_person_person, conn)

def joc_page():
    descripton_text = """
    Feladat Leírása: 
    
    Add meg az 5 legnagyobb összegben (TotalDue) piros termékeket vásárló Vevőt 2012 első negyedévében (DueDate)
    """
    sql_text = """
    SQL szintaxis:
    
    SELECT TOP (5) SOH.CustomerID, SUM (SOH.TotalDue) 'Teljes vásárlás'
    FROM Sales.SalesOrderHeader SOH
    LEFT JOIN Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
    LEFT JOIN Production.Product P ON SOD.ProductID = P.ProductID
    WHERE P.Color = 'RED' AND YEAR(SOH.DueDate)=2012 AND MONTH(SOH.DueDate)<=3
    GROUP BY SOH.CustomerID
    ORDER BY SUM (SOH.TotalDue) DESC
    """
    pandas_text = """
    Pandas szintaxis:
     
    merged_soh_sod = pd.merge(
    df_sales_salesorderheader,df_sales_salesorderdetail, on='salesorderid', how='left'
    )
    merged_soh_sod_p = pd.merge(
    merged_soh_sod, df_production_product, on='productid', how='left'
    )
    result = merged_soh_sod_p[
    (merged_soh_sod_p.color == 'Red') & 
    (merged_soh_sod_p.duedate.dt.year == 2012) &
    (merged_soh_sod_p.duedate.dt.month <= 3)
    ]
    [['customerid','totaldue']].round({'totaldue': 0}).groupby(['customerid'],as_index=False)
    .sum().sort_values(by='totaldue', ascending=False).head(5)
    """

    show_page = Toplevel()
    show_page.title('Joc feladata')
    show_page.geometry("1900x1000")

    frm_joc_description = Frame(show_page)
    frm_joc_description.grid(column=0, row=0,columnspan=1)
    #frm_joc_sql = Frame(show_page)
    #frm_joc_sql.grid(column=0, row=1,columnspan=1)
    #frm_joc_pandas = Frame(show_page)
    #frm_joc_pandas.grid(column=0, row=2,columnspan=1)
    frm_joc_stat = Frame(show_page)
    frm_joc_stat.grid(column=2, row=0)
    frm_joc_table = ttk.Treeview(frm_joc_stat, columns=(1, 2), show='headings')
    frm_joc_table.pack(side=BOTTOM, fill=BOTH, padx=20, pady=20)

    descripton_widget = Text(frm_joc_description, height= 20, width =110, wrap=WORD)
    sql_widget = Text(frm_joc_description, height=20, width=110, wrap=WORD)
    pandas_widget = Text(frm_joc_description, height=20, width=110, wrap=WORD)

    descripton_widget.insert(INSERT, descripton_text)
    sql_widget.insert(INSERT, sql_text)
    pandas_widget.insert(INSERT, pandas_text)

    descripton_widget.grid()
    sql_widget.grid()
    pandas_widget.grid()

    frm_joc_table.heading(1, text='CustomerID')
    frm_joc_table.heading(2, text='Teljes vásárlás')

    c.execute(f'''SELECT  TOP (5) SOH.CustomerID, SUM (SOH.TotalDue) 'Teljes vásárlás'
        FROM Sales.SalesOrderHeader SOH 
            LEFT JOIN Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
            LEFT JOIN Production.Product P ON SOD.ProductID = P.ProductID
        WHERE P.Color = 'RED' AND YEAR(SOH.DueDate)=2012 AND MONTH(SOH.DueDate)<=3
        GROUP BY SOH.CustomerID
        ORDER BY SUM (SOH.TotalDue) DESC''')

    joc_result = c.fetchall()
    for i in joc_result:
        frm_joc_table.insert('', 'end', values=i)

    merged_soh_sod = pd.merge(df_sales_salesorderheader,df_sales_salesorderdetail, on='salesorderid', how='left')
    merged_soh_sod_p = pd.merge(merged_soh_sod, df_production_product, on='productid', how='left')
    result = merged_soh_sod_p[(merged_soh_sod_p.color == 'Red') & (merged_soh_sod_p.duedate.dt.year == 2012) &
    (merged_soh_sod_p.duedate.dt.month <= 3)][['customerid','totaldue']].round({'totaldue': 0}).groupby(['customerid'],as_index=False).sum().sort_values(
        by='totaldue', ascending=False).head(5)

    result.to_csv(r'exported_results/joc.csv')

    figure1 = plt.Figure(figsize=(10, 5), dpi=100)
    ax1 = figure1.add_subplot(111)
    bar1 = FigureCanvasTkAgg(figure1, frm_joc_stat)
    bar1.get_tk_widget().pack(side=TOP, fill=BOTH, padx=20, pady=20)
    plotted_result = result
    plotted_result.plot(x='customerid',y='totaldue',kind='barh', ax=ax1)
    ax1.set_title('Top 5 legnagyobb összegben vásárló ídőre és színre szűrve')


def tomi_page():
    descripton_text = """
        Feladat Leírása: 

        Kérem azon vevők vezetéknevét akik a 2012-es évben legalább 2 alkalommal vásároltak 785$ felett.
        """
    sql_text = """
        SQL szintaxis:

        select count(soh.TotalDue) as 'Hányszor', sum(soh.totaldue) as 'összesen',soh.CustomerID, p.LastName
        from Sales.SalesOrderHeader as soh
        inner join Sales.Customer as C on C.CustomerID = soh.CustomerID
        left join Person.Person as P on P.BusinessEntityID = C.PersonID
        where year(soh.OrderDate) = 2012 --and soh.TotalDue >785
        group by soh.CustomerID, p.LastName
        having sum(soh.TotalDue) > 785
        order by 2 asc
        """
    pandas_text = """
        Pandas szintaxis:

        merged_soh_sod = pd.merge(df_sales_salesorderheader,df_sales_salesorderdetail, on='salesorderid', how='left')
        merged_soh_sod_p = pd.merge(merged_soh_sod, df_production_product, on='productid', how='left')
        result = merged_soh_sod_p[(merged_soh_sod_p.color == 'Red') & (merged_soh_sod_p.duedate.dt.year == 2012) &
        (merged_soh_sod_p.duedate.dt.month <= 3)][['customerid','totaldue']].round({'totaldue': 0}).groupby(['customerid'],as_index=False).sum().sort_values(
            by='totaldue', ascending=False).head(5)
        """

    show_page = Toplevel()
    show_page.title('Tomi feladata')
    show_page.geometry("1200x1200")

    frm_tomi_description = Frame(show_page)
    frm_tomi_description.grid(column=0, row=0, columnspan=1)
    frm_tomi_sql = Frame(show_page)
    frm_tomi_sql.grid(column=0, row=1, columnspan=1)
    frm_tomi_pandas = Frame(show_page)
    frm_tomi_pandas.grid(column=0, row=2, columnspan=1)
    frm_tomi_stat = Frame(show_page)
    frm_tomi_stat.grid(column=1, row=0, columnspan=3)
    frm_tomi_table = ttk.Treeview(show_page, columns = (1, 2, 3, 4), show='headings')
    frm_tomi_table.grid(column=1, row=1, columnspan=3)

    Label(frm_tomi_description, text=descripton_text).grid()
    Label(frm_tomi_sql, text=sql_text).grid()
    Label(frm_tomi_pandas, text=pandas_text).grid()
    frm_tomi_table.heading(1, text='Hányszor vásárolt')
    frm_tomi_table.heading(2, text='Összesen mennyiért')
    frm_tomi_table.heading(3, text='CustomerID')
    frm_tomi_table.heading(4, text='Vezetéknév')

    c.execute(f'''select count(soh.TotalDue) as "Hányszor", sum(soh.totaldue) as "összesen",soh.CustomerID, p.LastName
            from Sales.SalesOrderHeader as soh
            inner join Sales.Customer as C on C.CustomerID = soh.CustomerID
            left join Person.Person as P on P.BusinessEntityID = C.PersonID
            where year(soh.OrderDate) = 2012
            group by soh.CustomerID, p.LastName
            having sum(soh.TotalDue) > 785
            order by 2 asc''')

    tomi_result = c.fetchall()
    for i in tomi_result:
        frm_tomi_table.insert('', 'end', values=i)


    merged_soh_c = pd.merge(df_sales_salesorderheader, df_sales_customer, on='customerid', how='inner')
    indexed_df_person_person = df_person_person.set_index("businessentityid")
    merged_soh_c_p = pd.merge(merged_soh_c, indexed_df_person_person,left_on="personid",right_on="businessentityid", right_index=True)
    result = merged_soh_c_p[( merged_soh_c_p.duedate.dt.year == 2012)][['totaldue', 'totaldue','customerid','lastname',]].groupby(['customerid', 'lastname'], as_index=False).filter('totaldue') > 786

    result.to_csv(r'exported_results/tomi.csv')
    print(result)

    figure1 = plt.Figure(figsize=(6, 5), dpi=100)
    ax1 = figure1.add_subplot(111)
    bar1 = FigureCanvasTkAgg(figure1, frm_tomi_stat)
    bar1.get_tk_widget().pack(side=LEFT, fill=BOTH)
    plotted_result = result
    plotted_result.plot(x='customerid', y='totaldue', kind='barh', ax=ax1)
    ax1.set_title('ez')





    #c.close()
    #conn.close()


