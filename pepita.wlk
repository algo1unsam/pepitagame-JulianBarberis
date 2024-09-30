import extras.*
import comidas.*
import wollok.game.*

object pepita {

	var property energia = 100
	var property position = game.origin()

	method image() {
		return if (self.estaEnElNido()) {
			"pepita-grande.png"
		} else if(self.esAtrapada() or self.estaCansada() ){
			"pepita-gris.png"
		}
		else "pepita.png"
	}
	method esAtrapada () = self.position() == silvestre.position()

	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
		game.removeVisual(comida)
	}

	method estaEnComida(){

		return position == (manzana.position() or alpiste.position())
	} 
	
	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		if (!self.estaCansada() and self.rangoVisible(nuevaPosicion)){
			self.vola(position.distance(nuevaPosicion))
			position = nuevaPosicion
		}else if (self.estaCansada()){
			game.stop()
		}
	}

	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}
	
	
	method estaEnElSuelo() {
		return position.y() == 0 
	}

	method cae() {
	    if (position.y() > 0) { 
            position = position.down(1)
        }
	}

	method rangoVisible(nuevaPosicion) {
        return nuevaPosicion.x().between(0, 9) and nuevaPosicion.y().between(0, 9) 
    }

}

