#!/usr/bin/env bash

# Para criar diretorio e arquivo temporario para o uso do packer #
FILE_ERROR=$(mktemp)
#TMP_DIRECTOR=$(mktemp -d)

# Help #
usage_help() {
    echo ""
    echo " ### Create AMI ###"
    echo ""
    echo "  Usage: ./create-ami.sh --json file.json"
    echo ""
    echo "  OPTIONS:"
    echo ""
    echo "  --json - Informar o arquivo JSON"
    echo ""
    echo "  --help - Apresentacao do Help"
}

# Tratando os inputs #
while [ $# -gt 0 ]; do
  case "$1" in
    --help)
      usage_help
      exit 1
    ;;
    --json)
      PACKER_JSON=$2
    ;;
  esac
  shift
done

# Tratando os inputs do script #
if  [ "${PACKER_JSON}" = "" ]; then
  echo "Informe o arquivo Json"
  read PACKER_JSON
fi

# Validando e executando packer com os arquivos de configuracao #
if [[ -n "$(which /tmp/packer 2>/dev/null)" ]]; then
  PACKER=$(which /tmp/packer 2>/dev/null);
fi;

echo "packer validate"
#run=$(${PACKER} validate ${PACKER_JSON}) > ${FILE_ERROR} 2>&1
if [[ $run = *Errors* ]]; then
  echo "packer validate error"
#  echo "$(cat ${FILE_ERROR})"
  exit 1
else
  echo "packer validate OK"
  echo "packer build $PACKER_JSON"
  run=$(${PACKER} build ${PACKER_JSON})
fi
