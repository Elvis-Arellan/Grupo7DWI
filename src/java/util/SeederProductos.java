package util;

import DTO.ProductoDTO;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import jakarta.servlet.ServletContext;
import java.io.InputStreamReader;
import java.io.Reader;
import java.lang.reflect.Type;
import java.util.List;


public class SeederProductos {

    private static final String RUTA_PLANTILLA = "/WEB-INF/data/productos_template.json";

    private SeederProductos() {
    }

    public static List<ProductoDTO> leerPlantilla(ServletContext contexto) throws Exception {
        try (Reader reader = new InputStreamReader(
                contexto.getResourceAsStream(RUTA_PLANTILLA), "UTF-8")) {

            Type tipoLista = new TypeToken<List<ProductoDTO>>() {
            }.getType();
            return new Gson().fromJson(reader, tipoLista);
        }
    }
}
