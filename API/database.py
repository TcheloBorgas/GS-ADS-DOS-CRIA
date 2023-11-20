#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import cx_Oracle
import os
from dotenv import load_dotenv

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Carrega as variáveis de ambiente
load_dotenv(r'C:\Users\pytho\Documents\GitHub\GS-ADS-DOS-CRIA\AI & CHATBOT\MRI\API\db.env')



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
        username = os.getenv('DB_USERNAME')
        password = os.getenv('DB_PASSWORD')
        hostname = os.getenv('DB_HOSTNAME')
        port = os.getenv('DB_PORT')
        sid = os.getenv('DB_SID')
        dsn = cx_Oracle.makedsn(hostname, port, sid=sid)
        self.conexao = cx_Oracle.connect(username, password, dsn)


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Consulta❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class Consulta:
    @staticmethod
    def criar_consulta(data):
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
    def atualizar_consulta(id, data):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "UPDATE consulta SET data_consulta = :1, horario_consulta = :2, paciente_id = :3, medico_id = :4 WHERE id = :5"
                    cursor.execute(query, data + (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao atualizar consulta:", e)

    @staticmethod
    def excluir_consulta(id):
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    query = "DELETE FROM consulta WHERE id = :1"
                    cursor.execute(query, (id,))
                conexao.commit()
        except cx_Oracle.DatabaseError as e:
            print("Erro ao excluir consulta:", e)




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


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Prediagnostico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



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







# # Exemplo de Uso
# dados_consulta = (1, '2023-01-01', '10:00', 1, 1)
# Consulta.criar_consulta(dados_consulta)
# dados_paciente = (1, 'Nome do Paciente', '12345678901', '1990-01-01', 'M', 'paciente@example.com', '123-456-7890', 'Rua do Paciente', 'Bairro', '12345-678', 'Complemento', '123', 'UF', 'Cidade', 'Plano de Saúde', 'Histórico Médico')
# Paciente.criar_paciente(dados_paciente)
# dados_medico = (1, 'Nome do Médico', 'medico@example.com', '12345', 'Especialidade', '987-654-3210', 'Rua do Médico', 'Bairro', '54321-876', 'Complemento', '321', 'UF', 'Cidade', 1, 1)
# Medico.criar_medico(dados_medico)
# dados_prediagnostico = (1, 'Descrição', '2023-01-01', 'Resultado', 'Tratamento', 'Setor', 'Observações', 1, 1)
# Prediagnostico.criar_prediagnostico(dados_prediagnostico)
