#/usr/bin/ksh
#################################################
# ITESM                                         #
# Actividad Final                               #
# Autores: Adriana Fernández                    #
#          José Elías                           #
#################################################

# Validar si existe el directorio
direct=`ls -la ~ | egrep ".Kuka$"`
if [ $? -ne 0 ] # si no existe, lo creo
then
    mkdir 2>/dev/null ~/.Kuka
    # Crea archivo donde se guardan los directorios
    touch ~/.Kuka/.Rutas
fi

# Validar que haya argumentos
if [ $# -gt 0 -a $# -lt 3 ]
then

    case $1 in
                -S) # Muestra archivos en el directorio
                    # Verificar que no haya más argumentos
                    if [ $# -gt 1 ]
                    then
                        echo "\nERROR: No arguments required.\a"
                    else
                        ls -la ~/.Kuka | egrep -iv total | egrep -v ".Rutas^" | tr -s '[ ]' '[#*]' | tr -s '[ ]' '[#*]' | cut -f9 -d# | egrep -v "\.$"
                    fi
                    ;;



                -D) # Borra todos los archivos del directorio Kuka
                    # Verificar que no haya más argumentos
                    if [ $# -gt 1 ]
                    then
                        echo "\nERROR: No arguments required.\a"
                    else
                        # Borra todos los archivos
                        Lista=`ls -a $HOME/.Kuka | egrep -v ".Rutas" | egrep -v "\.$"`

                        echo "Are you sure you want to delete all files?"
                        read YN
                        if [ $YN = "Y" ]
                        then
                            for arch in $Lista
                            do
                                rm 2>/dev/null $HOME/.Kuka/$arch
                            done
                            # Borrar contenido de archivo Rutas
                            > ~/.Kuka/.Rutas
                        fi
                    fi
                    ;;


                -I) # Para cada archivo, pregunta si lo quiere borrar
                    # Verificar que no haya más argumentos
                    if [ $# -gt 1 ]
                    then
                        echo "\nERROR: No arguments required.\a"
                    else
                        Lista=`ls -a $HOME/.Kuka | egrep -v ".Rutas" | egrep -v "\.$"`
                        # Procesar la lista
                        for arch in $Lista
                        do
                            # Verifica con el usuario
                            echo "\nDo you really want to delete the file \"$arch\"? (Y/N): "
                            read YN
                            if [ $YN = "Y" ]
                            then
                                rm  $HOME/.Kuka/$arch
                                # Eliminar directorio del archivo Rutas
                                cp ~/.Kuka/.Rutas ~/.Kuka/.Temp
                                > ~/.Kuka/.Rutas
                                for dir in `cat ~/.Kuka/.Temp  | egrep -v "/$arch$"`
                                do
                                    echo $dir >> ~/.Kuka/.Rutas
                                done
                                rm ~/.Kuka/.Temp
                            fi
                        done
                    fi
                    ;;


                -M) # Mueve un archivo a la carpeta Kuka
                    # Verificar que tenga un segundo argumento
                    if [ $# -eq 2 ]
                    then
                        # Checar que exista el archivo
                        if test -f $2
                        then
                                filePath=`echo "$(cd "$(dirname "$2")"; pwd -P)/$(basename "$2")"`
                                echo $filePath >> ~/.Kuka/.Rutas
                                mv $2 $HOME/.Kuka/.
                        else
                                echo "\nError: the file \"$2\" does not exist.\a"
                        fi
                    else
                        echo "\nError: The script must receive the name of the file to be deleted\a"
                    fi
                    ;;

                *)
                    echo "\nError: The flag used is not valid in this script !!!\a"
                    ;;
        esac

else
    echo "\nERROR: Wrong number of arguments.\a"
fi
