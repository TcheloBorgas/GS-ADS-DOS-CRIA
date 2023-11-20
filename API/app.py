#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮Bibliotecas❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import os
from flask import Flask
from dotenv import load_dotenv
from routes import initialize_routes
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━❮◆❯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━❮Variaveis de ambiente❯━━━━━━━━
load_dotenv('db.env')

#━━━━━━━━❮Inicio de ambiente❯━━━━━━━━

app = Flask(__name__)


#━━━━━━━━❮Rotas❯━━━━━━━━
initialize_routes(app)


#━━━━━━━━❮Start❯━━━━━━━━

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
