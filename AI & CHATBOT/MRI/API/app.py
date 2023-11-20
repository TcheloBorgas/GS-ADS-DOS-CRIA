#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import os
from flask import Flask
from dotenv import load_dotenv
from routes import initialize_routes
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Carrega as variáveis de ambiente
load_dotenv('db.env')

app = Flask(__name__)


# Inicializando rotas
initialize_routes(app)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
