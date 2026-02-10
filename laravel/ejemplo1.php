/*EJEMPLO 1 
LISTAR CITAS DE UN USUARIO
Problema
Mostrar todas las citas de un usuario por su DPI.*/

//ruta

Route::get('/citas/usuario/{dpi}', 'CitaController@porUsuario');

//controlador

public function porUsuario($dpi) {

    // 1. Buscar citas por dpi
    // 2. Enviar resultados a la vista

    $citas = Cita::where('dpi', $dpi)->get();

    return view('citas.lista', ['citas' => $citas]);
}

//modelo

class Cita extends Model {
    protected $table = 'citas';
}


//vista

@foreach($citas as $cita)
    <p>{{ $cita->fecha }}</p>
@endforeach
