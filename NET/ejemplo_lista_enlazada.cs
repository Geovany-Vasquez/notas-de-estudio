//CREAR UN NODO

public class Nodo
{
    public int Valor { get; set; }
    public Nodo Siguiente { get; set; }

    public Nodo(int valor)
    {
        Valor = valor;
        Siguiente = null;
    }
}

//CREAR UNA LISTA ENLAZADA

public class ListaEnlazada
{
    private Nodo cabeza;

    public void Agregar(int valor)
    {
        Nodo nuevo = new Nodo(valor);

        if (cabeza == null)
        {
            cabeza = nuevo;
            return;
        }

        Nodo actual = cabeza;

        while (actual.Siguiente != null)
        {
            actual = actual.Siguiente;
        }

        actual.Siguiente = nuevo;
    }

    public void Mostrar()
    {
        Nodo actual = cabeza;

        while (actual != null)
        {
            Console.Write(actual.Valor + " → ");
            actual = actual.Siguiente;
        }

        Console.WriteLine("null");
    }
}

//PARA UTILIZARLO EN UN PROGRAMA CS

ListaEnlazada lista = new ListaEnlazada();

lista.Agregar(10);
lista.Agregar(20);
lista.Agregar(30);

lista.Mostrar();

//tODO ESTO DEBE DAR UNA SALIDA SIMILAR A ESTA:  10 → 20 → 30 → null
