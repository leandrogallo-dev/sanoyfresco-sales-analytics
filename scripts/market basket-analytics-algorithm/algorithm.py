import pandas as pd
import pyodbc 
import sqlalchemy as sa
from urllib.parse import quote_plus
import warnings
from sqlalchemy import exc as sa_exc
from itertools import combinations

warnings.filterwarnings("ignore", category=sa_exc.SAWarning, message=".*Unrecognized server version info.*")

try:
    #1 == Conection ==
    conn_sqlserver = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost\\SQLEXPRESS;"
        "DATABASE=sanoyfresco;"
        "Trusted_Connection=yes;"
    )
    print("[+] Conexion creada.")

    #2 == Engine ==
    connection_url = f"mssql+pyodbc:///?odbc_connect={quote_plus(conn_sqlserver)}"
    engine = sa.create_engine(connection_url)
    print("[+] Motor de conexión creado.\n\n")

    #3 == Query ==
    df = pd.read_sql_query("SELECT * FROM dbo.tickets", engine)
    df_cesta = df[['id_pedido','nombre_producto']]
    df_group = df_cesta.groupby('id_pedido')['nombre_producto'].apply(lambda producto: ','.join(producto))
    df_transacciones = df_group.str.get_dummies(sep=',')
    soporte = df_transacciones.mean() * 100

    def confianza(antecedente, consecuente):
        # Casos donde se compraron ambos productos
        conjunto_ac = df_transacciones[(df_transacciones[antecedente] == 1) &
                                    (df_transacciones[consecuente] == 1)]
        # Confianza = compras conjuntas / compras de producto A
        return len(conjunto_ac) / df_transacciones[antecedente].sum()
    
    # Función para calcular el lift entre dos productos en la muestra
    def lift(antecedente, consecuente):
        soporte_a = df_transacciones[antecedente].mean()
        soporte_c = df_transacciones[consecuente].mean()
        conteo_ac = len(df_transacciones[(df_transacciones[antecedente] == 1) &
                                    (df_transacciones[consecuente] == 1)])
        soporte_ac = conteo_ac / len(df_transacciones)
        return soporte_ac / (soporte_a * soporte_c)
    
    # Definir un umbral para la confianza mínima
    umbral_confianza = 0.05
    asociaciones = []

    # Generar combinaciones de productos y calcular confianza y lift
    for antecedente, consecuente in combinations(df_transacciones.columns, 2):

        # Soporte del antecedente
        soporte_a = df_transacciones[antecedente].mean()

        # Calcular confianza
        conf = confianza(antecedente, consecuente)
        if conf > umbral_confianza:
            asociaciones.append({
                'antecedente': antecedente,
                'consecuente': consecuente,
                'soporte_a': round(soporte_a * 100,1),
                'confianza': round(conf * 100,1),
                'lift': round(lift(antecedente, consecuente),1)
            })


    # Convertir las asociaciones en un DataFrame
    df_asociaciones = pd.DataFrame(asociaciones)

    # Crear una tabla con los productos únicos y las columnas correspondientes
    productos_unicos = df[['id_producto', 'id_seccion', 'id_departamento', 'nombre_producto']].drop_duplicates()
    df_asociaciones_enriquecido = df_asociaciones.merge(productos_unicos, left_on='antecedente', right_on='nombre_producto', how='left').drop(columns=['nombre_producto'])
    df_asociaciones_enriquecido.columns = ['antecedente', 'consecuente', 'soporte_a', 'confianza', 'lift', 'id_producto_a', 'id_seccion_a', 'id_departamento_a']

    df_asociaciones_enriquecido.to_csv('reglas.csv', index=False, sep=';', decimal=',')
    print(df_asociaciones_enriquecido)

except Exception as ex:
    print("\n[x] Err connection: ", ex)
