#/usr/bin/ksh
#################################################
# ITESM                                         #
# Actividad Final                               #
# Autores: Adriana Fernández                    #
#          José Elías                           #
#################################################

# Validar si existe el directorio
direct=`ls -la | egrep " .Kuka" `
if [ $? -ne 0 ] # si no existe, lo creo
then
    mkdir 2>/dev/null ~/.Kuka
fi

# Validar que haya argumentos
if [ $# -gt 0 -a $# -lt 3 ]
then

    case $1 in
        -S)
    	    # Muestra archivos en el directorio
            ls -l ~/.Kuka | egrep -iv total | tr -s '[ ]' '[#*]' | tr -s '[     ]' '[#*]' | cut -f9 -d#
            ;;

        -D)
            # Borra todos los archivos
            Lista=`ls ~/.Kuka`
            echo "\nAre you sure you want to delete all files? (Y/N): "
            read YN

            if [ $YN = "Y" ]
            then
                for arch in $Lista
                do
                    rm ~/.Kuka/$arch
                done
            fi
            ;;

        -I)
            # Para cada archivo, pregunta si lo quiere borrar
            Lista=`ls ~/.Kuka`
            echo $Lista
            for arch in $Lista
            do
                echo "\nDo you really want to delete the file \"$arch\"? (Y/N): "
                read YN
                if [ $YN = "Y" ]
                then
                    rm  ~/.Kuka/$arch
                fi
            done
            ;;

        *)
            echo "\nError: The flag used is not valid in this script !!!\a"
            ;;
    esac

else
    echo "\nERROR: Wrong number of arguments.\a"
fi
