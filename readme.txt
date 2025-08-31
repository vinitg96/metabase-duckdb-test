visualização metabase na gold
python orquestrando e logando os status do dw
colocar tudo em um docker compose
https://github.com/DataWithBaraa/sql-data-warehouse-project/blob/main/scripts/silver/proc_load_silver.sql


docker run --name metaduck -v /home/vinicius/workspace/projetos/dw_baraa/database/:/home/database -d -p 80:3000 -m 2GB -e MB_PLUGINS_DIR=/home/plugins metaduck

https://github.com/motherduckdb/metabase_duckdb_driver



docker build -f Dockerfile_etl -t etl-duckdb .
docker run --rm -v $(pwd)/database:/app/database etl-duckdb


-------------------------------- PORTA --------------
A sintaxe do -p é sempre:

-p <porta_host>:<porta_container>


porta_host → porta do seu computador (host), que você vai acessar no navegador.

porta_container → porta dentro do container onde o serviço realmente roda.

No seu caso:

Componente	Porta
Host	80
Container	3000
🔹 O que isso significa

O Metabase dentro do container escuta na porta 3000 (padrão).

Docker redireciona tudo que chega na porta 80 do host para a porta 3000 do container.

Ou seja, quando você digitar no navegador http://localhost, você está acessando o Metabase.

🔹 URLs possíveis

Usando porta padrão do host 80

http://localhost


Não precisa digitar a porta, porque 80 é padrão do HTTP.

Se tivesse usado outra porta, ex.: 8080:3000

-p 8080:3000


URL seria:

http://localhost:8080