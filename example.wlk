class Persona {
  var property recursos = 20
  var edad

  method esDestacado() = edad.between(18, 65) or recursos > 30
  method ganarMonedas(unaCantidad) {
    recursos += unaCantidad
  }
  method gastarMonedas(unaCantidad){
    recursos = (recursos - unaCantidad).max(0)
  }
  method cumplirAnios() {
    edad += 1
  }

}

class Construccion {
  method valor()
}

class Muralla inherits Construccion {
  var longitud
  override method valor() = longitud * 10
}

class Museo inherits Construccion {
  var superficie
  var indiceImportancia = valorImportancia.valor()
  override method valor() = superficie * indiceImportancia

}

object  valorImportancia {
  var property valor = 0
  method valor(unValor){
    valor = unValor.min(5)
  }
}

class Planeta {
  const habitantes = #{}
  const construcciones = []

  method agregarHabitante(unHabitante) = habitantes.add(unHabitante)
  method agregarConstruccion(unaConstruccion) = construcciones.add(unaConstruccion)
  method habitantesDestacados() = habitantes.filter({h => h.esDestacado()})
  method habitantesConMasRecursos() = habitantes.max({h => h.recursos()})
  method delegacionDiplomatica() {return
    if (self.habitantesDestacados().contains(self.habitantesConMasRecursos())){
      self.habitantesDestacados()
    }
    else {
      self.habitantesDestacados() and self.habitantesConMasRecursos()
    }
  }
  method valorConstrucciones() = construcciones.sum({c => c.valor()})
  method esValioso() = self.valorConstrucciones() > 100

}