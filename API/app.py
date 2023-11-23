#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import os
from flask import Flask
from dotenv import load_dotenv
from routes import initialize_routes
from routesAI import initialize_routes_AI
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━❮Variaveis de ambiente❯━━━━━━━━
load_dotenv('db.env')

UPLOAD_FOLDER = r'BUILDING RELATIONAL DATABASE\MRI'  # Defina o caminho para o diretório de uploads
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

#━━━━━━━━❮Inicio de ambiente❯━━━━━━━━

app = Flask(__name__)


app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

#━━━━━━━━❮Rotas❯━━━━━━━━
initialize_routes(app)
initialize_routes_AI(app)

#━━━━━━━━❮Start❯━━━━━━━━

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
