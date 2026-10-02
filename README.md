<div align="center">
  <img src="logo.png" alt="ECI PMO Logo" width="120" />

# ECI PMO – Sistema de Acompanhamento Escolar

  <p>
    Um sistema moderno e seguro desenvolvido para a Escola Cidadã Integral Padre Manoel Otaviano, conectando pais, alunos e a administração escolar através de um acompanhamento acadêmico transparente e em tempo real.
  </p>

  <p>
    <img src="https://skillicons.dev/icons?i=html,css,js,supabase" alt="Tecnologias utilizadas" />
  </p>
</div>

---

## Sobre o projeto

O **Sistema de Acompanhamento Escolar ECI PMO** foi criado para resolver a necessidade de comunicação e transparência entre a escola e as famílias. Ele oferece dois ambientes distintos e interligados:

1. **Painel do Responsável/Aluno:** Onde os pais podem acompanhar as notas, boletins, datas de provas, seminários, calendário escolar e eventuais ocorrências de forma simplificada, usando apenas a matrícula do aluno.
2. **Painel Administrativo:** Um ambiente seguro e restrito para professores e gestores gerenciarem os dados dos alunos e dispararem notificações diretamente para o WhatsApp dos responsáveis.

## Tecnologias utilizadas

<p align="left">
  <img src="https://skillicons.dev/icons?i=html,css,js,supabase" />
</p>

* **Frontend:** HTML5, CSS3 e JavaScript Vanilla, sem frameworks, garantindo leveza e desempenho nativo.
* **Backend as a Service (BaaS):** [Supabase](https://supabase.com/) para autenticação e banco de dados PostgreSQL.
* **Integrações (APIs):** API de mensageria via Z-API para notificações automatizadas via WhatsApp.
* **Segurança no Frontend:** implementação de *Rate Limiting* personalizado, validação de força de senha e políticas de *Content Security Policy (CSP)* e *Frame-Options* para proteção contra injeções e clickjacking.

## Funcionalidades

### Área do Responsável

* **Autenticação simplificada:** acesso validado exclusivamente através do número de matrícula do aluno.
* **Visão Geral:** resumo do desempenho e atalhos para os próximos eventos.
* **Notas e Boletim:** acompanhamento de notas por bimestre e disciplinas formatadas.
* **Agendas e Avaliações:** acesso ao calendário escolar, provas agendadas e seminários.
* **Ocorrências:** visualização de advertências ou observações disciplinares em tempo real.

### Painel Administrativo

* **Autenticação robusta:** acesso via e-mail e senha, e criação de conta protegida por Token de Registro Institucional.
* **Gestão de Alunos:** cadastro, edição, listagem e acompanhamento individual.
* **Lançamento Acadêmico:** interface dedicada para registros de notas, provas, seminários e ocorrências.
* **Notificações Inteligentes:** disparo automático de alertas via WhatsApp usando a integração com a Z-API.
* **Dashboard Gerencial:** resumo do sistema, controle de acessos e visão estatística.

## Estrutura do projeto

```text
ECI PMO/
├── admin/               # Módulo do Painel Administrativo
│   ├── css/             # Estilos específicos do painel admin
│   ├── js/              # Funcionalidades e rotas do administrador
│   └── index.html       # Interface principal do painel gerencial
├── css/                 # Estilos globais e da tela de login principal
├── dashboard/           # Módulo da Área do Responsável
│   └── index.html       # Interface principal do painel do aluno/pai
├── js/                  # Scripts globais e serviços
│   ├── dashboard.js     # Lógica e renderização da dashboard do aluno
│   ├── data.js          # Métodos de manipulação e comunicação de dados
│   ├── security.js      # Validações, sanitização e rate limiting
│   └── supabase.js      # Inicialização e configuração do cliente Supabase
├── _setup/              # Scripts utilitários de migração e estruturação do BD (SQL/JS)
├── index.html           # Tela inicial de login (abas Responsável/Admin)
└── logo.png / favicon   # Identidade visual
```

## Instalação e execução

O sistema roda completamente no navegador interagindo com as APIs, logo, não requer build de pacotes `npm` ou configurações complexas.

### 1. Clone o repositório

```bash
git clone https://github.com/usuario/eci-pmo.git
cd "eci-pmo"
```

### 2. Inicie um servidor local

Você pode usar a extensão **Live Server** no VS Code ou qualquer servidor HTTP estático local.

**Usando Python 3:**

```bash
python -m http.server 3000
```

**Usando Node.js via npx:**

```bash
npx serve .
```

### 3. Acesse no navegador

Abra `http://localhost:3000` ou a porta correspondente fornecida pelo servidor no seu navegador.

## Configuração

O sistema utiliza o Supabase como serviço de backend. A conexão é instanciada no arquivo `js/supabase.js`.

### Supabase

Para usar o seu próprio banco, atualize as seguintes constantes no arquivo `js/supabase.js` com os dados do seu projeto:

* `SUPABASE_URL`: URL da API do seu projeto Supabase.
* `SUPABASE_ANON_KEY`: chave anônima (anon/public) fornecida pela API.

> **Nota:** Execute os scripts contidos na pasta `_setup/` (`setup_supabase.sql` e `setup_security.sql`) no SQL Editor do seu projeto Supabase para gerar as tabelas e regras de Row Level Security (RLS) necessárias.

### Integração Z-API

As credenciais e rotas da Z-API necessárias para enviar mensagens deverão ser parametrizadas nas rotinas de disparo do arquivo de dados/admin, sendo necessária uma instância ativa.

## Uso

### 1. Primeiro acesso — Configurando a Administração

* Acesse a tela de login inicial e selecione a aba **Administração**.
* Clique em **"Registrar-se"**.
* Insira seu e-mail institucional, crie uma senha com no mínimo 8 caracteres e insira o **Token de Registro** cadastrado previamente no banco de dados.
* Após o registro bem-sucedido, volte ao login, insira as credenciais e acesse o Dashboard Gerencial.

### 2. Cadastro e Gestão

* Uma vez logado como Admin, você pode acessar as seções laterais para cadastrar alunos com seus respectivos números de matrícula, lançar notas e gerenciar ocorrências.

### 3. Uso como Responsável

* Na página inicial, na aba **Responsável**, o usuário precisará digitar o número da **Matrícula do Aluno**.
* O sistema buscará o aluno associado à matrícula e redirecionará para a Dashboard, apresentando em tempo real todas as notas, calendário e ocorrências lançadas pelo administrador.

## Screenshots

> Espaço preparado para as capturas de tela do projeto.

|  Tela Inicial de Login  | Dashboard do Responsável |  Painel Administrativo  |
| :---------------------: | :----------------------: | :---------------------: |
| *(A configurar imagem)* |  *(A configurar imagem)* | *(A configurar imagem)* |

## Roadmap

* [x] Autenticação dividida em tabs (Responsáveis / Admins)
* [x] Limitação de tentativas de Login (Rate Limit) integrado
* [x] Lançamento de notas, provas, seminários e calendário escolar
* [x] Integração para disparo de notificações do WhatsApp
* [ ] Geração de Boletim em formato PDF
* [ ] Recuperação de senha automatizada via e-mail para administradores

## Autor

Desenvolvido para atender às necessidades tecnológicas da **ECI Padre Manoel Otaviano**, digitalizando o acompanhamento acadêmico e estreitando os laços com a comunidade escolar.

---

<div align="center">
  <p>Desenvolvido com dedicação para a educação.</p>
</div>
