#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import numpy as np
import cv2
import os
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
from flask import Flask, request, jsonify, send_from_directory, Response
from database import ConexaoBancoDados, Consulta, Paciente, Medico, Prediagnostico, MRIAnalysis
from prediction_model import predict_tumor_type, allowed_file 
from hemo_utils import make_prediction
from werkzeug.utils import secure_filename
from joblib import load
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



all_features = ['Patient age quantile', 'Hematocrit', 'Hemoglobin', 'Platelets', 'Mean platelet volume ',
 'Red blood Cells', 'Lymphocytes', 'Mean corpuscular hemoglobin concentration\xa0(MCHC)',
 'Leukocytes', 'Basophils', 'Mean corpuscular hemoglobin (MCH)', 'Eosinophils',
 'Mean corpuscular volume (MCV)', 'Monocytes', 'Red blood cell distribution width (RDW)',
 'Neutrophils', 'Urea', 'Proteina C reativa mg/dL', 'Creatinine', 'Potassium', 'Sodium',
 'Respiratory Syncytial Virus_not_detected', 'Influenza A_not_detected', 'Influenza B_not_detected',
 'CoronavirusNL63_not_detected', 'Rhinovirus/Enterovirus_not_detected', 'Coronavirus HKU1_not_detected',
 'Parainfluenza 3_not_detected', 'Adenovirus_not_detected', 'Parainfluenza 4_not_detected',
 'Coronavirus229E_not_detected', 'CoronavirusOC43_not_detected', 'Inf A H1N1 2009_not_detected',
 'Metapneumovirus_not_detected', 'Random']


important_features = ['Leukocytes', 'Platelets', 'Mean platelet volume', 'Eosinophils', 'Proteina C reativa mg/dL']


model = load(r'C:\Users\pytho\Documents\GitHub\GS-ADS-DOS-CRIA\AI & CHATBOT\Hemograma\Model\RandomForest.joblib')




UPLOAD_FOLDER = r'BUILDING RELATIONAL DATABASE\MRI'  # Defina o caminho para o diretório de uploads
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

db = ConexaoBancoDados()



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Rotas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
def initialize_routes(app):

    @app.route('/hello', methods=['GET'])
    def HelloWorld():
        return 'Hello World'



    rwd =r'C:\Users\pytho\Documents\GitHub\GS-ADS-DOS-CRIA\RESPONSIVE WEB DEVELOPMENT'


    @app.route('/', methods=['GET', 'POST'])
    def home():
        return send_from_directory(rwd, 'medico.html')



    @app.route('/upload', methods=['POST'])
    def upload_file():
        if 'file' not in request.files:
            return jsonify({"error": "Sem arquivo"}), 400
        file = request.files['file']
        if file.filename == '':
            return jsonify({"error": "Arquivo não encontrado"}), 400
        if file and allowed_file(file.filename):
            # Converte a imagem para um formato que OpenCV pode ler
            in_memory_file = np.frombuffer(file.read(), np.uint8)
            img = cv2.imdecode(in_memory_file, cv2.IMREAD_COLOR)
            
            # Chama a função de predição
            tumor_probability, tumor_type = predict_tumor_type(img)

            # Salva o arquivo no sistema de arquivos
            filename = secure_filename(file.filename)
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)

            # Salvar no banco de dados
            MRIAnalysis.salvar_analise(file_path, tumor_probability, tumor_type)
            tumor_probability, tumor_type = predict_tumor_type(img)
            return jsonify({
                "message": "Upload e analise realizados com sucesso", 
                "tumor_probability": float(tumor_probability),  # Converta para float aqui
                "tumor_type": tumor_type
            }), 200









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



    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Hemo-Cov❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


    @app.route('/predict', methods=['POST'])
    def predict():
        # Receber dados do formulário
        data = request.form.to_dict()
        
        # Converter os valores para o tipo correto (float, neste caso)
        for key in data.keys():
            data[key] = float(data[key])

        # Chamar a função de previsão
        try:
            prediction = make_prediction(input_features=data,
                                         model=model,
                                         all_features=all_features,
                                         important_features=important_features)

            return jsonify({'prediction': prediction.tolist() if isinstance(prediction, np.ndarray) else prediction})
        except ValueError as e:
            return jsonify({'error': str(e)}), 400
        
        


