//EJEMPLO 2 
CREAR UNA NUEVA CITA
Problema
Guardar una cita solo si la fecha es válida.

//RUTA

Route::post('/citas/guardar', 'CitaController@store');

//CONTROLADOR

public function store(Request $request) {

    // 1. Obtener datos del formulario
    // 2. Validar fecha
    // 3. Guardar cita

    if ($request->fecha < date('Y-m-d')) {
        return "Fecha inválida";
    }

    Cita::create([
        'fecha' => $request->fecha,
        'dpi' => $request->dpi
    ]);

    return "Cita creada";
}

//MODELO

protected $fillable = ['fecha', 'dpi'];

//VISTA

<form method="POST" action="/citas/guardar">
    <input type="date" name="fecha">
    <input type="text" name="dpi">
    <button>Guardar</button>
</form>
