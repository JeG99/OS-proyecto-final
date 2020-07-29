#!/usr/bin/ksh
#################################################
# ITESM                                         #
# Actividad Final                               #
# Autores: Adriana Fernández                    #
#          José Elías                           #
#################################################

# Validar que el directorio oculto Kuka existe
kuka=`ls -la | egrep ".Kuka"`
if [ $? -ne 0 ] # Si el directorio oculto no existe...
then
	mkdir $HOME/.Kuka # ... es creado
fi

# Validar que se reciben de 1 a 2 argumentos
if [ $# -gt 0 -o $# -lt 2 ]
then
	case $1 in 
		-F) # Recupera un archivo
			if [ $# -eq 2 ] # Valida que se reciba un archivo como argumento
			then
				# Cargo la direccion del archivo
				filedir=`cat $HOME/.Kuka/$2.dir`
				# Verifico que la direccion exista
				directory=`ls -la | egrep $filedir`
				if [ $? -ne 0 ] # Si la direccion no existe ...
				then
					mkdir -p $filedir # ... es creada
				fi
				mv $HOME/.Kuka/$2 $filedir # Recuperar el archivo
				rm $HOME/.Kuka/$2.dir # Eliminar la referencia a la direccion
			else
				echo "\nUsage:\n    -F [file]\n        Restores a file to its former directory\a\n"
			fi
			;;
		-A)
			if [ $# -eq 1 ]
			then
				for file in `ls $HOME/.Kuka`
				do
				# Cargo la direccion del archivo
				filedir=`cat $HOME/.Kuka/$file.dir`
				# Verifico que la direccion exista
				directory=`ls -la | egrep $filedir`
				if [ $? -ne 0 ] # Si la direccion no existe ...
				then
					mkdir -p $filedir # ... es creada
				fi
				mv $HOME/.Kuka/$file $filedir # Recuperar el archivo
				rm $HOME/.Kuka/$file.dir # Eliminar la referencia a la direccion
				done
			else
				echo "\nUsage:\n    -A\n        Restores all erased files to their former directories\a\n"
			fi
			;;
	esac
else
	echo "\nERROR: Wrong number of arguments.\a" 
fi