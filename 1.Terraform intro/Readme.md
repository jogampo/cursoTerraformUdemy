### Notas para la sección de 1 Terraform intro.

Es importante destacar que en esta sección he visto el atributo *count* dentro de un recurso.
Este atributo permite indicar cuantas veces se crea este recurso. Un aspecto curioso es que si ponemos el count a 0 nos permite no crear este recurso y si estaba creado destruirlo. De esta forma podemos destruir sólo uno de los recursos. 