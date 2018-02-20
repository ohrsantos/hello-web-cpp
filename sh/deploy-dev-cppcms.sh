#!/bin/bash
#######!/bin/ksh
#        1         2         3         4         5         6         7         8         9
#234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
################################################################################
SCRIPT_NAME="deploy-dev-cppcms"
VERSION="0.01a"
AUTHOR="Orlando Hehl Rebelo dos Santos"
DATE_INI="20-02-2018"
DATE_END="20-02-2018"
################################################################################
#Configuration section:
#
################################################################################

action=$(echo ${1} | tr '[:lower:]' '[:upper:]')

export APP_ENV=$(echo ${2} | tr '[:lower:]' '[:upper:]')
export HOST=$(curl http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null)
export PUBLIC_DNS=$HOST

APP_PORT=${3}

echo ">>>> deploy-${APP_ENV} v:0.01a"

function stop_container {
    echo ">>>> Parando container app-cppcms-${APP_ENV} ..."
    if docker stop -t3 app-cppcms-${APP_ENV}; then
        echo ">>>> Container parado com sucesso!"
    fi
}

function remove_img {
    echo ">>>> Removendo imagem ohrsan/app-cppcms:latest ..."
    if docker rmi -f ohrsan/app-cppcms:latest; then
        echo ">>>> Imagem removida com sucesso ..."
    else
        echo ">>>> ATENCAO: A imagem nao foi removida com sucesso ..."
    fi
}

function build_img {
    echo ">>>> Construindo imagem ohrsan/app-cppcms:latest ..."
    if docker build -f containers/Dockerfile.app-cppcms  -t ohrsan/app-cppcms:latest .; then
        echo ">>>> Imagem construida com sucesso!"
    else
        exit 60
    fi
}

function run_container {
    echo ">>>> Inicializando container app-cppcms-${APP_ENV} $HOST:$APP_PORT"
    docker run -d  --rm -p $APP_PORT:8080 --name app-cppcms-${APP_ENV} ohrsan/app-cppcms:latest || exit 3
    #Env variables not implemented yet
    #docker run -d  --rm -e APP_ENV -e PUBLIC_DNS -p $APP_PORT:8080   --name app-cppcms${APP_ENV} ohrsan/app-cppcms:latest || exit 3
}

function run_tests {
    sleep 5
    echo ">>>> Testando a aplicacao..."
    if ! ./sh/is-server-up.sh -D -p 3333  && ./sh/has-error-string.sh -D -p 3333 && ./sh/is-rds-select-working.sh -D -p 3333 ; then
        TESTS=FAILED
        echo ">>>> Testes falharam!"
    fi
}

case $action in
    "STOP" )
        echo "----------------------------------"
        echo "      ENCERRANDO $APP_ENV "
        echo "----------------------------------"
        stop
        ;;
    "START" )
        echo "----------------------------------"
        echo "      INICIALIZANDO $APP_ENV "
        echo "----------------------------------"
        start
        ;;
    "UPDATE" )
        echo "----------------------------------"
        echo "      DEPLOYING $APP_ENV "
        echo "----------------------------------"
      
        remove_img
        build_img
        stop_container
        run_container
        run_tests
        stop_container
        if [[ $TESTS == FAILED ]]; then
            exit 50
        else
            docker login -u=ohrsan -p=bomdia01

            docker push ohrsan/app-cppcms:latest
        fi
        ;;
    *)
         echo "Opcao \"$action\"... invalida!"
        ;;
esac
exit 0
