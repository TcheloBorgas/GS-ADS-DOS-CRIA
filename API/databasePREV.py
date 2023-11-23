#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import cx_Oracle
import os
from dotenv import load_dotenv
from database import ConexaoBancoDados
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━





#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Prediagnostico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class MRIAnalysis:
    @staticmethod
    def salvar_analise(image_path, tumor_probability, tumor_type):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "INSERT INTO mri_analyses (image_path, tumor_probability, tumor_type) VALUES (:1, :2, :3)"
                    cursor.execute(query, (image_path, tumor_probability, tumor_type))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao salvar análise de MRI:", e)



class Prediagnostico:
    @staticmethod
    def criar_prediagnostico(data):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes, paciente_id, medico_id) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9)"
                    cursor.execute(query, data)
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao criar prediagnóstico:", e)

    @staticmethod
    def ler_prediagnosticos():
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    cursor.execute("SELECT * FROM prediagnostico")
                    return cursor.fetchall()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao ler prediagnósticos:", e)
            return []

    @staticmethod
    def atualizar_prediagnostico(id, data):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "UPDATE prediagnostico SET descricao = :1, data_diagnostico = :2, resultado = :3, tratamento_recomendado = :4, setor_recomendado = :5, observacoes = :6, paciente_id = :7, medico_id = :8 WHERE id = :9"
                    cursor.execute(query, data + (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao atualizar prediagnóstico:", e)

    @staticmethod
    def excluir_prediagnostico(id):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "DELETE FROM prediagnostico WHERE id = :1"
                    cursor.execute(query, (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao excluir prediagnóstico:", e)