# Shell Scripts Collection

## 📌 Sobre
Este repositório contém uma coleção de **scripts Shell** desenvolvidos para facilitar diversas tarefas no terminal Linux. Os scripts são bem documentados e seguem boas práticas, incluindo **padrão ProTex** para documentação.

## 📂 Estrutura do Repositório
```
📂 shell-scripts
│── 📜 README.md        # Documentação do repositório
│── 📜 LICENSE          # Licença Creative Commons (CC BY-NC 3.0)
│── 📜 .gitignore       # Arquivos ignorados pelo Git
│── 📂 scripts/         # Diretório contendo os scripts Shell
│    │── argparse.sh    # Script para parsing de argumentos
│    │── indent         # Script para indentação automática com Emacs
│    │── findbin        # Script para encontrar arquivos binários e executáveis
│    │── findrecent     # Script para listar arquivos ordenados por data
│    │── log_manager.sh # Script para fornecer um mecanismo de log genérico para scripts shell
│    │── exemplo.sh     # Outros scripts...
```

## 🚀 Como Usar
### 🔹 Clonando o Repositório
```bash
git clone https://github.com/joaogerd/shell-utils.git
cd shell-scripts/scripts
```

### 🔹 Executando um Script
Dê permissão de execução ao script:
```bash
chmod +x exemplo.sh
./exemplo.sh
```

### 🔹 Importando um Script
Se quiser utilizar um script dentro de outro:
```bash
source ./argparse.sh
```

## 🛠 Scripts Disponíveis

### 1️⃣ `argparse.sh`
> **Descrição:** Script para parsing de argumentos estilo `argparse` do Python.
> **Uso:** Permite registrar e processar argumentos de linha de comando de forma eficiente.

Exemplo de uso:
```bash
source ./argparse.sh
add_argument -t TRC "default_trc" value
parse_arguments "$@"
echo "Valor de TRC: $TRC"
```

### 2️⃣ `indent`
> **Descrição:** Script para indentação automática de arquivos usando Emacs.
> **Uso:** Remove tabs, aplica indentação e salva arquivos automaticamente.

Exemplo de uso:
```bash
chmod +x indent
./indent arquivo1.c arquivo2.sh
```

Se deseja processar todos os arquivos em um diretório:
```bash
find . -name "*.sh" | xargs ./indent
```

### 3️⃣ `findbin`
> **Descrição:** Script para encontrar arquivos binários, executáveis, bibliotecas compartilhadas e compactados.
> **Uso:** Lista arquivos que não são de texto puro dentro de um diretório.

Exemplo de uso:
```bash
chmod +x findbin
./findbin
```

Para especificar um diretório:
```bash
./findbin /usr/bin
```

### 4️⃣ `findrecent`
> **Descrição:** Script para listar arquivos ordenados por data de modificação ou acesso.
> **Uso:** Encontra arquivos com base em um padrão e exibe a data de modificação/acesso.

Exemplo de uso:
```bash
chmod +x findrecent
./findrecent "*.sh" long
```

Formatos disponíveis:
- `long`  → Exibe informações detalhadas (data modificada, acessada e nome do arquivo)
- `short` → Exibe uma versão compacta das informações

### 5️⃣ `log_manager.sh`
> **Descrição:** Script para fornecer um mecanismo genérico de logging para shell scripts.
> **Uso:** Suporta diferentes níveis de log, imprime mensagens no console e pode registrar logs em arquivos. Também permite ativar ou desativar cores nas mensagens.

Exemplo de uso:
```bash
chmod +x log_manager.sh
./log_manager.sh -l INFO -m "Script iniciado com sucesso."
./log_manager.sh -l ERROR -m "Arquivo não encontrado!" -f /var/log/my_script.log -c off
```

**Níveis de Log Disponíveis:**
- `OK`      → Mensagem de sucesso
- `ACTION`  → Ação recomendada ou executada
- `INFO`    → Mensagem informativa
- `WARNING` → Aviso
- `ERROR`   → Mensagem de erro
- `DEBUG`   → Logs detalhados para depuração
- `NOTICE`  → Important but non-critical information
- `NEUTRAL` → Neutral message
- `DETAIL`  → Additional details or technical logs

### 6️⃣ Outros Scripts...
- Em breve...

## 📝 Licença
Este projeto está licenciado sob a **Creative Commons Atribuição-NãoComercial 3.0 (CC BY-NC 3.0)**.
Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

```
Creative Commons Legal Code

Attribution-NonCommercial 3.0 Unported

You are free to:
- Share — copy and redistribute the material in any medium or format
- Adapt — remix, transform, and build upon the material

Under the following terms:
- Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
- NonCommercial — You may not use the material for commercial purposes.

Full License: https://creativecommons.org/licenses/by-nc/3.0/
```

## 📑 .gitignore
```
# Ignore arquivos desnecessários
*.log
*.tmp
.DS_Store
__pycache__/
```

## 🤝 Contribuição
Sinta-se à vontade para enviar Pull Requests e abrir Issues para melhorias!

## 📬 Contato
Caso tenha dúvidas ou sugestões, entre em contato:
📧 **joao.gerd@inpe.br**

