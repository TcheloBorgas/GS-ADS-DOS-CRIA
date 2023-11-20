#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import numpy as np
import tensorflow as tf
import cv2
import cx_Oracle
import os
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
from flask import Flask, request, jsonify, send_from_directory, Response
from dotenv import load_dotenv
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

app = Flask(__name__)
model = tf.keras.models.load_model('AI & CHATBOT\MRI\Model\model.h5')


CATEGORIAS = ["tumor_glioma", "tumor_meningioma", "sem_tumor", "tumor_hipofisário"]
IMG_SIZE = 224

# Carrega as variáveis de ambiente
load_dotenv('db.env')

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Funções❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def prepare(image):
    new_array = cv2.resize(image, (IMG_SIZE, IMG_SIZE))  # Redimensiona a imagem
    return new_array.reshape(-1, IMG_SIZE, IMG_SIZE, 3)  # Redimensiona para o formato exigido pelo modelo


def predict_tumor_type(image):
    image = prepare(image)  # 'image' já é um objeto de imagem do OpenCV
    image = image / 255.0  # Normalização
    prediction = model.predict(image)
    prediction = np.argmax(prediction, axis=1)
    return CATEGORIAS[prediction[0]]


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮SQL❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

username = os.getenv('DB_USERNAME')
password = os.getenv('DB_PASSWORD')
hostname = os.getenv('DB_HOSTNAME')
port = os.getenv('DB_PORT')  
sid = os.getenv('DB_SID')    



dsn = cx_Oracle.makedsn(hostname, port, sid=sid)

connection = None
try:
    connection = cx_Oracle.connect(username, password, dsn)
    print("Conexão bem-sucedida!")
    # Código de interação com o banco de dados
except cx_Oracle.DatabaseError as e:
    print("Erro ao se conectar ao banco de dados Oracle:", e)
finally:
    if connection:
        connection.close()
        
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Consulta❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def create_consulta(data):
    with connection.cursor() as cursor:
        query = "INSERT INTO consulta (id, data_consulta, horario_consulta, paciente_id, medico_id) VALUES (:1, :2, :3, :4, :5)"
        cursor.execute(query, data)
    connection.commit()


def read_consultas():
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM consulta")
        return cursor.fetchall()


def update_consulta(id, data):
    with connection.cursor() as cursor:
        query = "UPDATE consulta SET data_consulta = :1, horario_consulta = :2, paciente_id = :3, medico_id = :4 WHERE id = :5"
        cursor.execute(query, data + (id,))
    connection.commit()



def delete_consulta(id):
    with connection.cursor() as cursor:
        query = "DELETE FROM consulta WHERE id = :1"
        cursor.execute(query, (id,))
    connection.commit()


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Paciente❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


def create_paciente(data):
    with connection.cursor() as cursor:
        query = "INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, logradouro, bairro, cep, complemento, numero, uf, cidade, plano_saude, historico_medico) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16)"
        cursor.execute(query, data)
    connection.commit()




def read_pacientes():
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM paciente")
        return cursor.fetchall()



def update_paciente(id, data):
    with connection.cursor() as cursor:
        query = "UPDATE paciente SET nome = :1, cpf = :2, dt_nascimento = :3, sexo = :4, email = :5, telefone = :6, logradouro = :7, bairro = :8, cep = :9, complemento = :10, numero = :11, uf = :12, cidade = :13, plano_saude = :14, historico_medico = :15 WHERE id = :16"
        cursor.execute(query, data + (id,))
    connection.commit()


def delete_paciente(id):
    with connection.cursor() as cursor:
        query = "DELETE FROM paciente WHERE id = :1"
        cursor.execute(query, (id,))
    connection.commit()



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Medico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def create_medico(data):
    with connection.cursor() as cursor:
        query = "INSERT INTO medico (id, nome, email, crm, especialidade, telefone, logradouro, bairro, cep, complemento, numero, uf, cidade, consulta_id, prediagnostico_id) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15)"
        cursor.execute(query, data)
    connection.commit()



def read_medicos():
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM medico")
        return cursor.fetchall()


def update_medico(id, data):
    with connection.cursor() as cursor:
        query = "UPDATE medico SET nome = :1, email = :2, crm = :3, especialidade = :4, telefone = :5, logradouro = :6, bairro = :7, cep = :8, complemento = :9, numero = :10, uf = :11, cidade = :12, consulta_id = :13, prediagnostico_id = :14 WHERE id = :15"
        cursor.execute(query, data + (id,))
    connection.commit()


def delete_medico(id):
    with connection.cursor() as cursor:
        query = "DELETE FROM medico WHERE id = :1"
        cursor.execute(query, (id,))
    connection.commit()


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Prediagnostico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

def create_prediagnostico(data):
    with connection.cursor() as cursor:
        query = "INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes, paciente_id, medico_id) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9)"
        cursor.execute(query, data)
    connection.commit()




def read_prediagnosticos():
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM prediagnostico")
        return cursor.fetchall()




