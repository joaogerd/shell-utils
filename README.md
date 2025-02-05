# Shell Scripts Collection

## 📌 Sobre
Este repositório contém uma coleção de **scripts Shell** desenvolvidos para facilitar diversas tarefas no terminal Linux. Os scripts são bem documentados e seguem boas práticas, incluindo **padrão ProTex** para documentação.

## 📂 Estrutura do Repositório
```
📂 shell-scripts
│── 📜 README.md       # Documentação do repositório
│── 📜 LICENSE         # Licença Creative Commons (CC BY-NC 3.0)
│── 📜 .gitignore      # Arquivos ignorados pelo Git
│── 📂 scripts/        # Diretório contendo os scripts Shell
│    │── argparse.sh   # Script para parsing de argumentos
│    │── indent        # Script para indentação automática com Emacs
│    │── findbin # Script para encontrar arquivos binários e executáveis
│    │── exemplo.sh    # Outros scripts...
```

## 🚀 Como Usar
### 🔹 Clonando o Repositório
```bash
git clone https://github.com/SEU-USUARIO/shell-scripts.git
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

### 4️⃣ Outros Scripts...
- Em breve...

## 📝 Licença
Este projeto está licenciado sob a **Creative Commons Atribuição-NãoComercial 3.0 (CC BY-NC 3.0)**.
Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🤝 Contribuição
Sinta-se à vontade para enviar Pull Requests e abrir Issues para melhorias!

## 📬 Contato
Caso tenha dúvidas ou sugestões, entre em contato: 
📧 **joao.gerd@inpe.br**

---

> 💡 *Mantenha seus scripts bem documentados e organizados!* 🚀

