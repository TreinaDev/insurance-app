# insurance-app
Projeto de app e api para pacotes de seguros: Campus Code - TreinaDev Delas!

## Tabela de Conteúdos
  * [Documentação da API](#documentação-da-api)
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
    "id": 1,
    "name": "Allianz Seguros",
    "email_domain": "allianzseguros.com.br",
    "company_status": "inactive",
    "token_status": 0,
    "created_at": "2022-11-10T21:30:24.926Z",
    "updated_at": "2022-11-10T21:30:24.926Z",
    "registration_number": "01333288000189",
    "token": "3Y9C18LRZNSIHOQNMR0A"
  },
  {
    "id": 2,
    "name": "Porto Seguro",
    "email_domain": "portoseguro.com.br",
    "company_status": "active",
    "token_status": 0,
    "created_at": "2022-11-10T21:30:25.190Z",
    "updated_at": "2022-11-10T21:30:25.190Z",
    "registration_number": "29929380000125",
    "token": "CDRQJPG5FNJ2HKERVCDL"
  },
  {
    "id": 3,
    "name": "Seguradora A",
    "email_domain": "seguradoraa.com.br",
    "company_status": "active",
    "token_status": 0,
    "created_at": "2022-11-10T21:30:26.499Z",
    "updated_at": "2022-11-10T21:30:26.499Z",
    "registration_number": "80929380000456",
    "token": "QYTZYSHNJRL0AYVM9XJ0"
  }
]
```

### Obter informações sobre seguradora específica

**Endpoint: GET /api/v1/insurance_companies/id**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
{
  "id": 1,
  "name": "Allianz Seguros",
  "email_domain": "allianzseguros.com.br",
  "company_status": "inactive",
  "token_status": 0,
  "registration_number": "01333288000189",
  "token": "3Y9C18LRZNSIHOQNMR0A"
}
```

### Obter lista de Pacotes

**Endpoint: GET /api/v1/packages**

<p align = "justify">Retornos:</p>

<p align = "justify">200 (Sucesso)</p>

```json
[
  {
    "id": 1,
    "price": "3.0",
    "created_at": "2022-11-14T14:01:39.173Z",
    "updated_at": "2022-11-14T14:01:39.173Z",
    "pending_package_id": 1,
    "status": "active"
  },
  {
    "id": 2,
    "price": "7.0",
    "created_at": "2022-11-14T14:01:39.193Z",
    "updated_at": "2022-11-14T14:01:39.193Z",
    "pending_package_id": 2,
    "status": "active"
  },
  {
    "id": 3,
    "price": "15.0",
    "created_at": "2022-11-14T14:01:39.210Z",
    "updated_at": "2022-11-14T14:01:39.210Z",
    "pending_package_id": 3,
    "status": "inactive"
  },
  {
    "id": 4,
    "price": "8.5",
    "created_at": "2022-11-14T14:01:39.245Z",
    "updated_at": "2022-11-14T14:01:39.245Z",
    "pending_package_id": 4,
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
  "id": 1,
  "price": "3.0",
  "created_at": "2022-11-14T14:01:39.173Z",
  "updated_at": "2022-11-14T14:01:39.173Z",
  "pending_package_id": 1,
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