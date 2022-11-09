# insurance-app
Projeto de app e api para pacotes de seguros: Campus Code - TreinaDev Delas!

## Tabela de Conteúdos
  * [Documentação da API](#documentação-da-api)
  * [Como rodar a aplicação](#como-rodar-a-aplicação)
  * [Informações adicionais](#informações-adicionais)

## Documentação da API

### Obter lista de Produtos

**Endpoint: GET /api/v1/products**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
0	
id	1
product_model	"TV 32"
launch_year	"2022"
brand	"LG"
price	"5000.0"
status	"active"
product_category_id	1
created_at	"2022-11-08T19:42:47.921Z"
updated_at	"2022-11-08T19:42:47.921Z"
1	
id	2
product_model	"TV 50"
launch_year	"2021"
brand	"SAMSUNG"
price	"8000.0"
status	"active"
product_category_id	1
created_at	"2022-11-08T19:43:08.381Z"
updated_at	"2022-11-08T19:43:08.381Z"
```

## Como rodar a aplicação

<p align = "justify"> No terminal, clone o projeto: </p>

```
$ git clone git@github.com:TreinaDev/insurance-app.git
```

<p align = "justify"> Entre na pasta do projeto: </p>

```
$ cd insurance-app
```

<p align = "justify"> Instale as dependencias: </p>

```
$ bin/setup
```

<p align = "justify"> Popule a aplicação: </p>

```
$ rails db:seed
```

<p align = "justify"> Visualize os testes: </p>

```
$ rspec
```

<p align = "justify"> Visualize no navegador: </p>

```
$ rails s
```

* Acesse http://localhost:3000/


## Informações adicionais

* Usuário administrador cadastrado: pessoa@empresa.com.br (senha: password)

* Usuário funcionário de seguradora cadastrado: funcionario@portoseguro.com.br (senha: password)

* Para todas categorias de distância, distância mínima é 100 m.

* Gems instaladas: bootstrap, capybara, devise, rspec, rubocop, factory_bot, simplecov

* Ruby: 3.1.2

* Rails: 7.0.4