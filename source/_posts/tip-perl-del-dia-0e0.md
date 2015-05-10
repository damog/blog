title: "Tip Perl del día: 0E0"
Date: 2007-10-18 19:59:05
Tags: 
---
<p>Empezaré escribiendo algunos tipcitos que me voy encontrando a mi paso al cabalgar sobre el felpudo lomo del dromedario de Perl durante mi camino por la vida. Las Columnas.pl, tips y otras cosas perlosas podrán revisarse en la categoría &#8216;perl&#8217; de este blog.</p>

<p>Estoy trabajando con algunos contadores. Tengo que agregar un nuevo contador por hora e ir sumando el contador principal durante la hora actual, sin mucho problema, ¿no? Sin embargo, si la hora actual no existe en la base de datos, tengo que crear un nuevo registro. Debido a mi pésima capacidad bajo cualquier cosa que contenga las siglas SQL, tuve que platicar con alguien más para que diera una idea simple y clara de qué hacer.</p>

<p>Intento sumar el contador dada la hora actual, pero si no afectó a ninguna fila, entonces creo la fila. Ese concepto es mucho mejor que hacer un count(*) primero, validar si existe la fila, crearla si no, actualizarla si sí. Para verificar si mi primer query (el &#8220;UPDATE&#8221;) afectó a alguna columna, podemos usar el método do() que provee DBI y que hereda tu DBD favorito, en mi caso, pues no tengo otra alternativa y a final de cuentas me termina valiendo un pepino por el momento, uso DBD::mysql.</p>

<p>do() regresa, en contexto escalar, el número de filas afectadas por el query que se le haya pasado. Sin embargo, y aquí viene lo interesante y el tip del día, utiliza un valor llamado &#8220;0E0&#8221;, una cadena. Si fueron afectadas, digamos, 3 filas por el query, do() regresará ese número, pero si no fue afectada ninguna fila, es decir, cero filas, regresa el valor &#8220;0E0&#8221;, que es básicamente &#8220;cero, pero cierto&#8221;.</p>

<p>Como bien se sabe (y si no sabes, deberías saber), valores como cadenas vacías o ceros, se evalúan como falsas en las operaciones binarias en Perl. Sin embargo, &#8220;0E0&#8221; se traduce a cero, pero con un valor verdadero, lo cual es muy útil para muchos otros casos en los que obtener un cero podamos usar como valor verdadero.</p>

<p>En mi ejemplo, usé:</p>

<p>my $aff_rows = $sth-&gt;do($query);<br/>
if($arr_rows == 0) { # Este bloque se ejecuta }</p>

<p><br/>
Que es diferente a usar:</p>

<p>my $aff_rows = $sth-&gt;do($query);<br/>
if(!$arr_rows){ # Este bloque no }</p>

<p><br/>
El if evalúa si el valor de $arr_rows es cero, que en muchos casos sería validar si es cierto o falso, pero como $aff_rows es en realidad &#8220;cero pero cierto&#8221;, entonces la condición resulta verdadera. En el segundo if, se valida si el valor de $arr_rows no es verdadero, que en casos comunes sería lo mismo que el primer if, pero la validación resulta falsa y no se ejecuta el bloque. Chido, ¿no? :)</p>
