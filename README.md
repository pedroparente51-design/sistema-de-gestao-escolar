# ECI PMO — Sistema de Acompanhamento Escolar

<p align="center">
  <strong>Um sistema moderno para acompanhamento acadêmico, comunicação escolar e gestão de alunos.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/HTML5-0A0A0A?style=for-the-badge&logo=html5&logoColor=white" alt="HTML5">
  <img src="https://img.shields.io/badge/CSS3-0A0A0A?style=for-the-badge&logo=css3&logoColor=white" alt="CSS3">
  <img src="https://img.shields.io/badge/JAVASCRIPT-0A0A0A?style=for-the-badge&logo=javascript&logoColor=white" alt="JavaScript">
  <img src="https://img.shields.io/badge/SUPABASE-0A0A0A?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase">
</p>

---

## Sobre o projeto

O **ECI PMO — Sistema de Acompanhamento Escolar** foi desenvolvido para atender às necessidades de comunicação, acompanhamento acadêmico e transparência entre a escola e as famílias.

A plataforma conecta **responsáveis, alunos, professores e gestores** através de ambientes específicos para consulta e gerenciamento das informações escolares.

O sistema é dividido em dois principais ambientes:

### Painel do Responsável / Aluno

Permite que responsáveis acompanhem as informações acadêmicas do aluno de forma simples e centralizada, utilizando o número de matrícula.

Entre as informações disponíveis estão:

* Notas e boletins;
* Calendário escolar;
* Datas de provas;
* Seminários;
* Ocorrências;
* Informações acadêmicas;
* Próximos eventos.

### Painel Administrativo

Ambiente restrito destinado à administração escolar, permitindo o gerenciamento das informações acadêmicas e o envio de notificações aos responsáveis.

---

## Tecnologias utilizadas

<p align="center">
  <img src="https://img.shields.io/badge/HTML5-0A0A0A?style=for-the-badge&logo=html5&logoColor=white" alt="HTML5">
  <img src="https://img.shields.io/badge/CSS3-0A0A0A?style=for-the-badge&logo=css3&logoColor=white" alt="CSS3">
  <img src="https://img.shields.io/badge/JAVASCRIPT-0A0A0A?style=for-the-badge&logo=javascript&logoColor=white" alt="JavaScript">
  <img src="https://img.shields.io/badge/SUPABASE-0A0A0A?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase">
  <img src="https://img.shields.io/badge/POSTGRESQL-0A0A0A?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/GIT-0A0A0A?style=for-the-badge&logo=git&logoColor=white" alt="Git">
  <img src="https://img.shields.io/badge/GITHUB-0A0A0A?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">
</p>

### Stack

* **Frontend:** HTML5, CSS3 e JavaScript Vanilla.
* **Backend as a Service:** Supabase.
* **Banco de dados:** PostgreSQL através do Supabase.
* **Autenticação:** Supabase Auth.
* **Integrações:** API de mensageria Z-API para notificações via WhatsApp.
* **Segurança:** Rate Limiting, validação de senhas, sanitização de dados, CSP e políticas contra clickjacking.
* **Controle de versão:** Git e GitHub.

---

## Funcionalidades

### Área do Responsável

* **Autenticação simplificada:** acesso através do número de matrícula do aluno.
* **Dashboard:** visão geral do desempenho e próximos eventos.
* **Notas e boletim:** acompanhamento das notas por bimestre e disciplina.
* **Calendário escolar:** consulta de eventos e datas importantes.
* **Avaliações:** visualização de provas e seminários agendados.
* **Ocorrências:** acompanhamento de advertências e observações disciplinares.
* **Atualização em tempo real:** informações sincronizadas com o banco de dados.

### Painel Administrativo

* **Autenticação segura:** acesso através de e-mail e senha.
* **Registro protegido:** criação de contas utilizando Token de Registro Institucional.
* **Gestão de alunos:** cadastro, edição, consulta e acompanhamento individual.
* **Lançamento acadêmico:** gerenciamento de notas, provas e seminários.
* **Gestão de ocorrências:** registro e acompanhamento de ocorrências.
* **Notificações via WhatsApp:** integração com a Z-API.
* **Dashboard gerencial:** visão geral das informações e estatísticas do sistema.

---

## Segurança

A aplicação conta com diferentes mecanismos para reduzir riscos e proteger os dados escolares.

Entre eles:

* Rate Limiting para tentativas de autenticação;
* Validação de força de senha;
* Sanitização de dados;
* Content Security Policy (CSP);
* Proteções contra Clickjacking;
* Row Level Security (RLS) no Supabase;
* Autenticação através do Supabase Auth;
* Separação entre ambiente administrativo e ambiente do responsável;
* Controle de acesso às operações administrativas.

> A segurança efetiva depende também da configuração adequada das políticas do Supabase, das credenciais e das integrações externas utilizadas em produção.

---

## Estrutura do projeto

```text
ECI PMO/
├── admin/
│   ├── css/
│   │   └── # Estilos do painel administrativo
│   ├── js/
│   │   └── # Lógica e funcionalidades administrativas
│   └── index.html
│       # Interface principal do painel administrativo
│
├── css/
│   └── # Estilos globais e tela de login
│
├── dashboard/
│   └── index.html
│       # Área do responsável/aluno
│
├── js/
│   ├── dashboard.js
│   │   # Lógica da dashboard do aluno
│   ├── data.js
│   │   # Manipulação e comunicação de dados
│   ├── security.js
│   │   # Validações, sanitização e Rate Limiting
│   └── supabase.js
│       # Configuração do cliente Supabase
│
├── _setup/
│   ├── setup_supabase.sql
│   ├── setup_security.sql
│   └── # Scripts de configuração do banco
│
├── index.html
│   # Tela inicial de autenticação
│
├── logo.png
└── favicon
```

