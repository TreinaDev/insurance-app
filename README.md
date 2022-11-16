# insurance-app
Projeto de app e api para pacotes de seguros: Campus Code - TreinaDev Delas!

## Tabela de Conteúdos
  * [Documentação API](#documentação-da-api)
  * [Como rodar a aplicação](#como-rodar-a-aplicação)
  * [Informações adicionais](#informações-adicionais)
  * [Regras de negócio](#regras-de-negócio)

## Documentação da API

### Obter lista de Produtos

**Endpoint: GET /api/v1/products**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
[
  {
    "id":1,
    "product_model":"TV 32",
    "launch_year":"2022",
    "brand":"LG",
    "price":"5000.0",
    "status":"active",
    "product_category_id":1,
    "created_at":"2022-11-08T19:42:47.921Z",
    "updated_at":"2022-11-08T19:42:47.921Z"
  },
  {
    "id":2,
    "product_model":"TV 50",
    "launch_year":"2021",
    "brand":"SAMSUNG",
    "price":"8000.0",
    "status":"active",
    "product_category_id":1,
    "created_at":"2022-11-08T19:43:08.381Z",
    "updated_at":"2022-11-08T19:43:08.381Z"
  }
]
```
### Obter dados de produto específico

**Endpoint: GET /api/v1/products/id**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
{
  "id": 1,
  "product_model": "Samsung Galaxy S20",
  "launch_year": "2018",
  "brand": "Samsung",
  "price": "2000.0",
  "status": "active",
  "product_category_id": 1
}
```

### Obter lista de seguradoras

**Endpoint: GET /api/v1/insurance_companies**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
[
  {
    "id":4,
    "name":"Anjo Seguradora",
    "email_domain":"anjoseguradora.com.br",
    "company_status":"active",
    "token_status":"token_active",
    "created_at":"2022-11-14T13:41:14.300Z",
    "updated_at":"2022-11-14T13:41:14.329Z",
    "registration_number":"90929380000777",
    "token":"JZLBBGYMVJRG630OWZ6O"
  },
  {
    "id":1,
    "name":"Liga de Seguros",
    "email_domain":"ligadeseguros.com.br",
    "company_status":"active",
    "token_status":"token_active",
    "created_at":"2022-11-14T13:41:14.129Z",
    "updated_at":"2022-11-14T13:41:14.201Z",
    "registration_number":"01333288000189",
    "token":"JUYJWZAQT45HMODM2L1D"
  },
  {
    "id":3,
    "name":"Seguradora A",
    "email_domain":"seguradoraa.com.br",
    "company_status":"active",
    "token_status":"token_active",
    "created_at":"2022-11-14T13:41:14.253Z",
    "updated_at":"2022-11-14T13:41:14.277Z",
    "registration_number":"80929380000456",
    "token":"ZMBHW3L2DDH5NMPX3OEY"
  },
  {
    "id":2,
    "name":"Trapiche Seguro",
    "email_domain":"trapicheseguro.com.br",
    "company_status":"inactive",
    "token_status":"token_active",
    "created_at":"2022-11-14T13:41:14.215Z",
    "updated_at":"2022-11-14T13:41:14.239Z",
    "registration_number":"29929380000125",
    "token":"BHL5UNU78ABLMMJKVPHW"
  }
]
```
### Obter informações sobre seguradora específica

**Endpoint: GET /api/v1/insurance_companies/id**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
{
  "id":1,
  "name":"Liga de Seguros",
  "email_domain":"ligadeseguros.com.br",
  "company_status":"active",
  "token_status":"token_active",
  "registration_number":"01333288000189",
  "token":"JUYJWZAQT45HMODM2L1D"
}
```
### Solicitar emissão de Apólice

**Endpoint: POST /api/v1/policies**

**Parâmetros a serem enviados para emissão de Apólice**

```json
{
  "client_name": "Maria Alves",
  "client_registration_number": "99950033340",
  "client_email": "mariaalves@email.com",
  "purchase_date": "2022-11-12", 
  "policy_period": 12, 
  "order_id": 1,
  "package_id": 1,
  "insurance_company_id": 1,
  "equipment_id": 1
}
```
Obs: "purchase_date" = data de compra do pacote

<p align = "justify">Retorno:</p>

<p align = "justify">201 (Created)</p>

```json
{
  "id": 1,
  "code": "AGG7MYUQWA",
  "expiration_date": "2023-11-12",
  "status": "pending",
  "client_name": "Maria Alves",
  "client_registration_number": "99950033340",
  "client_email": "mariaalves@email.com",
  "equipment_id": 1,
  "purchase_date": "2022-11-12",
  "policy_period": 12,
  "package_id": 1,
  "order_id": 1,
  "insurance_company_id": 1
}

```

<p align = "justify">Retorno:</p>

<p align = "justify">412 (Precondition failed)</p>

```json
{
  "errors": [
      "Seguradora é obrigatório(a)",
      "Data de Término não pode ficar em branco",
      "Nome do Cliente não pode ficar em branco",
      "CPF do Cliente não pode ficar em branco",
      "E-mail do Cliente não pode ficar em branco",
      "Dispositivo não pode ficar em branco",
      "Data de Compra não pode ficar em branco",
      "Prazo de Contratação não pode ficar em branco",
      "Pacote não pode ficar em branco",
      "Pedido não pode ficar em branco",
      "Dispositivo não é um número",
      "Pedido não é um número",
      "Prazo de Contratação não é um número"
  ]
}
```

### Obter lista de apólices

**Endpoint: GET /api/v1/policies**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
[
  {
    "id": 1,
    "code": "R4OBOVSVD7",
    "expiration_date": "2023-11-14",
    "status": "pending",
    "created_at": "2022-11-14T13:14:28.608Z",
    "updated_at": "2022-11-14T13:14:28.608Z",
    "client_name": "Maria Alves",
    "client_registration_number": "99950033340",
    "client_email": "mariaalves@email.com",
    "equipment_id": 1,
    "purchase_date": "2022-11-14",
    "policy_period": 12,
    "package_id": 1,
    "order_id": 1,
    "insurance_company_id": 1
  },
  {
    "id": 2,
    "code": "7CJZLLQMKK",
    "expiration_date": "2023-11-14",
    "status": "pending",
    "created_at": "2022-11-14T13:14:28.860Z",
    "updated_at": "2022-11-14T13:14:28.860Z",
    "client_name": "Rafael Souza",
    "client_registration_number": "55511122220",
    "client_email": "rafaelsouza@email.com",
    "equipment_id": 2,
    "purchase_date": "2022-11-14",
    "policy_period": 12,
    "package_id": 1,
    "order_id": 2,
    "insurance_company_id": 1
  }
]
```
### Obter apólice específica

**Endpoint: GET /api/v1/policies/id**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
[ 
  {
    "id": 1,
    "code": "R4OBOVSVD7",
    "expiration_date": "2023-11-14",
    "status": "pending",
    "client_name": "Maria Alves",
    "client_registration_number": "99950033340",
    "client_email": "mariaalves@email.com",
    "equipment_id": 1,
    "purchase_date": "2022-11-14",
    "policy_period": 12,
    "package_id": 1,
    "order_id": 1,
    "insurance_company_id": 1
  }
]
```

### Obter dados de Coberturas

**Endpoint: GET /api/v1/package_coverages**

```json
[
  {
    "id":1,
    "name":"Molhar",
    "description":"Assistência por danificação devido a molhar o aparelho."
  },
  {
    "id":2,
    "name":"Quebra de tela",
    "description":"Assistência por danificação da tela do aparelho."
  },
  {
    "id":3,
    "name":"Furto",
    "description":"Reembolso de valor em caso de roubo do aparelho."
  }
]
```

### Obter dados de Serviços

**Endpoint: GET /api/v1/services**

```json
[
  {
    "id":1,
    "name":"Assinatura TV",
    "description":"Concede 10% de desconto em assinatura com mais canais disponíveis no mercado."
  },
  {
    "id":2,
    "name":"Desconto clubes seguros",
    "description":"Concede 10% de desconto em aquisição de seguro veicular."
  }
]

```

### Obter lista de Pacotes

**Endpoint: GET /api/v1/packages**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
[
  {
    "id": 2,
    "name": "Super Econômico",
    "max_period": 18,
    "min_period": 6,
    "insurance_company_id": 1,
    "price": "7.0",
    "product_category_id": 1,
    "status": "active"
  },
  {
    "id": 4,
    "name": "Super Econômico",
    "max_period": 24,
    "min_period": 6,
    "insurance_company_id": 4,
    "price": "8.5",
    "product_category_id": 2,
    "status": "active"
  }
]
```
### Obter dados de pacote específico

**Endpoint: GET /api/v1/packages/id**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
{
  "id": 2,
  "name": "Super Econômico",
  "max_period": 18,
  "min_period": 6,
  "insurance_company_id": 1,
  "price": "7.0",
  "product_category_id": 1,
  "status": "active"
}
```

### Status Codes

Retorna os status:

| Status Code | Description |
| :--- | :--- |
| 200 | `OK` |
| 404 | `NOT FOUND` |
| 500 | `INTERNAL SERVER ERROR` |
| 412 | `PRECONDITION FAILED` |



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

* Gems instaladas: bootstrap, capybara, devise, rspec, rubocop, factory_bot, simplecov

* Ruby: 3.1.2

* Rails: 7.0.4


## Regras de negócio

* Valor de cada serviço e cobertura de pacote não deve ser superior a 30% do valor do produto

* Valor do pacote não deve ser superior a 100% do valor do produto