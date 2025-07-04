
# Use uma imagem oficial do Python como imagem base.
# A versão 'slim' é menor que a padrão e a 3.12 é uma versão estável recente.
# A imagem base foi corrigida de 'PYTHON' para 'python'.
FROM python:3.12-slim

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Isso é feito primeiro para aproveitar o cache de camadas do Docker.
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir reduz o tamanho da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para o mundo fora deste contêiner
EXPOSE 8000

# Define o comando para executar a aplicação
# Use 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
# A flag --reload é para desenvolvimento, então foi removida para uma imagem de produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

