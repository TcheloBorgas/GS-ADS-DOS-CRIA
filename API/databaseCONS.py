#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import cx_Oracle
import os
from dotenv import load_dotenv
from database import ConexaoBancoDados
from datetime import datetime
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Consulta❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Consulta❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class Consulta:
    @staticmethod
    def verificar_existencia_medico_paciente(medico_id, paciente_id):
        with ConexaoBancoDados() as conexao:
            with conexao.cursor() as cursor:
                # Verificar se o médico existe
                cursor.execute("SELECT id FROM medico WHERE id = :1", [medico_id])
                if not cursor.fetchone():
                    print(f"Erro: Médico com ID {medico_id} não encontrado.")
                    return False

                # Verificar se o paciente existe
                cursor.execute("SELECT id FROM paciente WHERE id = :1", [paciente_id])
                if not cursor.fetchone():
                    print(f"Erro: Paciente com ID {paciente_id} não encontrado.")
                    return False

        return True

    @staticmethod
    def criar_consulta(data):
        medico_id, paciente_id = data[4], data[3]
        if not Consulta.verificar_existencia_medico_paciente(medico_id, paciente_id):
            return

        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "INSERT INTO consulta (id, data_consulta, horario_consulta, paciente_id, medico_id) VALUES (:1, :2, :3, :4, :5)"
                    cursor.execute(query, data)
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao criar consulta:", e)
            
            
    @staticmethod
    def ler_consultas():
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    cursor.execute("SELECT * FROM consulta")
                    return cursor.fetchall()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao ler consultas:", e)
            return []
        


    @staticmethod
    def atualizar_consulta(id_consulta, data_atualizacao):
        # Convertendo string de data para objeto date
        data_consulta = datetime.strptime(data_atualizacao[0], '%Y-%m-%d').date()
        
        # Convertendo string de hora para objeto datetime com data padrão
        horario_consulta = datetime.combine(date.today(), datetime.strptime(data_atualizacao[1], '%H:%M').time())

        paciente_id, medico_id = data_atualizacao[2], data_atualizacao[3]

        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "UPDATE consulta SET data_consulta = :1, horario_consulta = :2, paciente_id = :3, medico_id = :4 WHERE id = :5"
                    cursor.execute(query, (data_consulta, horario_consulta, paciente_id, medico_id, id_consulta))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao atualizar consulta:", e)
            
            
    def excluir_consulta(id):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "DELETE FROM consulta WHERE id = :1"
                    cursor.execute(query, (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao excluir consulta:", e)