#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import numpy as np
import cv2
import os
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
from flask import Flask, request, jsonify, send_from_directory, Response
from prediction_model import predict_tumor_type, allowed_file 
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
db = ConexaoBancoDados()



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Rotas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
def initialize_routes_AI(app):
    

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