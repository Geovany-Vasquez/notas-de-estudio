//EJEMPLO 4
MOSTRAR DETALLE DE UNA CITA
Problema
Ver el detalle de una cita específica.

//RUTA

Route::get('/citas/{id}', 'CitaController@show');


//CONTROLADOR

public function show($id) {

    $cita = Cita::find($id);

    return view('citas.detalle', ['cita' => $cita]);
}

//VISTA

<p>Fecha: {{ $cita->fecha }}</p>
<p>DPI: {{ $cita->dpi }}</p>


//comentarios adicionales de practica

// recibir id
// validar fecha
// buscar registro
// eliminar / guardar / actualizar
// retornar respuesta
