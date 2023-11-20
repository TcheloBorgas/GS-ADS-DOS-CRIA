#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import pandas as pd
from joblib import load
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Variaveis de controle❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


model = load(r'C:\Users\pytho\Documents\GitHub\GS-ADS-DOS-CRIA\AI & CHATBOT\Hemograma\Model\RandomForest.joblib')


important_features = ['Leukocytes', 'Platelets', 'Mean platelet volume', 'Eosinophils', 'Proteina C reativa mg/dL']


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


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Função❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


def make_prediction(input_features, model, all_features, important_features):
    """
    Faz uma previsão com base nas entradas do usuário
    param input_features: Um dicionário com as características importantes e seus valores
    param model: O modelo de classificação treinado para fazer a previsão
    param all_features: Lista de todas as características usadas para treinar o modelo
    param important_features: Lista das características importantes que o usuário deve fornecer
    return: A previsão do modelo
    """
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # Verificar se todas as características importantes foram fornecidas
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    for feature in important_features:
        if feature not in input_features:
            raise ValueError(f"Faltando valor para a característica importante: {feature}")
        
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                # Converter as entradas do usuário em um DataFrame
    user_input_df = pd.DataFrame([input_features])
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Adicionar colunas faltantes e organizar as colunas na mesma ordem do treinamento
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    for feature in all_features:
        if feature not in user_input_df.columns:
            user_input_df[feature] = 0  # Preencher com um valor padrão
    user_input_df = user_input_df[all_features]

    prediction = model.predict(user_input_df)

    return prediction






