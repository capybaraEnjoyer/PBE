require 'i2c/drivers/lcd'

class Lcd
    
    def initialize(filas,columnas)
		@filas = filas
		@columnas = columnas
    end
    
	def writeLcd()
		
		puts "Introduzca el texto que quiere escribir en LCD: \n"
		write = gets.delete "\n" #Userinput quitando salto de linia
		numWri = write.length
		display = I2C::Drivers::LCD::Display.new('/dev/i2c-1', 0x27, rows=20, cols=4)
		display.clear
		
		numNovo = 0
		i = 0
		
		while(numWri > numNovo)	
		
			if(numWri < numNovo + @filas) #caso de que se escriba la ultima fila de la lectura
				display.text("#{write[numNovo,@filas]}", i)
				numNovo = numWri
			else #caso general de lectura
				display.text("#{write[numNovo,@filas]}", i)
				numNovo = numNovo + @filas
				i = i + 1
			end
				
			if(i == 4) #control para no exceder del ultimo espacio de la pantalla
				puts "Presione cualquier boton para continuar la lectura"
				gets
				display.clear
				i=0
			end
		end
		puts "Presione cualquier tecla para finalizar la lectura"
		gets
		display.clear
	end

	def writeTextview(text)
		write = text.delete "\n"
		numWri = write.length
		display = I2C::Drivers::LCD::Display.new('/dev/i2c-1', 0x27, rows=20, cols=4)
		
		numNovo = 0
		i = 0
		
		while(numWri > numNovo)	
		
			if(numWri < numNovo + @filas) 
				display.text("#{write[numNovo,@filas]}", i)
				numNovo = numWri
			else 
				display.text("#{write[numNovo,@filas]}", i)
				numNovo = numNovo + @filas
				i = i + 1
			end
		end
	end

end

#Ejemplo:
#myLcd = Lcd.new(20,4)
#myLcd.writeLcd()
