#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import cx_Oracle
import os
from dotenv import load_dotenv

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮SQL❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class ConexaoBancoDados:
    def __init__(self):
        self.conexao = None

    def __enter__(self):
        self.conectar()
        return self.conexao

    def __exit__(self, exc_type, exc_value, traceback):
        if self.conexao:
            self.conexao.close()

    def conectar(self):
        username = 'rm98370'
        password = '140602'
        hostname = 'oracle.fiap.com.br'
        port = '1521'
        sid = 'orcl'
        dsn = cx_Oracle.makedsn(hostname, port, sid=sid)
        self.conexao = cx_Oracle.connect(username, password, dsn)
        print('Conexão estabelecida')