#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import numpy as np
import cv2
import os
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
from flask import Flask, request, jsonify, send_from_directory, Response
from database import ConexaoBancoDados
from databaseCONS import Consulta
from databaseMED import Medico
from databasePAC import Paciente
from databasePREV import Prediagnostico, MRIAnalysis
from prediction_model import predict_tumor_type, allowed_file 
from hemo_utils import make_prediction
from werkzeug.utils import secure_filename
from joblib import load
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



UPLOAD_FOLDER = r'BUILDING RELATIONAL DATABASE\MRI'  # Defina o caminho para o diretório de uploads
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

db = ConexaoBancoDados()



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Rotas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
def initialize_routes(app):

    @app.route('/hello', methods=['GET'])
    def HelloWorld():
        return 'Hello World'



    rwd =r'C:\Users\pytho\Documents\GitHub\GS-ADS-DOS-CRIA\RESPONSIVE WEB DEVELOPMENT'


    @app.route('/', methods=['GET'])
    def home():
        return app.send_static_file('index.html')





    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Consulta❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    @app.route('/consulta/create', methods=['POST'])
    def create_consulta_route():
        data = request.json
        Consulta.criar_consulta(data)
        return jsonify({"message": "Consulta criada com sucesso!"}), 201

    @app.route('/consulta/read', methods=['GET'])
    def read_consultas_route():
        with ConexaoBancoDados() as conexao:
            consultas = Consulta.ler_consultas()
        return jsonify(consultas), 200

    
    @app.route('/consulta/update/<int:id>', methods=['PUT'])
    def update_consulta_route(id):
        data = request.json
        Consulta.atualizar_consulta(id, data)
        return jsonify({"message": "Consulta atualizada com sucesso!"}), 200

    
    @app.route('/consulta/delete/<int:id>', methods=['DELETE'])
    def delete_consulta_route(id):
        Consulta.excluir_consulta(id)
        return jsonify({"message": "Consulta deletada com sucesso!"}), 200



    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Paciente❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    @app.route('/paciente/create', methods=['POST'])
    def create_paciente_route():
        data = request.json
        email = data.get("email")

        if Paciente.email_existe(email):
            return jsonify({"message": "Este email já existe"}), 409

        Paciente.criar_paciente(data)
        return jsonify({"message": "Paciente criado com sucesso!"}), 201





    @app.route('/paciente/read', methods=['GET'])
    def read_pacientes_route():
        pacientes = Paciente.ler_pacientes()
        return jsonify(pacientes), 200

    @app.route('/paciente/update/<int:id>', methods=['PUT'])
    def update_paciente_route(id):
        data = request.json
        Paciente.atualizar_paciente(id, data)
        return jsonify({"message": "Paciente atualizado com sucesso!"}), 200

    @app.route('/paciente/delete/<int:id>', methods=['DELETE'])
    def delete_paciente_route(id):
        Paciente.excluir_paciente(id)
        return jsonify({"message": "Paciente deletado com sucesso!"}), 200




    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Medico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    
    @app.route('/medico/create', methods=['POST'])
    def create_medico_route():
        data = request.json
        email = data.get("email")

        if Medico.email_existe(email):
            return jsonify({"message": "Este email já existe"}), 409

        Medico.criar_medico(data)
        return jsonify({"message": "Médico criado com sucesso!"}), 201


    @app.route('/medico/read', methods=['GET'])
    def read_medicos_route():
        medicos = Medico.ler_medicos()
        return jsonify(medicos), 200

    @app.route('/medico/update/<int:id>', methods=['PUT'])
    def update_medico_route(id):
        data = request.json
        Medico.atualizar_medico(id, data)
        return jsonify({"message": "Médico atualizado com sucesso!"}), 200

    @app.route('/medico/delete/<int:id>', methods=['DELETE'])
    def delete_medico_route(id):
        Medico.excluir_medico(id)
        return jsonify({"message": "Médico deletado com sucesso!"}), 200


    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Prediagnostico❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    
    @app.route('/prediagnostico/create', methods=['POST'])
    def create_prediagnostico_route():
        data = request.json
        Prediagnostico.criar_prediagnostico(data)
        return jsonify({"message": "Pré-diagnóstico criado com sucesso!"}), 201

    
    @app.route('/prediagnostico/read', methods=['GET'])
    def read_prediagnosticos_route():
        prediagnosticos = Prediagnostico.ler_prediagnosticos()
        return jsonify(prediagnosticos), 200

    
    @app.route('/prediagnostico/update/<int:id>', methods=['PUT'])
    def update_prediagnostico_route(id):
        data = request.json
        Prediagnostico.atualizar_prediagnostico(id, data)
        return jsonify({"message": "Pré-diagnóstico atualizado com sucesso!"}), 200
    
    
    @app.route('/prediagnostico/delete/<int:id>', methods=['DELETE'])
    def delete_prediagnostico_route(id):
        Prediagnostico.excluir_prediagnostico(id)
        return jsonify({"message": "Pré-diagnóstico deletado com sucesso!"}), 200

        
        


