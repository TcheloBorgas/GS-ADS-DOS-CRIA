#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import numpy as np
import cv2
import database as db
from flask import Flask, request, jsonify, send_from_directory, Response
from database import get_db_connection
from prediction_model import predict_tumor_type

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Rotas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
def initialize_routes(app):

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


    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




    # Rota para criar uma nova consulta
    @app.route('/consulta/create', methods=['POST'])
    def create_consulta_route():
        data = request.json
        db.create_consulta(data)
        return jsonify({"message": "Consulta criada com sucesso!"}), 201

    # Rota para ler todas as consultas
    @app.route('/consulta/read', methods=['GET'])
    def read_consultas_route():
        consultas = db.read_consultas()
        return jsonify(consultas), 200

    # Rota para atualizar uma consulta
    @app.route('/consulta/update/<int:id>', methods=['PUT'])
    def update_consulta_route(id):
        data = request.json
        dc.update_consulta(id, data)
        return jsonify({"message": "Consulta atualizada com sucesso!"}), 200

    # Rota para deletar uma consulta
    @app.route('/consulta/delete/<int:id>', methods=['DELETE'])
    def delete_consulta_route(id):
        db.delete_consulta(id)
        return jsonify({"message": "Consulta deletada com sucesso!"}), 200



    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    @app.route('/paciente/create', methods=['POST'])
    def create_paciente_route():
        data = request.json
        db.create_paciente(data)
        return jsonify({"message": "Paciente criado com sucesso!"}), 201

    @app.route('/paciente/read', methods=['GET'])
    def read_pacientes_route():
        pacientes = db.read_pacientes()
        return jsonify(pacientes), 200

    @app.route('/paciente/update/<int:id>', methods=['PUT'])
    def update_paciente_route(id):
        data = request.json
        db.update_paciente(id, data)
        return jsonify({"message": "Paciente atualizado com sucesso!"}), 200

    @app.route('/paciente/delete/<int:id>', methods=['DELETE'])
    def delete_paciente_route(id):
        db.delete_paciente(id)
        return jsonify({"message": "Paciente deletado com sucesso!"}), 200


    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    @app.route('/medico/create', methods=['POST'])
    def create_medico_route():
        data = request.json
        db.create_medico(data)
        return jsonify({"message": "Médico criado com sucesso!"}), 201

    @app.route('/medico/read', methods=['GET'])
    def read_medicos_route():
        medicos = db.read_medicos()
        return jsonify(medicos), 200

    @app.route('/medico/update/<int:id>', methods=['PUT'])
    def update_medico_route(id):
        data = request.json
        db.update_medico(id, data)
        return jsonify({"message": "Médico atualizado com sucesso!"}), 200

    @app.route('/medico/delete/<int:id>', methods=['DELETE'])
    def delete_medico_route(id):
        db.delete_medico(id)
        return jsonify({"message": "Médico deletado com sucesso!"}), 200


    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


    # Rota para criar um novo pré-diagnóstico
    @app.route('/prediagnostico/create', methods=['POST'])
    def create_prediagnostico_route():
        data = request.json
        db.create_prediagnostico(data)
        return jsonify({"message": "Pré-diagnóstico criado com sucesso!"}), 201

    # Rota para ler todos os pré-diagnósticos
    @app.route('/prediagnostico/read', methods=['GET'])
    def read_prediagnosticos_route():
        prediagnosticos = db.read_prediagnosticos()
        return jsonify(prediagnosticos), 200

    # Rota para atualizar um pré-diagnóstico
    @app.route('/prediagnostico/update/<int:id>', methods=['PUT'])
    def update_prediagnostico_route(id):
        data = request.json
        db.update_prediagnostico(id, data)
        return jsonify({"message": "Pré-diagnóstico atualizado com sucesso!"}), 200

    # Rota para deletar um pré-diagnóstico
    @app.route('/prediagnostico/delete/<int:id>', methods=['DELETE'])
    def delete_prediagnostico_route(id):
        db.delete_prediagnostico(id)
        return jsonify({"message": "Pré-diagnóstico deletado com sucesso!"}), 200

    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




    @app.route('/sintoma/create', methods=['POST'])
    def create_sintoma_route():
        data = request.json
        db.create_sintoma(data)
        return jsonify({"message": "Sintoma criado com sucesso!"}), 201

    @app.route('/sintoma/read', methods=['GET'])
    def read_sintomas_route():
        sintomas = db.read_sintomas()
        return jsonify(sintomas), 200

    @app.route('/sintoma/update/<int:id>', methods=['PUT'])
    def update_sintoma_route(id):
        data = request.json
        db.update_sintoma(id, data)
        return jsonify({"message": "Sintoma atualizado com sucesso!"}), 200

    @app.route('/sintoma/delete/<int:id>', methods=['DELETE'])
    def delete_sintoma_route(id):
        db.delete_sintoma(id)
        return jsonify({"message": "Sintoma deletado com sucesso!"}), 200