import duckdb
import os
import time
from utils.logs import configurar_logger
from loguru import logger
from utils.tratamento_erros import tratar_erros, log_stage

            #print(f"Iniciando {tabela}")
            # start = time.time()
            # try:
            #     read_and_execute_query(PATH, conn)
            # except Exception as e:
            #     print(f"Camada {camada} - Erro ao executar {tabela}: {e.__class__} - {e} ")
            #tempo_decorrido = time.time() - start
            #print(f"{tabela} executado {tempo_decorrido:.2f} segundos")
@tratar_erros
def read_and_execute_query(PATH_arquivo:str, conn = duckdb.DuckDBPyConnection ) -> None:
    """Ler querie apartir de um arquivo e retorna uma string"""
    with open(PATH_arquivo, 'r') as fh:
        query = fh.read()
    conn.execute(query=query)
    conn.commit()
    return True


def main():
    configurar_logger()
    conn = duckdb.connect(database='./database/dw.duckdb')
    for camada in ['bronze', 'silver', 'gold']:
        for tabela in sorted(os.listdir(camada)):
            PATH = os.path.join(camada,tabela)
            read_and_execute_query(PATH, conn)

    conn.close()


if __name__ == '__main__':
    main()