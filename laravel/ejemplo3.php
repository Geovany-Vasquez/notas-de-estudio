//EJEMPLO 3
ACTUALIZAR UNA CITA
Problema
Cambiar la fecha de una cita existente.

//RUTA

Route::post('/citas/actualizar/{id}', 'CitaController@update');

//CONTROLADOR

public function update(Request $request, $id) {

    // 1. Buscar cita
    // 2. Actualizar fecha
    // 3. Guardar cambios

    $cita = Cita::find($id);
    $cita->fecha = $request->fecha;
    $cita->save();

    return "Cita actualizada";
}

//vista

<form method="POST" action="/citas/actualizar/1">
    <input type="date" name="fecha">
    <button>Actualizar</button>
</form>


