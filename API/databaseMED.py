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
                    query = "INSERT INTO medico (id, nome, email,  telefone, crm) VALUES (:1, :2, :3, :4, :5)"
                conexao.commit()
                print('Medico Criado')
        except cx_Oracle.DatabaseError as e:
            print("Erro ao criar médico:", e)




    @staticmethod
    def ler_medicos():
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    cursor.execute("SELECT * FROM medico")
                    print('Lendo Medicos')
                    return cursor.fetchall()
                
        except cx_Oracle.DatabaseError as e:
            print("Erro ao ler médicos:", e)
            return []

    @staticmethod
    def atualizar_medico(id, data):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    # Corrija a consulta removendo a coluna duplicada 'telefone'
                    query = "UPDATE medico SET nome = :1, email = :2, telefone = :3, crm = :4 WHERE id = :5"
                    # Certifique-se de que a ordem e o número de valores em 'data + (id,)' correspondam aos placeholders
                    cursor.execute(query, data + (id,))
                    print('Medico Atualizado')
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
                print('Medico excluido')
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
        
        
    