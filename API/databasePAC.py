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
                    query = """
                    INSERT INTO paciente (
                        id, nome, cpf, dt_nascimento, email, telefone,
                        historico_medico, id_endereco, id_planosaude, 
                        id_prediagnostico, id_especialidade, consulta_id
                    ) VALUES (
                        :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12
                    )
                    """
                    cursor.execute(query, data)
                conexao.commit()
                print('Paciente Criado')
        except cx_Oracle.DatabaseError as e:
            print("Erro ao criar paciente:", e)



    @staticmethod
    def ler_pacientes():
        try:
            with ConexaoBancoDados() as conexao:
                with conexao.cursor() as cursor:
                    cursor.execute("SELECT * FROM paciente")
                    print('Pacientes:')
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
                print('Paciente Atualizado')
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
                print('Paciente deletado')
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

    
from datetime import datetime

def formatar_data(data_string):
    # Supondo que a data esteja em formato 'YYYY-MM-DD'
    data_formatada = datetime.strptime(data_string, '%Y-%m-%d').strftime('%d-%b-%Y')  # Convertendo para 'DD-MMM-YYYY'
    return data_formatada.upper()  # Oracle geralmente espera o mês em maiúsculo




def testar_classe_paciente():
    # Ajuste dos dados para teste
    cpf = '123.456.789-00'
    cpf_formatado = cpf.replace('.', '').replace('-', '')  # Remove pontos e traços
    data_nascimento_formatada = formatar_data('2000-01-01')
    sexo = 'M'

    dados_criacao = (
        1, 'Nome Teste', cpf_formatado, data_nascimento_formatada, 'teste@teste.com',
        '1234567890', 'Histórico Médico Teste', 1, 1, 1, 1, 1, sexo
    )

    # Verifique se o número de elementos em dados_criacao corresponde ao número de placeholders na consulta
    if len(dados_criacao) != 12:
        print("Erro: O número de dados fornecidos não corresponde ao número de campos na consulta SQL.")
        return

    Paciente.criar_paciente(dados_criacao)
    print("Teste de criação de paciente realizado.")

# Executar a função de teste
# testar_classe_paciente()



    # # Testar a leitura de pacientes
    # pacientes = Paciente.ler_pacientes()
    # print("Teste de leitura de pacientes realizado. Pacientes:", pacientes)

    # # Testar a atualização de um paciente
    # dados_atualizacao = ('Nome Atualizado', '987.654.321-00', '2001-02-02', 'F', 'atualizado@teste.com', '0987654321', 'Rua Atualizada', 'Bairro Atualizado', '87654-321', 'Complemento Atualizado', '321', 'UF', 'Cidade Atualizada', 'Plano Saúde Atualizado', 'Histórico Médico Atualizado')
    # Paciente.atualizar_paciente(1, dados_atualizacao)
    # print("Teste de atualização de paciente realizado.")

    # Testar a exclusão de um paciente
    # Paciente.excluir_paciente(1)
    # print("Teste de exclusão de paciente realizado.")

    # # Testar a verificação da existência de um email
    # email_existe = Paciente.email_existe('teste@teste.com')
    # print("Teste de verificação de email realizado. Email existe:", email_existe)

# Executar a função de teste
testar_classe_paciente()




