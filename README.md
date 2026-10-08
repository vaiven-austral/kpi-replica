# kpi-replica

Espejo de la rama `data` de [`lab4-kpis/kpis`](https://github.com/lab4-kpis/kpis): la copia diaria de las mediciones del KPI Challenge de Laboratorio IV. Es la parte (b) de la regla 10 del anexo B de la propuesta: una copia en otra organización, que el dueño del repositorio central no puede tocar. Lo mantiene el equipo 14 (VaiVen).

- [`replicate.yml`](.github/workflows/replicate.yml) corre todos los días a las 07:17 de Buenos Aires, una hora después del export, y se puede correr a mano.
- [`replicate.sh`](replicate.sh) trae `data` **sólo hacia adelante**. Si en el central se reescribe la historia o se borra la rama, la corrida falla y la copia de acá queda intacta: GitHub avisa por mail del workflow fallido.
- Se replica sólo `data` porque el `GITHUB_TOKEN` no puede pushear cambios en workflows. El código ya está en cada clon.

Para restaurar desde acá: `git clone --branch data https://github.com/vaiven-austral/kpi-replica.git` y `scripts/restore-data.sh` del repositorio central (ver su `docs/FUTURE_BACKUP.md`).

Cualquier otro equipo puede hacer su propio espejo: copiar estos dos archivos a un repo propio.
