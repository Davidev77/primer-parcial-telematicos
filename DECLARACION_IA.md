# Declaración del Uso de Inteligencia Artificial

## Herramienta utilizada

Durante el desarrollo de este parcial se utilizó un **agente de IA basado en Claude (Anthropic)**, configurado y guiado específicamente para actuar como un facilitador de aprendizaje sobre los servicios telemáticos evaluados (DNS con BIND9, HTTP con Apache y túneles seguros).

## Cómo se usó

El agente fue empleado como una herramienta de acompañamiento y guía paso a paso, no como un generador automático de soluciones. Su uso se centró en los siguientes puntos:

- **Comprensión de conceptos:** explicación de temas y mecanismos que no habían sido cubiertos en profundidad en el material de clase, como TSIG, NOTIFY, AXFR/IXFR, RRL, y los algoritmos de compresión DEFLATE y Brotli.
- **Generación de comandos clave:** apoyo en la construcción de comandos de configuración (BIND9, Apache, scripts de medición en Bash) explicados línea por línea, para garantizar que el grupo entendiera el propósito de cada instrucción antes de ejecutarla.
- **Resolución de dudas puntuales:** aclaración de errores reales encontrados durante la implementación (por ejemplo, fallos de sintaxis, módulos de Apache mal enlazados, problemas de tipos MIME) mediante diagnóstico guiado en vez de soluciones directas sin contexto.
- **Explicaciones prácticas:** traducción de conceptos técnicos complejos en explicaciones sencillas y con analogías, facilitando su comprensión antes de la implementación.

## Alcance y responsabilidad

Todo el trabajo de configuración, ejecución de comandos, pruebas y validación fue realizado directamente por los integrantes del grupo dentro de las máquinas virtuales. El agente de IA no tuvo acceso ni ejecución directa sobre el entorno de laboratorio; su función fue exclusivamente consultiva y educativa.

El grupo declara estar en capacidad de **explicar y ejecutar cada línea de configuración entregada**, incluyendo los fundamentos teóricos detrás de cada decisión técnica (TSIG, hardening de BIND9, compresión HTTP, exposición segura mediante túneles), tal como lo exige la modalidad de sustentación en vivo del parcial.

## Justificación del uso

El uso de esta herramienta permitió abordar con mayor profundidad conceptos nuevos para el grupo, reducir el tiempo de resolución de errores de configuración, y fortalecer la comprensión práctica de los temas evaluados, sin sustituir el proceso de aprendizaje ni la autoría del trabajo entregado.
