//elimina un valor

public void Eliminar(int valor)
{
    if (cabeza == null)
        return;

    if (cabeza.Valor == valor)
    {
        cabeza = cabeza.Siguiente;
        return;
    }

    Nodo actual = cabeza;

    while (actual.Siguiente != null && actual.Siguiente.Valor != valor)
    {
        actual = actual.Siguiente;
    }

    if (actual.Siguiente != null)
    {
        actual.Siguiente = actual.Siguiente.Siguiente;
    }
}