---

## Arquitetura

```text
┌─────────────────────────────┐
│       USUÁRIO / ALUNO       │
│       RESPONSÁVEL           │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│       FRONTEND WEB          │
│   HTML + CSS + JavaScript   │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│          SUPABASE           │
│                             │
│  ├── Authentication         │
│  ├── PostgreSQL             │
│  └── Row Level Security     │
└──────────────┬──────────────┘
               │
               ├──────────────────────┐
               ▼                      ▼
┌────────────────────────┐  ┌────────────────────┐
│ PAINEL ADMINISTRATIVO  │  │      Z-API         │
│                        │  │                    │
│ Alunos                 │  │ WhatsApp           │
│ Notas                  │  │ Notificações       │
│ Provas                 │  │ Alertas            │
│ Ocorrências            │  │                    │
└────────────────────────┘  └────────────────────┘
```

---

## Instalação e execução

O projeto funciona diretamente no navegador e não necessita de processo de build ou instalação de dependências `npm` para sua execução básica.

### 1. Clone o repositório

```bash
git clone https://github.com/usuario/eci-pmo.git
cd eci-pmo
```

### 2. Inicie um servidor local

Você pode utilizar o **Live Server** do VS Code ou qualquer servidor HTTP estático.

#### Python 3

```bash
python -m http.server 3000
```

#### Node.js

```bash
npx serve .
```

### 3. Acesse a aplicação

Abra no navegador:

```text
http://localhost:3000
```

Ou utilize a porta disponibilizada pelo servidor escolhido.

---

## Configuração

### Supabase

O projeto utiliza o Supabase como infraestrutura de backend.

A configuração do cliente está localizada em:

```text
js/supabase.js
```

Configure as seguintes informações:

```javascript
SUPABASE_URL
SUPABASE_ANON_KEY
```

Essas informações podem ser obtidas no painel do seu projeto Supabase.

### Banco de dados

Execute os scripts presentes em:

```text
_setup/
```

Principalmente:

```text
setup_supabase.sql
setup_security.sql
```

Esses scripts são responsáveis pela criação da estrutura necessária do banco e pelas políticas de segurança utilizando **Row Level Security (RLS)**.

---

## Integração com Z-API

O sistema possui integração com a **Z-API** para envio automatizado de notificações através do WhatsApp.

A integração requer uma instância ativa e as respectivas credenciais configuradas nas rotinas responsáveis pelo envio das mensagens.

Exemplos de utilização:

```text
Novo lançamento de nota
        ↓
Sistema identifica atualização
        ↓
Integração Z-API
        ↓
WhatsApp do responsável
```

---

## Uso

### 1. Primeiro acesso — Administração

1. Acesse a página inicial.
2. Selecione a aba **Administração**.
3. Clique em **Registrar-se**.
4. Informe o e-mail institucional.
5. Crie uma senha com no mínimo 8 caracteres.
6. Informe o **Token de Registro Institucional**.
7. Finalize o cadastro.
8. Retorne à tela de login.
9. Acesse o Dashboard Administrativo.

### 2. Gestão acadêmica

Após realizar o login como administrador, é possível:

* Cadastrar alunos;
* Editar informações;
* Consultar alunos;
* Lançar notas;
* Cadastrar provas;
* Registrar seminários;
* Registrar ocorrências;
* Gerenciar informações acadêmicas;
* Enviar notificações aos responsáveis.

### 3. Acesso do responsável

Na página inicial:

1. Selecione **Responsável**.
2. Informe a matrícula do aluno.
3. O sistema identifica o cadastro correspondente.
4. A dashboard apresenta as informações acadêmicas disponíveis.

---

## Screenshots

> Área reservada para capturas de tela da aplicação.

|  Tela Inicial  | Dashboard do Responsável | Painel Administrativo |
| :------------: | :----------------------: | :-------------------: |
| *A configurar* |      *A configurar*      |     *A configurar*    |

---

## Roadmap

* [x] Autenticação dividida entre Responsável e Administração
* [x] Rate Limiting para tentativas de login
* [x] Sistema de notas
* [x] Sistema de provas
* [x] Sistema de seminários
* [x] Calendário escolar
* [x] Sistema de ocorrências
* [x] Integração com WhatsApp
* [x] Dashboard administrativa
* [ ] Geração de boletim em PDF
* [ ] Recuperação de senha automatizada por e-mail
* [ ] Sistema de relatórios
* [ ] Histórico acadêmico completo
* [ ] Melhorias no sistema de notificações

---

## Objetivo

O **ECI PMO** busca digitalizar processos relacionados ao acompanhamento acadêmico, aproximando a escola das famílias e centralizando informações importantes em uma única plataforma.

A proposta é transformar informações que tradicionalmente ficam dispersas em documentos, comunicados e registros internos em uma experiência digital mais organizada e acessível.

---

## Autor

Desenvolvido para atender às necessidades tecnológicas da **ECI Padre Manoel Otaviano**, contribuindo para a digitalização do acompanhamento acadêmico e para a comunicação entre escola e comunidade.

---

<p align="center">
  <strong>ECI PMO</strong><br>
  Sistema de Acompanhamento Escolar
</p>
