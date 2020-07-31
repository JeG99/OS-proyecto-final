#!/usr/bin/ksh
#################################################
# ITESM                                         #
# Actividad Final                               #
# Autores: Adriana Fernández                    #
#          José Elías                           #
#################################################

# Validar que el directorio oculto Kuka existe
kuka=`ls -la ~ | egrep ".Kuka$"`
if [ $? -ne 0 ] # Si el directorio oculto no existe...
then
        mkdir $HOME/.Kuka # ... es creado
        # Crea archivo donde se guardan los directorios
        touch $HOME/.Kuka/.Rutas
fi

# Validar que se reciben de 1 a 2 argumentos
if [ $# -gt 0 -a $# -lt 3 ]
then
        case $1 in
                -F) # Recupera un archivo
                        if [ $# -eq 2 ] # Valida que se reciba un argumento
                        then
                                if test -f $HOME/.Kuka/$2
                                then
                                        # Recupero el archivo
                                        mv $HOME/.Kuka/$2 $(cat ~/.Kuka/.Rutas | egrep "/$2$")
                                        # Archivo temporal de Rutas
                                        cp ~/.Kuka/.Rutas ~/.Kuka/.Temp
                                        # Vaciar Rutas
                                        > ~/.Kuka/.Rutas
                                        # Procesar temporal de Rutas
                                        for dir in `cat ~/.Kuka/.Temp  | egrep -v "/$2$"`
                                        do
                                                # Vaciar todas las rutas en un nuevo .Rutas excepto la del archivo recuperado
                                                echo $dir >> ~/.Kuka/.Rutas
                                        done
                                        # Eliminar el temporal
                                        rm ~/.Kuka/.Temp
                                else
                                        echo "\nError: the file $2 does not exist."
                                fi
                        else
                                echo "\nError: The script must receive the name of the file to recover"
                        fi
                        ;;
                -A)
                        if [ $# -eq 1 ] # Valida que no se reciban argumentos
                        then
                                for file in `ls -a $HOME/.Kuka | egrep -v ".Rutas" | egrep -v "\.$"` # Para cada archivo en Kuka ...
                                do
                                        mv $HOME/.Kuka/$file $(cat ~/.Kuka/.Rutas | egrep "/$file$")
                                done
                                # Vaciar archivo Rutas
                                > ~/.Kuka/.Rutas
                        else
                                echo "\nError: This flag receives no arguments !!!"
                        fi
                        ;;
                *)
                        echo "\nError: The flag used is not valid in this script !!!"
                        ;;
        esac
else
        echo "\nERROR: Wrong number of arguments.\a"
fi
