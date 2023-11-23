from sqlalchemy import create_engine, Column, Integer, String, Date, ForeignKey, TIMESTAMP, Float
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from contextlib import contextmanager

# Definindo session_scope
@contextmanager
def session_scope():
    """Provide a transactional scope around a series of operations."""
    session = Session()
    try:
        yield session
        session.commit()
    except Exception as e:
        session.rollback()
        raise e
    finally:
        session.close()

# O resto do seu código, incluindo as funções que usam session_scope, vem aqui


from sqlalchemy import MetaData
# Conectar ao banco de dados Oracle
engine = create_engine("oracle+cx_oracle://rm98370:140602@oracle.fiap.com.br:1521/orcl")


Session = sessionmaker(bind=engine)
session = Session()
Base = declarative_base()

# Outras importações permanecem as mesmas
class Consulta(Base):
    __tablename__ = 'consulta'
    id = Column(Integer, primary_key=True, autoincrement=True)
    data_consulta = Column(Date, nullable=False)
    horario_consulta = Column(TIMESTAMP, nullable=False)
    paciente_id = Column(Integer)
    medico_id = Column(Integer)





    # Outras definições e funções devem seguir a mesma regra de indentação


# O resto do seu código permanece o mesmo



# Criar MetaData e refletir a estrutura do banco de dados
metadata = MetaData()
metadata.reflect(bind=engine)

# Definir a classe Consulta para mapear para a tabela existente
# class Consulta(Base):
#     __table__ = metadata.tables['consulta']

# Resto do código permanece o mesmo
from datetime import datetime

# Agora você pode usar datetime.strptime para converter strings em objetos datetime
data_consulta = datetime.strptime('2023-11-22', '%Y-%m-%d').date()



# Create
def create_consulta(data_consulta, horario_consulta, paciente_id, id_prediagnostico, medico_id):
    nova_consulta = Consulta(
        data_consulta=data_consulta, 
        horario_consulta=horario_consulta, 
        paciente_id=paciente_id, 
        id_prediagnostico=id_prediagnostico, 
        medico_id=medico_id
    )
    session.add(nova_consulta)
    session.commit()

# Read
def get_consulta_by_id(consulta_id):
    return session.query(Consulta).filter(Consulta.id == consulta_id).first()

# Update
def update_consulta(consulta_id, **kwargs):
    consulta = session.query(Consulta).filter(Consulta.id == consulta_id).first()
    for key, value in kwargs.items():
        setattr(consulta, key, value)
    session.commit()

# Delete
def delete_consulta(consulta_id):
    consulta = session.query(Consulta).filter(Consulta.id == consulta_id).first()
    session.delete(consulta)
    session.commit()

# Lembre-se de criar as tabelas no banco de dados
Base.metadata.create_all(engine)


from datetime import datetime

# Função para adicionar uma nova consulta
# def adicionar_consulta():
#     nova_consulta = Consulta(
#         id=1,
#         data_consulta=datetime.strptime('2023-11-22', '%Y-%m-%d').date(),
#         horario_consulta=datetime.strptime('2023-11-22 09:00:00', '%Y-%m-%d %H:%M:%S'),
#         paciente_id=1,
#         id_prediagnostico=1,
#         medico_id=1
#     )
#     session.add(nova_consulta)
#     session.commit()
#     print("Consulta adicionada com sucesso.")
# id_prediagnostico = Column('id_prediagnostico', Integer)  # Se o nome estiver exatamente assim no Oracle









from sqlalchemy import text


# Função para adicionar uma nova consulta
def adicionar_consulta(id, data_consulta, horario_consulta, paciente_id, medico_id):
    with session_scope() as session:
        nova_consulta = Consulta(
            id=id,
            data_consulta=data_consulta,
            horario_consulta=horario_consulta,
            paciente_id=paciente_id,
            medico_id=medico_id
        )
        session.add(nova_consulta)
        session.commit()
        print("Consulta adicionada com sucesso.")















# Função para buscar uma consulta pelo ID
def buscar_consulta(consulta_id):
    consulta = session.query(Consulta).filter(Consulta.id == consulta_id).first()
    if consulta:
        print(f"Consulta encontrada: {consulta.id}, {consulta.data_consulta}, {consulta.horario_consulta}")
    else:
        print("Consulta não encontrada.")

# Função para atualizar uma consulta
def atualizar_consulta(consulta_id, novo_horario):
    consulta = session.query(Consulta).filter(Consulta.id == consulta_id).first()
    if consulta:
        consulta.horario_consulta = novo_horario
        session.commit()
        print("Consulta atualizada com sucesso.")
    else:
        print("Consulta não encontrada para atualização.")

# Função para deletar uma consulta
def deletar_consulta(consulta_id):
    consulta = session.query(Consulta).filter(Consulta.id == consulta_id).first()
    if consulta:
        session.delete(consulta)
        session.commit()
        print("Consulta deletada com sucesso.")
    else:
        print("Consulta não encontrada para deletar.")

# Testando as funções
# Exemplo de chamada da função com argumentos
adicionar_consulta(
    id =55,
    data_consulta=datetime.strptime('2023-11-22', '%Y-%m-%d').date(),
    horario_consulta=datetime.strptime('2023-11-22 09:00:00', '%Y-%m-%d %H:%M:%S'),
    paciente_id=1,
    medico_id=1
)


# buscar_consulta(1)
# atualizar_consulta(1, datetime.strptime('2023-11-22 10:30:00', '%Y-%m-%d %H:%M:%S'))
# buscar_consulta(1)
# deletar_consulta(1)
# buscar_consulta(1)


