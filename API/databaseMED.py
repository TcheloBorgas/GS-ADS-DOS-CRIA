#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import cx_Oracle
import os
from dotenv import load_dotenv
from database import ConexaoBancoDados
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Medico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


class Medico:
    @staticmethod
    def criar_medico(data):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "INSERT INTO medico (id, nome, email, crm, especialidade, telefone, logradouro, bairro, cep, complemento, numero, uf, cidade, consulta_id, prediagnostico_id) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15)"
                    cursor.execute(query, data)
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao criar médico:", e)

    @staticmethod
    def ler_medicos():
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    cursor.execute("SELECT * FROM medico")
                    return cursor.fetchall()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao ler médicos:", e)
            return []

    @staticmethod
    def atualizar_medico(id, data):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "UPDATE medico SET nome = :1, email = :2, crm = :3, especialidade = :4, telefone = :5, logradouro = :6, bairro = :7, cep = :8, complemento = :9, numero = :10, uf = :11, cidade = :12, consulta_id = :13, prediagnostico_id = :14 WHERE id = :15"
                    cursor.execute(query, data + (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao atualizar médico:", e)

    @staticmethod
    def excluir_medico(id):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "DELETE FROM medico WHERE id = :1"
                    cursor.execute(query, (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao excluir médico:", e)
    
    
    @staticmethod
    def email_existe(email):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    cursor.execute("SELECT COUNT(*) FROM medico WHERE email = :1", (email,))
                    (count,) = cursor.fetchone()
                    return count > 0
        except cx_Oracle.DatabaseError as e:
            print("Erro ao verificar email:", e)
            return False