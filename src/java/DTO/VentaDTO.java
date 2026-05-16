package DTO;

import java.util.List;

public class VentaDTO {

    private int idVenta;
    private int idUsuario;
    private int idCliente;
    private String nombreCliente;   // para mostrar en lista
    private String fecha;
    private double total;
    private String estado;
    private String observacion;
    private List<DetalleVentaDTO> detalle;

    public VentaDTO() {
    }

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public List<DetalleVentaDTO> getDetalle() {
        return detalle;
    }

    public void setDetalle(List<DetalleVentaDTO> detalle) {
        this.detalle = detalle;
    }
    
    
}
