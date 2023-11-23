#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import cx_Oracle
import os
from dotenv import load_dotenv
from database import ConexaoBancoDados
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Paciente❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class Paciente:
    @staticmethod
    def criar_paciente(data):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, logradouro, bairro, cep, complemento, numero, uf, cidade, plano_saude, historico_medico) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16)"
                    cursor.execute(query, data)
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao criar paciente:", e)

    @staticmethod
    def ler_pacientes():
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    cursor.execute("SELECT * FROM paciente")
                    return cursor.fetchall()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao ler pacientes:", e)
            return []

    @staticmethod
    def atualizar_paciente(id, data):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "UPDATE paciente SET nome = :1, cpf = :2, dt_nascimento = :3, sexo = :4, email = :5, telefone = :6, logradouro = :7, bairro = :8, cep = :9, complemento = :10, numero = :11, uf = :12, cidade = :13, plano_saude = :14, historico_medico = :15 WHERE id = :16"
                    cursor.execute(query, data + (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao atualizar paciente:", e)

    @staticmethod
    def excluir_paciente(id):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "DELETE FROM paciente WHERE id = :1"
                    cursor.execute(query, (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao excluir paciente:", e)
            
            
    @staticmethod
    def email_existe(email):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    cursor.execute("SELECT COUNT(*) FROM paciente WHERE email = :1", (email,))
                    (count,) = cursor.fetchone()
                    return count > 0
        except cx_Oracle.DatabaseError as e:
            print("Erro ao verificar email:", e)
            return False
