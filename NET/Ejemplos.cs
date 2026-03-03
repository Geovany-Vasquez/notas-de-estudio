//Cliente con muchos pedidos

//MODELO

public class Cliente
{
    public int Id { get; set; }
    public string Nombre { get; set; }

    public List<Pedido> Pedidos { get; set; } = new();
}

public class Pedido
{
    public int Id { get; set; }
    public string Producto { get; set; }
    public decimal Precio { get; set; }

    public int ClienteId { get; set; }
}

//CONTROLLER

[ApiController]
[Route("api/[controller]")]
public class ClientesController : ControllerBase
{
    private static List<Cliente> clientes = new();

    [HttpPost]
    public IActionResult CrearCliente(Cliente cliente)
    {
        clientes.Add(cliente);
        return Ok(cliente);
    }

    [HttpPost("{clienteId}/pedidos")]
    public IActionResult AgregarPedido(int clienteId, Pedido pedido)
    {
        var cliente = clientes.FirstOrDefault(c => c.Id == clienteId);

        if (cliente == null)
            return NotFound();

        pedido.ClienteId = clienteId;
        cliente.Pedidos.Add(pedido);

        return Ok(pedido);
    }

    [HttpGet("{clienteId}/pedidos")]
    public IActionResult ObtenerPedidos(int clienteId)
    {
        var cliente = clientes.FirstOrDefault(c => c.Id == clienteId);

        if (cliente == null)
            return NotFound();

        return Ok(cliente.Pedidos);
    }
}

//endpoint que permite paginar y filtrar productos por precio minimo


//MODELO

public class Producto
{
    public int Id { get; set; }
    public string Nombre { get; set; }
    public decimal Precio { get; set; }
}


//CONTROLLER


[ApiController]
[Route("api/[controller]")]
public class ProductosController : ControllerBase
{
    private static List<Producto> productos = new List<Producto>
    {
        new Producto { Id = 1, Nombre = "Laptop", Precio = 5000 },
        new Producto { Id = 2, Nombre = "Mouse", Precio = 150 },
        new Producto { Id = 3, Nombre = "Teclado", Precio = 300 },
        new Producto { Id = 4, Nombre = "Monitor", Precio = 1200 }
    };

    [HttpGet]
    public IActionResult Get(
        decimal? precioMinimo,
        int page = 1,
        int pageSize = 2)
    {
        var query = productos.AsQueryable();

        if (precioMinimo.HasValue)
            query = query.Where(p => p.Precio >= precioMinimo.Value);

        var total = query.Count();

        var resultado = query
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToList();

        return Ok(new
        {
            Total = total,
            Page = page,
            PageSize = pageSize,
            Data = resultado
        });
    }
}

//ejemplo de swagger

//GET /api/productos?precioMinimo=200&page=1&pageSize=2


//valida que el nombre sea obligatorio y que el precio sea mayor a cero


using System.ComponentModel.DataAnnotations;

public class Producto
{
    public int Id { get; set; }

    [Required]
    [StringLength(100)]
    public string Nombre { get; set; }

    [Range(1, double.MaxValue)]
    public decimal Precio { get; set; }
}

//controller


[HttpPost]
public IActionResult Post([FromBody] Producto producto)
{
    if (!ModelState.IsValid)
        return BadRequest(ModelState);

    return Ok(producto);
}
