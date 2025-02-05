#!/bin/bash
#-----------------------------------------------------------------------------#
#BOP
#
# !DESCRIPTION:
#  Este script fornece funções para parsing de argumentos no estilo argparse do Python.
#  Ele permite que scripts Bash lidem facilmente com opções de linha de comando, incluindo
#  argumentos com valores e flags booleanas.
#
# !USAGE:
#  1. Importar este script em outro script Bash:
#       source ./argparse.sh
#  2. Registrar opções com a função `add_argument`:
#       add_argument -t TRC "default_trc" value
#  3. Processar os argumentos recebidos com:
#       parse_arguments "$@"
#
# !AUTHOR:
#  Criado por João Gerd para auxiliar em scripts Bash robustos.
#
# !REVISION HISTORY:
#  05 fev 2025 - J. G. de Mattos - Criação do script
#  06 fev 2025 - J. G. de Mattos - Adicionada documentação ProTex completa
#
#EOP

#BOC
declare -A arguments      # Nome das variáveis associadas às opções
declare -A defaults       # Valores padrão das opções
declare -A argument_types # Tipo de argumento: "value" ou "flag"
#EOC

#BOP
#
# !FUNCTION: add_argument
#
# !DESCRIPTION:
#   Registra uma opção de linha de comando para parsing posterior.
#   Essa função permite que um script Bash lide com argumentos 
#   obrigatórios, opcionais e flags booleanas.
#
# !PARAMETERS:
#   $1 -> Nome da opção (exemplo: "-t")
#   $2 -> Nome da variável que armazenará o valor
#   $3 -> Valor padrão da opção (opcional)
#   $4 -> Tipo do argumento: "value" para opções com valor, "flag" para booleanas
#
# !USAGE:
#   add_argument -t TRC "default_trc" value
#   add_argument -u UNIFIED ".FALSE." flag
#
# !RETURNS:
#   Nenhum valor de retorno. A função define variáveis no script chamador.
#
#EOP
#BOC
add_argument() {
    local option="$1"      # Nome da opção, ex: "-t"
    local var_name="$2"    # Nome da variável associada
    local default_value="$3" # Valor padrão (opcional)
    local arg_type="$4"    # Tipo: "value" ou "flag"

    arguments["$option"]="$var_name"
    argument_types["$option"]="$arg_type"

    # Se um valor padrão for fornecido, define a variável com esse valor
    if [[ -n "$default_value" ]]; then
        defaults["$option"]="$default_value"
        eval "$var_name=\"$default_value\""
    fi
}
#EOC

#BOP
#
# !FUNCTION: parse_arguments
#
# !DESCRIPTION:
#   Processa os argumentos da linha de comando e define as variáveis 
#   correspondentes com os valores fornecidos pelo usuário.
#   Se um argumento não for passado, mantém o valor padrão.
#
# !PARAMETERS:
#   Nenhum parâmetro direto. A função usa "$@" para capturar os argumentos.
#
# !USAGE:
#   parse_arguments "$@"
#
# !RETURNS:
#   Nenhum valor de retorno. A função define variáveis no script chamador.
#
#EOP
#BOC
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        opt="$1"

        # Verifica se a opção está registrada
        if [[ -n "${arguments[$opt]}" ]]; then
            var_name="${arguments[$opt]}"
            arg_type="${argument_types[$opt]}"

            if [[ "$arg_type" == "value" ]]; then
                if [[ -n "$2" ]]; then
                    eval "$var_name=\"$2\""
                    shift 2
                else
                    echo "Erro: A opção $opt requer um argumento." >&2
                    exit 1
                fi
            elif [[ "$arg_type" == "flag" ]]; then
                eval "$var_name='.TRUE.'"
                shift 1
            fi

        # Se for a opção de ajuda
        elif [[ "$opt" == "-h" ]]; then
            echo "Uso: $0 [opções]"
            for key in "${!arguments[@]}"; do
                echo "  $key (${arguments[$key]}) - padrão: ${defaults[$key]:-(nenhum)}"
            done
            exit 0

        # Opção desconhecida
        else
            echo -e "\033[31;1mWarning:\033[m Opção desconhecida: \033[33;1m$opt\033[m" >&2
            shift 1
        fi
    done
}
#EOC
#-----------------------------------------------------------------------------#
