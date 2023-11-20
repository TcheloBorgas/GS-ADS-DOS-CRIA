@echo off
setlocal enabledelayedexpansion

rem Caminho para o Oracle Instant Client
set ORACLE_PATH=C:\instantclient_21_12

rem Salva o valor atual da variável PATH
set OLD_PATH=%PATH%

rem Define a variável PATH temporariamente com o caminho do Oracle Instant Client
set PATH=%ORACLE_PATH%;%PATH%

rem Execute o seu programa ou script que requer o Oracle Instant Client
python 'c:\Users\pytho\Documents\GitHub\GS-ADS-DOS-CRIA\AI & CHATBOT\MRI\API\app.py'

rem Restaura o valor original da variável PATH
set PATH=%OLD_PATH%

endlocal
