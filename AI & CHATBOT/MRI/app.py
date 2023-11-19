#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import numpy as np
import tensorflow as tf
import cv2
import cx_Oracle
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
from flask import Flask, request, jsonify, send_from_directory, Response


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

app = Flask(__name__)
model = tf.keras.models.load_model('AI & CHATBOT\MRI\Model\model.h5')


CATEGORIAS = ["tumor_glioma", "tumor_meningioma", "sem_tumor", "tumor_hipofisário"]
IMG_SIZE = 224

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


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


# Substitua estas variáveis pelos seus dados de conexão reais
username = '98370'
password = '140602'
hostname = 'oracle.fecap.br'
port = 1521         # Porto padrão do Oracle é 1521, mas verifique o correto para o seu caso
sid = 'orcl'     # SID do banco de dados

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

def create_entry(data):
    # Esta função cria uma nova entrada no banco de dados
    with connection.cursor() as cursor:
        # Substitua 'your_table' e os nomes dos campos pelas suas informações específicas
        query = "INSERT INTO your_table (field1, field2) VALUES (:1, :2)"
        cursor.execute(query, data)
    connection.commit()

def read_entries():
    # Esta função lê entradas do banco de dados
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM your_table")
        result = cursor.fetchall()
    return result

def update_entry(id, data):
    # Esta função atualiza uma entrada existente
    with connection.cursor() as cursor:
        # Substitua 'your_table', 'field1', 'field2' e 'id_field' pelas suas informações específicas
        query = "UPDATE your_table SET field1 = :1, field2 = :2 WHERE id_field = :3"
        cursor.execute(query, data + (id,))
    connection.commit()

def delete_entry(id):
    # Esta função deleta uma entrada do banco de dados
    with connection.cursor() as cursor:
        query = "DELETE FROM your_table WHERE id_field = :1"
        cursor.execute(query, (id,))
    connection.commit()



# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Rotas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
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

@app.route('/create', methods=['POST'])
def create():
    data = request.get_json()
    create_entry((data['field1'], data['field2']))
    return jsonify({"message": "Entrada criada com sucesso"}), 201

@app.route('/read', methods=['GET'])
def read():
    entries = read_entries()
    return jsonify(entries)

@app.route('/update/<int:id>', methods=['PUT'])
def update(id):
    data = request.get_json()
    update_entry(id, (data['field1'], data['field2']))
    return jsonify({"message": "Entrada atualizada com sucesso"})

@app.route('/delete/<int:id>', methods=['DELETE'])
def delete(id):
    delete_entry(id)
    return jsonify({"message": "Entrada deletada com sucesso"})

#━━━━━━━━━━━━━━━━━━━━━❮Iniciar❯━━━━━━━━━━━━━━━━━━━━

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
    
    
    
    
    
    