def update_prediagnostico(id, data):
    with connection.cursor() as cursor:
        query = "UPDATE prediagnostico SET descricao = :1, data_diagnostico = :2, resultado = :3, tratamento_recomendado = :4, setor_recomendado = :5, observacoes = :6, paciente_id = :7, medico_id = :8 WHERE id = :9"
        cursor.execute(query, data + (id,))
    connection.commit()



def delete_prediagnostico(id):
    with connection.cursor() as cursor:
        query = "DELETE FROM prediagnostico WHERE id = :1"
        cursor.execute(query, (id,))
    connection.commit()









#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Rotas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
@app.route('/hello', methods=['GET'])
def HelloWorld():
    return 'Hello World'



rwd =r'C:\Users\pytho\Documents\GitHub\GS-ADS-DOS-CRIA\RESPONSIVE WEB DEVELOPMENT'


@app.route('/', methods=['GET', 'POST'])
def home():
    return send_from_directory(rwd, 'uga.html')


@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({"error": "Sem arquivo"}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "Arquivo não encontrado"}), 400
    if file:
        # Converte a imagem para um formato que OpenCV pode ler
        in_memory_file = np.frombuffer(file.read(), np.uint8)
        img = cv2.imdecode(in_memory_file, cv2.IMREAD_COLOR)
        
        # Chama a função de predição
        tumor_type = predict_tumor_type(img)
        return jsonify({"tumor_type": tumor_type}), 200


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Consulta❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


# Rota para criar uma nova consulta
@app.route('/consulta/create', methods=['POST'])
def create_consulta_route():
    data = request.json
    create_consulta(data)
    return jsonify({"message": "Consulta criada com sucesso!"}), 201

# Rota para ler todas as consultas
@app.route('/consulta/read', methods=['GET'])
def read_consultas_route():
    consultas = read_consultas()
    return jsonify(consultas), 200

# Rota para atualizar uma consulta
@app.route('/consulta/update/<int:id>', methods=['PUT'])
def update_consulta_route(id):
    data = request.json
    update_consulta(id, data)
    return jsonify({"message": "Consulta atualizada com sucesso!"}), 200

# Rota para deletar uma consulta
@app.route('/consulta/delete/<int:id>', methods=['DELETE'])
def delete_consulta_route(id):
    delete_consulta(id)
    return jsonify({"message": "Consulta deletada com sucesso!"}), 200



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Paciente❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

@app.route('/paciente/create', methods=['POST'])
def create_paciente_route():
    data = request.json
    create_paciente(data)
    return jsonify({"message": "Paciente criado com sucesso!"}), 201

@app.route('/paciente/read', methods=['GET'])
def read_pacientes_route():
    pacientes = read_pacientes()
    return jsonify(pacientes), 200

@app.route('/paciente/update/<int:id>', methods=['PUT'])
def update_paciente_route(id):
    data = request.json
    update_paciente(id, data)
    return jsonify({"message": "Paciente atualizado com sucesso!"}), 200

@app.route('/paciente/delete/<int:id>', methods=['DELETE'])
def delete_paciente_route(id):
    delete_paciente(id)
    return jsonify({"message": "Paciente deletado com sucesso!"}), 200


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Medico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

@app.route('/medico/create', methods=['POST'])
def create_medico_route():
    data = request.json
    create_medico(data)
    return jsonify({"message": "Médico criado com sucesso!"}), 201

@app.route('/medico/read', methods=['GET'])
def read_medicos_route():
    medicos = read_medicos()
    return jsonify(medicos), 200

@app.route('/medico/update/<int:id>', methods=['PUT'])
def update_medico_route(id):
    data = request.json
    update_medico(id, data)
    return jsonify({"message": "Médico atualizado com sucesso!"}), 200

@app.route('/medico/delete/<int:id>', methods=['DELETE'])
def delete_medico_route(id):
    delete_medico(id)
    return jsonify({"message": "Médico deletado com sucesso!"}), 200


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Pre-diagnóstico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


# Rota para criar um novo pré-diagnóstico
@app.route('/prediagnostico/create', methods=['POST'])
def create_prediagnostico_route():
    data = request.json
    create_prediagnostico(data)
    return jsonify({"message": "Pré-diagnóstico criado com sucesso!"}), 201

# Rota para ler todos os pré-diagnósticos
@app.route('/prediagnostico/read', methods=['GET'])
def read_prediagnosticos_route():
    prediagnosticos = read_prediagnosticos()
    return jsonify(prediagnosticos), 200

# Rota para atualizar um pré-diagnóstico
@app.route('/prediagnostico/update/<int:id>', methods=['PUT'])
def update_prediagnostico_route(id):
    data = request.json
    update_prediagnostico(id, data)
    return jsonify({"message": "Pré-diagnóstico atualizado com sucesso!"}), 200

# Rota para deletar um pré-diagnóstico
@app.route('/prediagnostico/delete/<int:id>', methods=['DELETE'])
def delete_prediagnostico_route(id):
    delete_prediagnostico(id)
    return jsonify({"message": "Pré-diagnóstico deletado com sucesso!"}), 200




#━━━━━━━━━━━━━━━━━━━━━❮Iniciar❯━━━━━━━━━━━━━━━━━━━━

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
    
    
    
    







