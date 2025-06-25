class Persona {
  var recursos = 20
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
  method recursos() = recursos

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
  var indiceImportancia 
  override method valor() = superficie * indiceImportancia
  method indiceImportancia(unValor){
    indiceImportancia = unValor.min(5)
  }
}

class Planeta {
  const habitantes = #{}
  const construcciones = []

  method agregarDestacados(unaColeccion){habitantes.addAll(unaColeccion)}
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

class Productor inherits Persona {
  var tecnicas = ["Cultivo"]
  const planetaDondeVive
  override method recursos() = super() * self.tecnicasQueConoce()
  override method esDestacado() = super() or self.tecnicasQueConoce() > 5
  method tecnicasQueConoce() = tecnicas.size()
  method hacerTecnicaPorTiempo(unTiempo, unaTecnica){
    if (tecnicas.contains(unaTecnica)){
      recursos = recursos + (3 * unTiempo)
    }else{
      recursos = (recursos - 1).max(0)
    }
  }
  method aprenderTecnica(unaTecnica){tecnicas.add(unaTecnica)}
  method trabajarEnUnPlaneta(unTiempo, unPlaneta){
    if (planetaDondeVive == unPlaneta){
      self.hacerTecnicaPorTiempo(unTiempo, tecnicas.last())
    }
  }
}

class Constructor inherits Persona {
  var horasTrabajo
  const construcciones = []
  const regionDondeVive
  override method recursos() = super() + self.construccionesRealizadas() * 10
  method construccionesRealizadas() = construcciones.size() 
  override method esDestacado() = self.construccionesRealizadas() > 5
  method hacerUnaConstruccion(unaConstruccion){construcciones.add(unaConstruccion)}
  method trabajarEnUnPlaneta(unTiempo, unPlaneta){
      self.hacerUnaConstruccion(regionDondeVive.hacerConstruccion(horasTrabajo, self))
      self.gastarMonedas(5)
  }
}

object montaña{
  method hacerConstruccion(horas, unConstructor){
    const muralla1 = new Muralla(longitud = horas / 2) 
    return muralla1
  }
}

object costa{
  method hacerConstruccion(horas, unConstructor){
    const museo1 = new Museo(superficie = horas, indiceImportancia = 1)
    return museo1
  }
}

object llanura{
  method hacerConsutrccion(horas, unConstructor){
    if (not unConstructor.esDestacado()){
      const muralla2 = new Muralla(longitud = horas / 2)
    }else{
      const museo2 = new Museo(superficie = horas, indiceImportancia = unConstructor.recursos().min(5))
    }
  }
}
