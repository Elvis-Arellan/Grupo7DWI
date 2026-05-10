package DTO;

public class LoginDTO {

    private int id;
    private String userName;
    private String clave;
    private String nombreCompleto;
    //FALTA UN ROL PARA USUARIOS Y ADMINISTRADORES

    public LoginDTO() {
    }

    public LoginDTO(String userName, String clave, String nombreCompleto) {
        this.userName = userName;
        this.clave = clave;
        this.nombreCompleto = nombreCompleto;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public int getId() {
        return id;
    }

    public String getUserName() {
        return userName;
    }

    public String getClave() {
        return clave;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

}
